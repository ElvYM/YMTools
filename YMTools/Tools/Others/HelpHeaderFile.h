//
//  HelpHeaderFile.h
//  YMTools
//
//  Created by jike on 17/3/17.
//  Copyright © 2017年 YM. All rights reserved.
//

#ifndef HelpHeaderFile_h
#define HelpHeaderFile_h

/**
 // MARK: 屏幕适配宏
 */
#define kHeight ([UIScreen mainScreen].bounds.size.height)
#define kWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenScaleX ([UIScreen mainScreen].bounds.size.width/375.0)
#define ScreenScaleY ([UIScreen mainScreen].bounds.size.height/667.0)


// MARK: 系统版本
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]

/** iPhone */
#define YM_isIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** iPad */
#define YM_isIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** ipod */
#define YM_isIpod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 判断 iOS 8 或更高的系统版本 */
#define YM_IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? (YES) : (NO))

//是否是空对象
#define YMIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)


//***************************************************************//
//  系统函数
//***************************************************************//
/*
 // MARK: 读取本地图片, 前两种宏性能高，省内存
 */
#define IMAGECONTENTSOFFILE(imageFile, fileType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageFile ofType:fileType]]
#define IMAGE(imageFile) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageFile ofType:nil]] //定义UIImage对象
#define ImageNamed(imageFile) [UIImage imageNamed:[UIImage imageName:imageFile]] //定义UIImage对象

/** 获取当前语言 */
#define YM_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 沙盒目录文件 */
#define YM_kPathTemp NSTemporaryDirectory()
#define YM_kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define YM_kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/** App版本号 */
#define YM_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//***************************************************************//
//  懒加载函数
//***************************************************************//
/**
 *  懒加载属性,class 初始化方法为init,使用方法见github
 *  @param __CLASS    属性类型
 *  @param __PROPERTY 属性定义值
 *  @return 属性
 */

#define TF_LAZYLOAD_OBJC(__CLASS,__PROPERTY)\
TF_SYNTHESIZE(__PROPERTY);\
-(__CLASS *)__PROPERTY{\
if (!_##__PROPERTY)\
_##__PROPERTY = [[__CLASS alloc]init];\
return _##__PROPERTY;}

//***************************************************************//
//  系统单例
//***************************************************************//
// More fast way to get app delegate
#define YM_AppDelegate ((AppDelegate *) [[UIApplication sharedApplication] delegate])

/** 通知 */
#define YM_NotificationDefaultCenter [NSNotificationCenter defaultCenter]

/** 沙盒 */
#define YM_UserDefault [NSUserDefaults standardUserDefaults]


//***************************************************************//
//  判断
//***************************************************************//
// Judge whether it is an empty string.
#define YM_kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

// Judge whether it is a nil or null object.
#define YM_kIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// Judge whether it is a vaid dictionary.
#define YM_kIsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

// Judge whether it is a valid array.
#define YM_kIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

//***************************************************************//
//  颜色设置
//***************************************************************//
/** RGB色值 */
#define YM_RGBA(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define YM_RGB(R, G, B) YM_RGBA(R, G, B, 1.0)

/** 随机色 */
#define YMRandomColor [UIColor colorWithRed:arc4random_uniform(256) % 255.0 green:arc4random_uniform(256) % 255.0 blue:arc4random_uniform(256) % 255.0 alpha:1.0]


/** 16进制 */
#define YM_ColorFromRGB(rgbValue) [UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float) (rgbValue & 0xFF)) / 255.0 alpha:1.0]

//***************************************************************//
//  自定义打印
//***************************************************************//
#ifdef DEBUG
#define DLog(format, ...)                                                                  \
do {                                                                                   \
fprintf(stderr, "<%s : %d> %s\n",                                                  \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__);                                                       \
(NSLog)((format), ##__VA_ARGS__);                                                  \
fprintf(stderr, "-------\n");                                                      \
} while (0)
#else
#define DLog(s, ...)
#endif

#define NSLogRect(rect) DLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) DLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) DLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

//***************************************************************//
//  快速创建单例
//***************************************************************//


// Default
static NSString * const TimeFormatDefault = @"yyyy-MM-dd";

static NSString *HH = @"HH";
static NSString *mm = @"mm";
static NSString *ss = @"ss";
static NSString *HHmmss = @"HH:mm:ss";

static NSString *YYYY = @"YYYY";
static NSString *YY = @"YY";
static NSString *MM = @"MM";
static NSString *dd = @"dd";

static NSString *MM_dd = @"MM-dd";
static NSString *MM_dd_HHmm = @"MM-dd HH:mm";
static NSString *YY_MM_dd = @"YY-MM-dd";
static NSString *YYYY_MM_dd = @"YYYY-MM-dd";
static NSString *YYYY_MM_ddHHmmss = @"YYYY-MM-dd HH:mm:ss";

static NSString *MMdd = @"MM.dd";
static NSString *YYMMdd = @"YY.MM.dd";
static NSString *YYYYMMdd = @"YYYY.MM.dd";
static NSString *YYYYMMddHHmmss = @"YYYY.MM.dd HH:mm:ss";

#endif /* HelpHeaderFile_h */
