//
//  HQL5_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 视图内的图层绕 Y 轴做了 45 度角的旋转。
 */
@interface HQL5_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 3D 变换
 
 CGAffineTransform 类型属于 Core Graphics 框架，
 Core Graphics 实际上是一个严格意义上的 2D 绘图 API，并且 CGAffineTransform 仅仅对 2D 变换有效。
 
 和 CGAffineTransform 类似，CATransform3D 也是一个矩阵，但是和 2x3 的矩阵不同，CATransform3D 是一个可以在 3 维空间内做变换的 4x4 的矩阵。
 
 和 CGAffineTransform 矩阵类似，Core Animation 提供了一系列的方法用来创建和组合 CATransform3D 类型的矩阵，
 和 Core Graphics 的函数类似，但是 3D 的平移和旋转多处了一个 z 参数，并且旋转函数除了 angle 之外多出了 x,y,z 三个参数，分别决定了每个坐标轴方向上的旋转。
 
 3D 旋转：CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
 3D 缩放：CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
 3D 平移：CATransform3DMakeTranslation(Gloat tx, CGFloat ty, CGFloat tz)
 
 
 */
