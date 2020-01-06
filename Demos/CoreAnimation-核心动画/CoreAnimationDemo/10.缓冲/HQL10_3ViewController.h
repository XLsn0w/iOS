//
//  HQL10_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL10_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 缓冲和关键帧动画
 
 CAKeyframeAnimation 有一个 NSArray 类型的 timingFunctions 属性，我们可以用它来对每次动画的步骤指定不同的计时函数。
 但是指定函数的个数一定要等于 keyframes 数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
 
 
 */
