//
//  HQL4_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL4_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 视觉效果
 
 通过使用 CALayer 属性实现的视觉效果
 
 ## 圆角
 
 CALayer 有一个叫做 conrnerRadius 的属性控制着图层角的曲率。
 它是一个浮点数，默认为 0（为 0 的时候就是直角），但是你可以把它设置成任意值。
 
 默认情况下，这个曲率值只影响背景颜色而不影响背景图片或是子图层。
 不过，如果把 masksToBounds 设置成 YES 的话，图层里面的所有东西都会被截取。

 */
