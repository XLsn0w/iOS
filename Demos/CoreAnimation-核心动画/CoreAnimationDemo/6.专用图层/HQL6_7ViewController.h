//
//  HQL6_7ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用 CAScrollLayer 模拟 UIScrollView
 */
@interface HQL6_7ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAScrollLayer
 
 对于一个未转换的图层，它的 bounds 和它的 frame 是一样的，frame 属性是由 bounds 属性自动计算而出的，所以更改任意一个值都会更新其他值。
 
 CAScrollLayer 的 -scrollToPoint: 方法：它自动适应 bounds 的原点以便图层内容出现在滑动的地方。
 
 我们将会用 CAScrollLayer 作为视图的宿主图层，并创建一个自定义的 UIView，然后用 UIPanGestureRecognizer 实现触摸事件响应。
 
 - (void)scrollPoint:(CGPoint)p;
 - (void)scrollRectToVisible:(CGRect)r;
 @property(readonly) CGRect visibleRect;
 
 scrollPoint: 方法从图层树中查找并找到第一个可用的 CAScrollLayer，然后滑动它使得指定点成为可视的。
 scrollRectToVisible: 方法实现了同样的事情只不过是作用在一个矩形上的。
 visibleRect 属性决定图层（如果存在的话）的哪部分是当前的可视区域。
 
 如果你自己实现这些方法就会相对容易明白一点，但是 CAScrollLayer 帮你省了这些麻烦，所以当涉及到实现图层滑动的时候就可以用上了。
 
 */
