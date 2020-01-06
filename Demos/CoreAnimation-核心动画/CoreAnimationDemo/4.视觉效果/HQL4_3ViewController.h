//
//  HQL4_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL4_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 ## 阴影
 
 ### shadowOpacity
 
 给 shadowOpacity 属性赋值一个大于默认值（也就是 0）的值，阴影就可以显示在任意图层之下。
 shadowOpacity 是一个必须在 0.0（不可见）和 1.0（完全不透明）之间的浮点数。
 如果设置为 1.0，将会显示一个有轻微模糊的黑色阴影稍微在图层之上。
 
 若要改动阴影的表现，你可以使用 CALayer 的另外三个属性：shadowColor，shadowOffset 和 shadowRadius
 
 
 ### shadowColor
 
 shadowColor 属性控制着阴影的颜色，和 borderColor 和 backgroundColor 一样，它的类型也是 CGColorRef。
 阴影默认是黑色
 
 
 ### shadowOffset
 
 shadowOffset 属性控制着阴影的方向和距离。
 它是一个 CGSize 的值，宽度控制这阴影横向的位移，高度控制着纵向的位移。
 shadowOffset 的默认值是 {0, -3}，意即阴影相对于 Y 轴有 3 个点的向上位移。

 
 ### shadowRadius
 
 shadowRadius 属性控制着阴影的模糊度，
 当它的值是 0 的时候，阴影就和视图一样有一个非常确定的边界线。
 当值越来越大的时候，边界线看上去就会越来越模糊和自然。
 苹果自家的应用设计更偏向于自然的阴影，所以一个非零值再合适不过了。
 
 
 ## 阴影裁剪
 
 和图层边框不同，图层的阴影继承自内容的外形，而不是根据边界和角半径来确定。
 为了计算出阴影的形状，Core Animation 会将寄宿图（包括子视图，如果有的话）考虑在内，然后通过这些来完美搭配图层形状从而创建一个阴影。
 
 阴影是根据寄宿图的轮廓来确定的。
 
 maskToBounds 属性会裁剪掉阴影和内容。
 
 
 
 
 */
