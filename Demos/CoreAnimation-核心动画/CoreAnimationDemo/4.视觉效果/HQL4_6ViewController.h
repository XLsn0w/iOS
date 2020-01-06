//
//  HQL4_6ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 一个简单的运用拼合技术显示的 LCD 数字风格的像素字体
 
 用 LCD 风格的数字方式显示时钟。
 用简单的像素字体（一种用像素构成字符的字体，而非矢量图形）创造数字显示方式，用图片存储起来，而且用第二章介绍过的拼合技术来显示（
 
 */
@interface HQL4_6ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 拉伸过滤
 
 minificationFilter 和 magnificationFilter 属性。
 
 总得来讲，当视图显示一张图片的时候，都应该正确地显示这张图片（意即：以正确的比例和正确的 1：1 像素显示在屏幕上）。
 原因如下：
 * 能够显示最好的画质，像素既没有被压缩也没有被拉伸。
 * 能更好的使用内存，因为这就是所有你要存储的东西。
 * 最好的性能表现，CPU 不需要为此额外的计算。
 
 当图片需要显示不同的大小的时候，有一种叫做拉伸过滤的算法就起到作用了。
 它作用于原图的像素上并根据需要生成新的像素显示在屏幕上。
 
 事实上，重绘图片大小也没有一个统一的通用算法。这取决于需要拉伸的内容，放大或是缩小的需求等这些因素。CALayer 为此提供了三种拉伸过滤方法，他们是：
 
 * kCAFilterLinear - 双线性滤波算法
 * kCAFilterNearest - 三线性滤波算法
 * kCAFilterTrilinear - 最近过滤算法
 
 minification（缩小图片）和 magnification（放大图片）默认的过滤器都是 kCAFilterLinear，这个过滤器采用双线性滤波算法，它在大多数情况下都表现良好。
 双线性滤波算法通过对多个像素取样最终生成新的值，得到一个平滑的表现不错的拉伸。但是当放大倍数比较大的时候图片就模糊不清了。
 
 kCAFilterTrilinear 和 kCAFilterLinear 非常相似，大部分情况下二者都看不出来有什么差别。
 但是，较双线性滤波算法而言，三线性滤波算法存储了多个大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进而得到最后的结果。
 
 kCAFilterNearest 是一种比较武断的方法。从名字不难看出，这个算法（也叫最近过滤）就是取样最近的单像素点而不管其他的颜色。这样做非常快，也不会使图片模糊。但是，最明显的效果就是，会使得压缩图片更糟，图片放大之后也显得块状或是马赛克严重。
 
 */
