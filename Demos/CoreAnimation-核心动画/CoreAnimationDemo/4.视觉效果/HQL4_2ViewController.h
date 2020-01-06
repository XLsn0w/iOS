//
//  HQL4_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL4_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 视觉效果
 
 通过使用 CALayer 属性实现的视觉效果
 
 ## 图层边框
 
 CALayer 另外两个非常有用属性就是 borderWidth 和 borderColor。
 二者共同定义了图层边的绘制样式。这条线（也被称作 stroke）沿着图层的 bounds 绘制，同时也包含图层的角。
 
 * borderWidth 是以点为单位的定义边框粗细的浮点数，默认为 0。
 * borderColor 定义了边框的颜色，默认为黑色。
 
 borderColor 是 CGColorRef 类型，而不是 UIColor，所以它不是 Cocoa 的内置对象。
 CGColorRef 属性即便是强引用也只能通过 assign 关键字来声明。
 
 边框是绘制在图层边界里面的，而且在所有子内容之前，也在子图层之前。
 边框是跟随图层的边界变化的，而不是图层里面的内容。
 
 
 */
