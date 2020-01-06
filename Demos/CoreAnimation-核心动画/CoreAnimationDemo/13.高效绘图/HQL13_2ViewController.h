//
//  HQL13_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL13_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 将用户的触摸手势转换成一个 UIBezierPath 上的点，然后绘制成视图。
 在一个 UIView 子类 DrawingView 中实现了所有的绘制逻辑。
 
 这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降。看来我们需要一个更好的方法了。
 
 Core Animation 为这些图形类型的绘制提供了专门的类，并给他们提供硬件支持（第六章『专有图层』有详细提到）。CAShapeLayer 可以绘制多边形，直线和曲线。CATextLayer 可以绘制文本。CAGradientLayer 用来绘制渐变。这些总体上都比 Core Graphics 更快，同时他们也避免了创造一个寄宿图。
 
 如果稍微将之前的代码变动一下，用 CAShapeLayer 替代 Core Graphics，性能就会得到提高. 虽然随着路径复杂性的增加，绘制性能依然会下降，但是只有当非常非常浮躁的绘制时才会感到明显的帧率差异。
 
 */
