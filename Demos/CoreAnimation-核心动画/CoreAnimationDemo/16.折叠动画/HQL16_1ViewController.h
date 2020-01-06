//
//  HQL16_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/28.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL16_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 背面
 
 我们既然可以在 3D 场景下旋转图层，那么也可以从背面去观察它。如果我们在清单 5.4 中把角度修改为 M_PI（180 度）而不是当前的 M_PI_4（45 度），那么将会把图层完全旋转一个半圈，于是完全背对了相机视角。
 
 如你所见，图层是双面绘制的，反面显示的是正面的一个镜像图片。
 
 CALayer 有一个叫做 doubleSided 的属性来控制图层的背面是否要被绘制。
 这是一个 BOOL 类型，默认为 YES，如果设置为 NO，那么当图层正面从相机视角消失的时候，它将不会被绘制。

 */
