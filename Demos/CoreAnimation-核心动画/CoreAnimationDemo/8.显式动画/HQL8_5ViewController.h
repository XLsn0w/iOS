//
//  HQL8_5ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用 CATransition 来对 UIImageView 做动画
@interface HQL8_5ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 过渡
 
 过渡动画会影响整个图层，可以用来对图层的任何内容做任何类型的动画，包括子图层的添加和移除。
 
 属性动画只对图层的可动画属性起作用，所以如果要改变一个不能动画的属性（比如图片），或者从层级关系中添加或者移除图层，属性动画将不起作用。
 
 过渡并不像属性动画那样平滑地在两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。
 
 为了创建一个过渡动画，我们将使用 CATransition，同样是另一个 CAAnimation 的子类，和别的子类不同，CATransition 有一个 type 和 subtype 来标识变换效果。
 
 type 属性是一个 NSString 类型，可以被设置成如下类型：
 * kCATransitionFade：平滑的淡入淡出效果
 * kCATransitionMoveIn：顶部滑动进入新图层
 * kCATransitionPush：从边缘滑动进入效果
 * kCATransitionReveal：把原始的图层滑动出去来显示新的外观
 
 后面三种过渡类型都有一个默认的动画方向，它们都从左侧滑入，但是你可以通过 subtype 来控制它们的方向，提供了如下四种类型：
 * kCATransitionFromRight
 * kCATransitionFromLeft
 * kCATransitionFromTop
 * kCATransitionFromBottom
 
 
 # 隐式动画
 
 CATransition 可以对图层任何变化平滑过渡的事实使得它成为那些不好做动画的属性图层行为的理想候选。
 苹果当然意识到了这点，并且当设置了 CALayer 的 content 属性的时候，CATransition 的确是默认的行为。
 但是对于视图关联的图层，或者是其他隐式动画的行为，这个特性依然是被禁用的，
 但是对于你自己创建的图层，这意味着对图层 contents 图片做的改动都会自动附上淡入淡出的动画。
 
 
 # 对图层树的动画
 
 CATransition 并不作用于指定的图层属性，也就是说：你可以在即使不能准确得知改变了什么的情况下对图层做动画。
 
 
 # 自定义动画
 
 过渡是一种对那些不太好做平滑动画属性的强大工具，但是 CATransition 的提供的动画类型太少了。
 
 更奇怪的是苹果通过 UIView 的
 
 +transitionFromView:toView:duration:options:completion:
 +transitionWithView:duration:options:animations:
 
 方法提供了 Core Animation 的过渡特性。
 但是这里的可用的过渡选项和 CATransition 的 type 属性提供的常量完全不同。
 UIView 过渡方法中 options 参数可以由如下常量指定：
 
 typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
     UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
     UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
     UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
     UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
     UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
     UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
     UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
     UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
     UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
     UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
     
     UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
     UIViewAnimationOptionCurveEaseIn               = 1 << 16,
     UIViewAnimationOptionCurveEaseOut              = 2 << 16,
     UIViewAnimationOptionCurveLinear               = 3 << 16,
     
     UIViewAnimationOptionTransitionNone            = 0 << 20, // default
     UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
     UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
     UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
     UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
     UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
     UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
     UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,

     UIViewAnimationOptionPreferredFramesPerSecondDefault     = 0 << 24,
     UIViewAnimationOptionPreferredFramesPerSecond60          = 3 << 24,
     UIViewAnimationOptionPreferredFramesPerSecond30          = 7 << 24,
     
 } API_AVAILABLE(ios(4.0));
 

 
 
 
 */
