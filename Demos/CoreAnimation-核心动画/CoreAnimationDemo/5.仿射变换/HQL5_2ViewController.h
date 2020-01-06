//
//  HQL5_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 混合变换
 
 先缩小 50%，再旋转 30 度，最后向右移动 200 个像素
 */
@interface HQL5_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 混合变换
 
 Core Graphics 提供了一系列的函数可以在一个变换的基础上做更深层次的变换，如果做一个既要缩放又要旋转的变换，这就会非常有用了。
 
 CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
 CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
 CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
 
 当操纵一个变换的时候，初始生成一个什么都不做的变换很重要 -- 也就是创建一个 CGAffineTransform 类型的空值，矩阵论中称作「单位矩阵」，
 Core Graphics 同样也提供了一个方便的常量：
 单位矩阵：CGAffineTransformIdentity
 
 最后，如果需要混合两个已经存在的变换矩阵，就可以使用如下方法，在两个变换的基础上创建一个新的变换：
 CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2);
 
 
 
 */
