//
//  HQL15_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL15_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 可伸缩图片
 
 另一个创建圆角矩形的方法就是用一个圆形内容图片并结合第二章『寄宿图』提到的 contensCenter 属性去创建一个可伸缩图片（见清单 15.2）.
 理论上来说，这个应该比用 CAShapeLayer 要快，因为一个可拉伸图片只需要 18 个三角形（一个图片是由一个 3*3 网格渲染而成），然而，许多都需要渲染成一个顺滑的曲线。在实际应用上，二者并没有太大的区别。
 
 使用可伸缩图片的优势在于：它可以绘制成任意边框效果而不需要额外的性能消耗。举个例子，可伸缩图片甚至还可以显示出矩形阴影的效果。
 
 
 # shadowPath
 
 在第 2 章我们有提到 shadowPath 属性。
 如果图层是一个简单几何图形如矩形或者圆角矩形（假设不包含任何透明部分或者子图层），创建出一个对应形状的阴影路径就比较容易，而且 Core Animation 绘制这个阴影也相当简单，避免了屏幕外的图层部分的预排版需求。这对性能来说很有帮助。

 如果你的图层是一个更复杂的图形，生成正确的阴影路径可能就比较难了，这样子的话你可以考虑用绘图软件预先生成一个阴影背景图。
 */
