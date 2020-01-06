//
//  HQL1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 图层树
 
 讨论 Core Animation 的静态组合以及布局特性
 
 ## 视图与图层的关系
 
 视图在层级关系中可以互相嵌套，一个父视图可以管理它的所有子视图的位置。
 CALayer 是 UIView 内部的实现细节。CALayer 和 UIView 最大的不同之处是「它不处理用户的交互」。
 每一个 UIview 都有一个 CALayer 实例的图层属性，也就是所谓的 backing layer，视图的职责就是创建并管理这个图层，以确保当子视图在层级关系中添加或者被移除的时候，他们关联的图层也同样对应在层级关系树当中有相同的操作
 一个视图只有一个相关联的图层（自动创建），同时它（这个被关联的图层）也可以支持添加无数多个子图层。
 
 由 UIView 的层级关系形成的一种平行的 CALayer 层级关系。
 
 视图层级 + 图层树 + 呈现树 + 渲染树
 
 ## 图层的能力
 
 UIView 对 CALayer 进行了封装，提供了响应用户触摸事件、Core Animation 底层方法的高级接口。
 
 UIView 没有暴露出来的 CALayer 的功能：
 * 阴影、圆角、带颜色的边框；
 * 3D 变换；
 * 非矩形范围；
 * 透明遮照；
 * 多级非线性动画；
 
 注：使用图层相关的属性和方法需要添加 QuartzCore 框架。
 
 */
