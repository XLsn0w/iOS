//
//  HQL8_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL8_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAKeyframeAnimation 关键帧动画
 
 和 CABasicAnimation 类似，CAKeyframeAnimation 同样是 CAPropertyAnimation 的一个子类，它依然作用于单一的一个属性，
 但是和 CABasicAnimation 不一样的是，它不限制于设置一个起始和结束的值，而是可以根据一连串随意的值来做动画。
 
 CAKeyframeAnimation 原理：你提供了显著（关键）的帧，然后 Core Animation 在每帧之间进行插入。
 
 
 # CAKeyframeAnimation 的 CGPath
 CAKeyframeAnimation 有另一种方式去指定动画，就是使用 CGPath。
 path 属性可以用一种直观的方式，使用 Core Graphics 函数定义运动序列来绘制动画。
 

 
 */
