//
//  HQL13_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 将用户的触摸手势转换成一个 UIBezierPath 上的点，然后绘制成视图。
/// 在一个 UIView 子类 DrawingView 中实现了所有的绘制逻辑。
@interface HQL13_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 13. 高效绘图
 
 本章主要内容：研究和 Core Graphics 绘图相关的性能问题，以及如何修复。
 
 绘图通常在 Core Animation 的上下文中指代软件绘图（意即：不由 GPU 协助的绘图）。
 在 iOS 中，软件绘图通常是由 Core Graphics 框架完成来完成。
 但是，在一些必要的情况下，相比 Core Animation 和 OpenGL，Core Graphics 要慢了不少。
 
 软件绘图不仅效率低，还会消耗可观的内存。CALayer 只需要一些与自己相关的内存：只有它的寄宿图会消耗一定的内存空间。即使直接赋给 contents 属性一张图片，也不需要增加额外的照片存储大小。如果相同的一张图片被多个图层作为 contents 属性，那么他们将会共用同一块内存，而不是复制内存块。
 
 但是一旦你实现了 CALayerDelegate 协议中的 -drawLayer:inContext: 方法或者 UIView 中的 -drawRect: 方法（其实就是前者的包装方法），图层就创建了一个绘制上下文，这个上下文需要的大小的内存可从这个算式得出：图层宽 * 图层高 * 4 字节，宽高的单位均为像素。对于一个在 Retina iPad 上的全屏图层来说，这个内存量就是 2048*1526*4 字节，相当于 12MB 内存，图层每次重绘的时候都需要重新抹掉内存然后重新分配。

 软件绘图的代价昂贵，除非绝对必要，你应该避免重绘你的视图。提高绘制性能的秘诀就在于尽量避免去绘制。
 
 ## 矢量图形
 
 使用 Core Graphics 绘图的通常原因就是：只是用图片或是图层效果不能轻易地绘制出矢量图形。
 
 矢量绘图包含一下这些：
 * 任意多边形（不仅仅是一个矩形）
 * 斜线或曲线
 * 文本
 * 渐变
 
 
 */
