//
//  NSObject+KVO.m
//  YMTools
//
//  Created by jike on 2018/1/8.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/objc.h>

NSString *const kYMKVOClassPrefix = @"YMKVOClassPrefix_";
NSString *const kYMKVOAssociatedObservers = @"YMKVOAssociatedObservers";

#pragma mark - YMObservationInfo
@interface YMObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) YMObserveingBlock block;

@end

@implementation YMObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(YMObserveingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}
@end


// -MARK: Helpers
static NSString * setterForGetter(NSString *getter)
{
    if (getter.length <= 0) {
        return nil;
    }
    
    // upper case the first letter
    NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
    NSString *remainingLetters = [getter substringFromIndex:1];
    
    // add 'set' at the begining and ':' at the end
    NSString *setter = [NSString stringWithFormat:@"set%@%@:",firstLetter, remainingLetters];
    
    return setter;
}

static NSString * getterForSetter(NSString *setter)
{
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    
    return key;
}

static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

#pragma mark - Overridden Methods
static void kvo_setter(id self, SEL _cmd, id newValue)
{
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // look up observers and call the blocks
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kYMKVOAssociatedObservers));
    for (YMObservationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
}
@implementation NSObject (KVO)
/*
 1.检查对象的类有没有相应的 setter 方法。如果没有抛出异常；
 2.检查对象 isa 指向的类是不是一个 KVO 类。如果不是，新建一个继承原来类的子类，并把 isa 指向这个新建的子类；
 3.检查对象的 KVO 类重写过没有这个 setter 方法。如果没有，添加重写的 setter 方法；
 4.添加这个观察者
 */
-(void)YM_addObserver:(NSObject *)observer
               forKey:(NSString *)key
            withBlock:(YMObserveingBlock)block
{
    // step 1: Throw exception if its class or superclasses doesn't implement the setter
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class ], setterSelector);
    if (!setterMethod) {
        //抛出异常
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    Class clazz = object_getClass(self);
    NSString *clazzName = NSStringFromClass(clazz);
    
    // Step 2: Make KVO class if this is first time adding observer and
    //          its class is not an KVO class yet
    if (![clazzName hasPrefix:kYMKVOClassPrefix]) {
        clazz = [self makeKvoClassWithOriginalClassName:clazzName];
        
        /*将一个对象设置为别的类类型，返回原来的Class.
         目的：将self的isa指针指向clazz
         */
        object_setClass(self, clazz);
    }
    
    // Step 3: Add our kvo setter method if its class (not superclasses)
    //          hasn't implemented the setter
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        
        // 给类添加方法
        class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    }
   
    // Step 4: Add this observation info to saved observation objects
    YMObservationInfo *info = [[YMObservationInfo alloc] initWithObserver:observer Key:key block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kYMKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        
        /*
         关联对象：
         第一个参数是主对象，第二个参数是键，第三个参数是关联的对象，第四个参数是存储策略:是枚举，定义了内存管理语义。
         */
        objc_setAssociatedObject(self, (__bridge const void *)(kYMKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info]; 
}

- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName
{
    NSString *kvoClazzName = [kYMKVOClassPrefix stringByAppendingString:originalClazzName];
    Class clazz = NSClassFromString(kvoClazzName);
    
    if (clazz) {
        return clazz;
    }
    
    //class doesn't exist yet, make it
    Class originalClazz = object_getClass(self);
    
    /*创建一个新类
     originalClazz:父类
     kvoClazzName:类的名字
     0:类占的空间，通常为0
     */
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    // grad class method's signature so we can borrow it
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    
    // 注册类
    objc_registerClassPair(kvoClazz);
    
    return kvoClazz;
}

- (BOOL)hasSelector:(SEL)selector
{
    Class clazz = object_getClass(self);
    unsigned int methodCount = 0;
    
    /*
     class_copyMethodList:获取类的方法和属性
     */
    Method *methodList = class_copyMethodList(clazz, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

// -MARK: remove the observer
-(void)YM_removeObserver:(NSObject *)observer forKey:(NSString *)key {
    NSMutableArray *observers =objc_getAssociatedObject(self, &kYMKVOAssociatedObservers);
    YMObservationInfo *removedInfo;
    for (YMObservationInfo *info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            removedInfo = info;
            break;
        }
    }
    [observers removeObject:removedInfo];
}
















@end
