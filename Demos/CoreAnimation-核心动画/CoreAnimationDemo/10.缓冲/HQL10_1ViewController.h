//
//  HQL10_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL10_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END


/*
 # 10. 缓冲
 
 Core Animation 使用缓冲来使动画移动更平滑更自然，而不是看起来的那种机械和人工，在这一章我们将要研究如何对你的动画控制并自定义缓冲曲线。
 
 ## 动画速度
 
 动画实际上就是一段时间内的变化，这就暗示了变化一定是随着某个特定的速率进行。
 
 速率公示：velocity = change / time
 
 现实生活中的任何一个物体都会在运动中加速或者减速。那么我们如何在动画中实现这种加速度呢？
 一种方法是使用物理引擎来对运动物体的摩擦和动量来建模，然而这会使得计算过于复杂。我们称这种类型的方程为缓冲函数，
 幸运的是，Core Animation 内嵌了一系列标准函数提供给我们使用。
 
 ## CAMediaTimingFunction
 
 那么该如何使用缓冲方程式呢？首先需要设置 CAAnimation 的 timingFunction 属性，是 CAMediaTimingFunction 类的一个对象。如果想改变隐式动画的计时函数，同样也可以使用 CATransaction 的 +setAnimationTimingFunction: 方法。
 
 CAMediaTimingFunction 是一个通过控制动画缓冲来模拟物理效果例如加速或者减速来增强现实感的东西。
 
 调用 +timingFunctionWithName: 构造方法创建 CAMediaTimingFunction 对象。参数：
 
 kCAMediaTimingFunctionLinear 选项创建了一个线性的计时函数，默认。
 kCAMediaTimingFunctionEaseIn 选项创建了一个慢慢加速然后突然停止的方法
 kCAMediaTimingFunctionEaseOut 以一个全速开始，然后慢慢减速停止。
 kCAMediaTimingFunctionEaseInEaseOut 创建了一个慢慢加速然后再慢慢减速的过程。
 kCAMediaTimingFunctionDefault 同上，但是加速和减速的过程都稍微有些慢

 */
