//
//  HQL5_6ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 如果对包含已经做过变换的图层的图层做反方向的变换将会发什么什么呢？？？
 */
@interface HQL5_6ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*

 # 扁平化图层
 
 如果内部图层相对外部图层做了相反的变换（这里是绕 Z 轴的旋转），那么按照逻辑这两个变换将被相互抵消。
 
 场景2:
 内部的图层仍然向左侧旋转，并且发生了扭曲，但按道理说它应该保持正面朝上，并且显示正常的方块。
 
 这是由于尽管 Core Animation 图层存在于 3D 空间之内，但它们并不都存在同一个 3D 空间。每个图层的 3D 场景其实是扁平化的，当你从正面观察一个图层，看到的实际上由子图层创建的想象出来的 3D 场景，但当你倾斜这个图层，你会发现实际上这个 3D 场景仅仅是被绘制在图层的表面。
 
 类似的，当你在玩一个 3D 游戏，实际上仅仅是把屏幕做了一次倾斜，或许在游戏中可以看见有一面墙在你面前，但是倾斜屏幕并不能够看见墙里面的东西。所有场景里面绘制的东西并不会随着你观察它的角度改变而发生变化；图层也是同样的道理。
 
 这使得用 Core Animation 创建非常复杂的 3D 场景变得十分困难。你不能够使用图层树去创建一个 3D 结构的层级关系 -- 在相同场景下的任何 3D 表面必须和同样的图层保持一致，这是因为每个的父视图都把它的子视图扁平化了。
 至少当你用正常的 CALayer 的时候是这样，CALayer 有一个叫做 CATransformLayer 的子类来解决这个问题。
 */
