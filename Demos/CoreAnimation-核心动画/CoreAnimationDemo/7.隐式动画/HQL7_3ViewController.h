//
//  HQL7_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 自定义行为 - 推进过渡示例
 */
@interface HQL7_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 我们来对颜色渐变的例子使用一个不同的行为，通过给 colorLayer 设置一个自定义的 actions 字典。
 我们也可以使用委托来实现，但是 actions 字典可以写更少的代码。
 
 使用的一个实现了 CATransaction 的实例，叫做推进过渡。
 知道 CATransition 响应 CAAction 协议，并且可以当做一个图层行为就足够了。
 结果很赞，不论在什么时候改变背景颜色，新的色块都是从左侧滑入，而不是默认的渐变效果。
 
 
 */
