//
//  HQL10_7ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL10_7ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 流程自动化
 
 如果我们把动画分割成更小的几部分，那么我们就可以用直线来拼接这些曲线（也就是线性缓冲）。
 
 为了实现自动化，我们需要知道如何做如下两件事情：
 * 自动把任意属性动画分割成多个关键帧；
 * 用一个数学函数表示弹性动画，使得可以对帧做编辑；
 
 为了解决第一个问题，我们需要复制 Core Animation 的插值机制。这是一个传入起点和终点，然后在这两个点之间指定时间点产出一个新点的机制。对于简单的浮点起始值，公式如下：
 
 value = (endValue – startValue) × time + startValue;
 
 这可以起到作用，但效果并不是很好，到目前为止我们所完成的只是一个非常复杂的方式来使用线性缓冲复制 CABasicAnimation 的行为。这种方式的好处在于我们可以更加精确地控制缓冲，这也意味着我们可以应用一个完全定制的缓冲函数。那么该如何做呢？
 
 缓冲背后的数学并不很简单，但是幸运的是我们不需要一一实现它。罗伯特・彭纳有一个网页关于缓冲函数（http://www.robertpenner.com/easing），包含了大多数普遍的缓冲函数的多种编程语言的实现的链接，包括 C。这里是一个缓冲进入缓冲退出函数的示例（实际上有很多不同的方式去实现它）
 
 用 CAKeyframeAnimation 来避开 CAMediaTimingFunction 的限制，创建完全自定义的缓冲函数。
 
 */
