//
//  HQL2_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL2_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 ------------------------------------
 ## contentsScale 属性
 定义寄宿图的像素尺寸和视图大小的比例，默认情况下它是一个值为 1.0 的浮点数。
 
 contentsScale 属性其实属于支持高分辨率（又称 Hi-DPI 或 Retina）屏幕机制的一部分。
 它用来判断在绘制图层的时候应该为寄宿图创建的空间大小，和需要显示的图片的拉伸度（假设并没有设置 contentsGravity 属性）
 
 如果 contentsScale 设置为 1.0，将会以每个点 1 个像素绘制图片，
 如果设置为 2.0，则会以每个点 2 个像素绘制图片，这就是我们熟知的 Retina 屏幕。
 
 layer.contentsScale = [UIScreen mainScreen].scale;
 
 ------------------------------------
 ## maskToBounds 属性
 是否绘制超出视图边界的内容或者子视图，
 
 通常，设置图片圆角会用到这个属性，如下示例：
 imageView.layer.cornerRadius = 5;
 imageView.layer.masksToBounds = YES;
 
 */
