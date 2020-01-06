//
//  HQL10_6ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用关键帧动画实现反弹动画
@interface HQL10_6ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 更加复杂的动画曲线
（看上去有点像 UIView 的 spring 动画）
 
 
 使用关键帧实现反弹动画，实现方式笨重，需要手动计算所有关键帧动画时间位置。如果修改某一个属性，那么需要全部重新计算。
 
 
 */
