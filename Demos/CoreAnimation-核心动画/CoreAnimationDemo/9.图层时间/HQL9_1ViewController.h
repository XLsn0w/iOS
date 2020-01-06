//
//  HQL9_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL9_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 9.图层时间
 
 ## CAMediaTiming 协议
 
 CAMediaTiming 协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer 和 CAAnimation 都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。
 
 ## 持续和重复
 
 duration 是 CAMediaTiming 的属性之一。
 duration 是一个 CFTimeInterval 的类型（类似于 NSTimeInterval 的一种双精度浮点类型），对将要进行的动画的“一次迭代”指定了时间。
 
 CAMediaTiming 另外还有一个属性叫做 repeatCount，代表动画重复的迭代次数。
 如果 duration 是 2，repeatCount 设为 3.5（三个半迭代），那么完整的动画时长将是 7 秒。
 
 duration 和 repeatCount 默认都是 0。
 但这不意味着动画时长为 0 秒，或者 0 次，这里的 0 仅仅代表了 “默认”，也就是 0.25 秒和 1 次。
 
 */
