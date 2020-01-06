//
//  HQL6_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用一个 CAShapeLayer 渲染一个简单的火柴人
 */
@interface HQL6_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAShapeLayer
 
 CAShapeLayer 是一个通过矢量图形而不是 bitmap 来绘制的图层子类。你指定诸如颜色和线宽等属性，用 CGPath 来定义想要绘制的图形，最后 CAShapeLayer 就自动渲染出来了。
 当然，你也可以用 Core Graphics 直接向原始的 CALyer 的内容中绘制一个路径，相比直下，使用 CAShapeLayer 有以下一些优点：
 
 * 渲染快速。CAShapeLayer 使用了硬件加速，绘制同一图形会比用 Core Graphics 快很多。
 * 高效使用内存。一个 CAShapeLayer 不需要像普通 CALayer 一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
 * 不会被图层边界剪裁掉。一个 CAShapeLayer 可以在边界之外绘制。你的图层路径不会像在使用 Core Graphics 的普通 CALayer 一样被剪裁掉（如我们在第二章所见）。
 * 不会出现像素化。当你给 CAShapeLayer 做 3D 变换时，它不像一个有寄宿图的普通图层一样变得像素化。
 
 ## 创建一个 CGPath
 
 CAShapeLayer 可以用来绘制所有能够通过 CGPath 来表示的形状。
 
 你可以控制一些属性比如 lineWith（线宽，用点表示单位），lineCap（线条结尾的样子），和 lineJoin（线条之间的结合点的样子）；
 但是在图层层面你只有一次机会设置这些属性。如果你想用不同颜色或风格来绘制多个形状，就不得不为每个形状准备一个图层了。
 
 CAShapeLayer 属性是 CGPathRef 类型，但是我们用 UIBezierPath 帮助类创建了图层路径，这样我们就不用考虑人工释放 CGPath 了。
 
 ## 圆角
 
 CALayer 的 cornerRadius 属性也可以画圆角。
 
 通过 CAShapeLayer 画圆角的优势是可以单独指定每个角。
 
 */
