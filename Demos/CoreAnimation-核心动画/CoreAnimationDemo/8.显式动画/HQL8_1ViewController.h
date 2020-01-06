//
//  HQL8_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL8_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 显式动画
 
 显式动画，能够对一些属性做指定的自定义动画，或者创建非线性动画，比如沿着任意一条曲线移动。
 
 ## 属性动画
 
 对单独的图层属性做动画，实现更加具体的控制
 
 CAAnimation
 CAAnimationDelegate 委托协议
 用 -animationDidStop:finished: 方法在动画结束之后更新图层的 backgroundColor。
 
 当更新属性的时候，我们需要设置一个新的事务，并且禁用图层行为。否则动画会发生两次，一个是因为显式的 CABasicAnimation，另一次是因为隐式动画。
 
 
 
 */
