//
//  HQL8_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL8_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 虚拟属性
 
 属性动画实际上是针对于关键路径而不是一个键，这就意味着可以对子属性甚至是虚拟属性做动画。
 
 考虑一个旋转的动画：如果想要对一个物体做旋转的动画，那就需要作用于 transform 属性，因为 CALayer 没有显式提供角度或者方向之类的属性。
 
 
 如果需要独立于角度之外单独对平移或者缩放做动画呢？
 为了旋转图层，我们可以对 transform.rotation 关键路径应用动画，而不是 transform 本身。
 
 用 transform.rotation 而不是 transform 做动画的好处如下：
 * 我们可以不通过关键帧一步旋转多于 180 度的动画。
 * 可以用相对值而不是绝对值旋转（设置 byValue 而不是 toValue）。
 * 可以不用创建 CATransform3D，而是使用一个简单的数值来指定角度。
 * 不会和 transform.position 或者 transform.scale 冲突（同样是使用关键路径来做独立的动画属性）
 
 transform.rotation 属性有一个奇怪的问题是它其实并不存在。
 这是因为 CATransform3D 并不是一个对象，它实际上是一个结构体，也没有符合 KVC 相关属性，transform.rotation 实际上是一个 CALayer 用于处理动画变换的虚拟属性。
 
 你不可以直接设置 transform.rotation 或者 transform.scale，他们不能被直接使用。
 当你对他们做动画时，Core Animation 自动地根据通过 CAValueFunction 来计算的值来更新 transform 属性。
 
 CAValueFunction 用于把我们赋给虚拟的 transform.rotation 简单浮点值转换成真正的用于摆放图层的 CATransform3D 矩阵值。
 你可以通过设置 CAPropertyAnimation 的 valueFunction 属性来改变，于是你设置的函数将会覆盖默认的函数。
 
 CAValueFunction 看起来似乎是对那些不能简单相加的属性（例如变换矩阵）做动画的非常有用的机制，但由于 CAValueFunction 的实现细节是私有的，所以目前不能通过继承它来自定义。你可以通过使用苹果目前已经提供的常量（目前都是和变换矩阵的虚拟属性相关，所以没太多使用场景了，因为这些属性都有了默认的实现方式）。
 
 */
