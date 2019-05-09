//
//  TouchView.m
//  YMTools
//
//  Created by longxian on 2018/3/28.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "TouchView.h"
#import <Masonry.h>
/**
 作者：刘小壮
 链接：https://www.jianshu.com/p/b0884faae603
 */

/**
 1.查找第一响应者:
 1.1 从keywindow开始，向前逐级遍历子视图，不断调用UIView的hitTest:withEvent:方法，在查找的点击区域的视图后，并继续调用返回视图的子视图的hitTest:withEvent:方法，以此类推。如果子视图不在点击区域或者没有子视图，则当前视图就是第一响应者。
 
 1.2 在hitTest:withEvent:中会调用pointInside:withEvent:方法从上到下遍历子视图，来找到点击区域内且最上面的子视图。如果找到子视图则调用其hitTest:withEvent:方法，并继续执行这个流程，以此类推。如果子视图不在点击区域内，则忽略这个视图及其子视图，继续遍历其他视图。
 
 1.3 如果点击事件是发生在视图外，但在其子视图内部，子视图也不能接受事件并成为第一响应者。因为在父视图进行hitTest:withEvent:时，就会将其忽略掉
 
 可以通过重写对应的方法，控制遍历过程。通过重写pointInside:withEvent:方法，来做自己的判断并返回YES或NO，返回点击区域是否在视图上。通过重写hitTest:withEvent:方法，返回被点击的视图。
 
 2. 事件传递
 传递过程
 2.1 UIApplication接收到事件，将事件传递给keyWindow。
 2.2 keyWindow遍历subViews的hitTest:withEvent:方法，找到点击区域内合适的视图来处理事件。
 2.3 UIView的子视图也会遍历其subViews的hitTest:withEvent:方法，以此类推。
 2.4 直到找到点击区域内，且处于最上方的视图，将视图逐步返回给UIApplication。
 2.5 在查找第一响应者的过程中，已经形成了一个响应者链。
 2.6 应用程序会先调用第一响应者处理事件。
 2.7 如果第一响应者不能处理事件，则调用其nextResponder方法，一直找响应者链中能处理该事件的对象。
 2.8 最后到UIApplication后仍然没有能处理该事件的对象，则该事件被废弃。
 
 
 3.事件控制
 3.1 事件拦截
 有时候想让指定视图来响应事件，不在向其子视图继续传递事件，可以通过重写hitTest:withEvent:方法。在执行到方法后，直接将该视图返回，而不再继续遍历子视图，这样响应链额的终端就是当前视图。
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
 return self;
 }
 
 3.2 事件传递
 开发中遇到子视图显示范围超出父视图的情况，此时可以重写该视图的pointInside:withEvent:方法，将点击区域扩大到能够覆盖所有子视图。
 
 3.3 事件逐级传递
 如果想让响应者链中，每一级UIResponder都可以响应事件，可以在每级UIResponder中都实现touches并调用super方法，即可实现响应者链事件逐级传递。
 只不过这并不包含UIControl子类以及UIGestureRecognizer的子类，这两类会直接打断响应者链。
 
 3.3.0 Gesture Recognizer
 
 如果有事件到来时，视图有附加的手势识别器，则手势识别器优先处理事件。如果事件处理器没有处理事件，则讲事件交给视图处理，视图如果未处理则应顺着响应者链继续向后传递。
 当响应者链和手势同时出现时，也就是既实现了touches方法又添加了手势，会发现touches方法有时会失效，这是因为手势的执行优先级是高于响应者链的。
 事件到来后先会执行hitTest和pointInside操作，通过这两个方法找到第一响应者，这个在上面已经详细讲过了。当找到第一响应者并将其返回给UIApplication后，UIApplication会向第一响应者派发事件，并且遍历整个响应者链。如果响应者链中能够处理当前事件的手势，则将事件交给手势处理，并调用touches的cancelled方法将响应者链取消。
 根据苹果的官方文档，手势不参与响应者链传递事件，但是也通过hitTest的方式查找响应的视图，手势和响应者链一样都需要通过hitTest方法来确定响应者链的。在UIApplication向响应者链派发消息时，只要响应者链中存在能够处理事件的手势，则手势响应事件，如果手势不在响应者链中则不能处理事件。
 
 3.3.1 UIControl
 根据上面的手势和响应者链的处理规则，我们会发现UIButton或者UISlider等控件，并不符合这个处理规则。UIButton可以在其父视图已经添加tapGestureRecognizer的情况下，依然正常响应事件，并且tap手势不响应。
 以UIButton为例，UIButton也是通过hitTest的方式查找第一响应者的。区别在于，如果UIButton是第一响应者，则直接由UIApplication派发事件，不通过Responder Chain派发。如果其不能处理事件，则交给手势处理或响应者链传递。
 
 不止UIButton是直接由UIApplication派发事件的，所有继承自UIControl的类，都是由UIApplication直接派发事件的。
 
 总结：
 当事件到来时，会通过hitTest和pointInside两个方法，从Window开始向上面的视图查找，找到第一响应者的视图。找到第一响应者后，系统会判断其是继承自UIControl还是UIResponder，如果是继承自UIControl，则直接通过UIApplication直接向其派发消息，并且不再向响应者链派发消息。
 
 如果是继承自UIResponder的类，则调用第一响应者的touchesBegin，并且不会立即执行touchesEnded，而是调用之后顺着响应者链向后查找。如果在查找过程中，发现响应者链中有的视图添加了手势，则进入手势的代理方法中，如果代理方法返回可以响应这个事件，则将第一响应者的事件取消，并调用其touchesCanceled方法，然后由手势来响应事件。
 
 如果手势不能处理事件，则交给第一响应者来处理。如果第一响应者也不能响应事件，则顺着响应者链继续向后查找，直到找到能够处理事件的UIResponder对象。如果找到UIApplication还没有对象响应事件的话，则将这次事件丢弃。
 
 
 小技巧：
 在开发中，有时会有找到当前View对应的控制器的需求，这时候就可以利用我们上面所学，根据响应者链来找到最近的控制器。
 
 在UIResponder中提供了nextResponder方法，通过这个方法可以找到当前响应环节的上一级响应对象。可以从当前UIView开始不断调用nextResponder，查找上一级响应者链的对象，就可以找到离自己最近的UIViewController。
 
 示例代码：
 
 - (UIViewController *)parentController {
 UIResponder *responder = [self nextResponder];
 while (responder) {
 if ([responder isKindOfClass:[UIViewController class]]) {
 return (UIViewController *)responder;
 }
 responder = [responder nextResponder];
 }
 return nil;
 }
 */
