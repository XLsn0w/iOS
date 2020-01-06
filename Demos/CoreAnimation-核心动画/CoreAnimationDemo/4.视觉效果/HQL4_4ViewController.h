//
//  HQL4_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 创建简单的阴影形状
 */
@interface HQL4_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # ShadowPath
 
 我们已经知道图层阴影并不总是方的，而是从图层内容的形状继承而来。
 
 如果你事先知道你的阴影形状会是什么样子的，你可以通过指定一个 shadowPath 来提高性能。
 shadowPath 是一个 CGPathRef 类型（一个指向 CGPath 的指针）。
 CGPath 是一个 Core Graphics 对象，用来指定任意的一个矢量图形。我们可以通过这个属性单独于图层形状之外指定阴影的形状。
 
 如果是一个矩形或者是圆，用 CGPath 会相当简单明了。
 但是如果是更加复杂一点的图形，UIBezierPath 类会更合适，它是一个由 UIKit 提供的在 CGPath 基础上的 Objective-C 包装类。
 
 
 
 
 */
