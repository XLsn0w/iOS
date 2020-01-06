//
//  HQL5_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 使用仿射变换旋转 45°
 */
@interface HQL5_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 研究可以用来对图层旋转，摆放或者扭曲的 CGAffineTransform，以及可以将扁平物体转换成三维空间对象的 CATransform3D
 
 # 仿射变换
 
 UIView 的 transform 属性是一个 CGAffineTransform 类型，用于在二维空间做旋转，缩放和平移。
 
 CGAffineTransform 中的 “仿射” 的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行。
 
 旋转：CGAffineTransformMakeRotation(CGFloat angle)
 缩放：CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
 平移：CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
 
 UIView 可以通过设置 transform 属性做变换，但实际上它只是封装了内部图层的变换。
 
 CALayer 同样也有一个 transform 属性，但它的类型是 CATransform3D，而不是 CGAffineTransform。
 
 CALayer 对应于 UIView 的 transform 属性叫做 affineTransform。
 
 
 
 
 */
