//
//  HQL10_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用 UIBezierPath 绘制 CAMediaTimingFunction 缓冲函数
@interface HQL10_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 自定义缓冲函数
 
 CAMediaTimingFunction 函数的主要原则在于它把输入的时间转换成起点和终点之间成比例的改变。
 CAMediaTimingFunction 使用了一个叫做三次贝塞尔曲线的函数，它只可以产出指定缓冲函数的子集
 
 CAMediaTimingFunction 有一个叫做 -getControlPointAtIndex:values: 的方法，可以用来检索曲线的点
 
 
 
 */
