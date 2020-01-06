//
//  HQL2_5ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL2_5ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 用 Core Graphics 直接绘制寄宿图
 
 通过继承 UIView 并实现 -drawRect: 方法实现自定义绘图。
 
 -drawRect: 方法没有默认的实现，因为对 UIView 来说，寄宿图并不是必须的，它不在意那到底是单调的颜色还是有一个图片的实例。
 如果 UIView 检测到 -drawRect: 方法被调用了，它就会为视图分配一个寄宿图，这个寄宿图的像素尺寸等于视图大小乘以 contentsScale 的值（💡 因此，实现 -drawRect: 方法会占用大量内存）。
 如果你不需要寄宿图，那就不要创建这个方法了，这会造成 CPU 资源和内存的浪费，
 这也是为什么苹果建议：如果没有自定义绘制的任务就不要在子类中写一个空的 - drawRect: 方法
 
 CALayer 有一个可选的 delegate 属性，实现了 CALayerDelegate 协议，
 当 CALayer 需要一个内容特定的信息时，就会从协议中请求。
 - (void)displayLayer:(CALayerCALayer *)layer;
 
 如果代理不实现 -displayLayer: 方法，CALayer 就会转而尝试调用下面这个方法：
 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
 
 除非你创建了一个单独的图层，你几乎没有机会用到 CALayerDelegate 协议。
 因为当 UIView 创建了它的宿主图层时，它就会自动地把图层的 delegate 设置为它自己，并提供了一个 -displayLayer: 的实现
 
 当使用寄宿了视图的图层的时候，你也不必实现 -displayLayer: 和 -drawLayer:inContext: 方法来绘制你的寄宿图。
 通常做法是实现 UIView 的 -drawRect: 方法，UIView 就会帮你做完剩下的工作，包括在需要重绘的时候调用 -display 方法。
 */