@interface TouchView()

/** Button */
@property (strong, nonatomic)UIButton *btn;

@end


@implementation TouchView

/**
 可以重写hitTest:withEvent:返回按钮为第一响应者。
 或者重写pointInside:withEvent方法,改变
 */
// 在view中重写以下方法，其中self.button就是那个希望被触发点击事件的按钮
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil) {
//        /* 转换坐标系:(lldb) po newPoint
//        (x = 26.5, y = 8.5)
//        (lldb) po point
//        (x = 26.5, y = -16.5)
//         */
//        CGPoint newPoint = [self.btn convertPoint:point fromView:self];
//        // 判断触摸点是否在button上
//        if (CGRectContainsPoint(self.btn.bounds, newPoint)) {
//            view = self.btn;
//        }
//    }
//    return view;
//}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInside = [super pointInside:point withEvent:event];
    if (!pointInside) {
        CGPoint newP = [self.btn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.btn.bounds, newP)) {
            return YES;
        }
    }
    return pointInside;
}


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.btn.backgroundColor = [UIColor cyanColor];
}

#pragma mark - response
- (void)btnClick {
    NSLog(@"be clicked");
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesBegan");
//}


-(UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor redColor];
        [self addSubview:_btn];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(-25);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }
    return _btn;
}





@end
