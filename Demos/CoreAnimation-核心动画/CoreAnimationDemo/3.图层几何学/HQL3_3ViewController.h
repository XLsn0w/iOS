//
//  HQL3_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL3_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # Hit Testing
 
 CALayer 并不关心任何响应链事件，所以不能直接处理触摸事件或者手势。
 但是它有一系列的方法帮你处理事件：
 * -containsPoint:
 * -hitTest:
 
 -containsPoint: 接受一个在本图层坐标系下的 CGPoint，如果这个点在图层 frame 范围内就返回 YES。
 
 
 */
