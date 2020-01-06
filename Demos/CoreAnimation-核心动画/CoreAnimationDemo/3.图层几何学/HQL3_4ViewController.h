//
//  HQL3_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL3_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # Hit Testing
 
 -hitTest: 方法同样接受一个 CGPoint 类型参数，它不是返回 BOOL 类型，它返回图层本身，或者包含这个坐标点的叶子节点图层。
 这意味着不再需要像使用 -containsPoint: 那样，人工地在每个子图层变换或者测试点击的坐标。如果这个点在最外面图层的范围之外，则返回 nil。
 
 
 # 自动布局
 你可能用过 UIViewAutoresizingMask 类型的一些常量，应用于：
 当父视图改变尺寸的时候，相应 UIView 的 frame 也跟着更新的场景（通常用于横竖屏切换）
 
 当使用视图的时候，可以充分利用 UIView 类接口暴露出来的 UIViewAutoresizingMask 和 NSLayoutConstraintAPI，但如果想随意控制 CALayer 的布局，就需要手工操作。最简单的方法就是使用 CALayerDelegate 如下函数：
 - (void)layoutSublayersOfLayer:(CALayer *)layer;
 
 当图层的 bounds 发生改变，或者图层的 -setNeedsLayout 方法被调用的时候，这个函数将会被执行。
 这使得你可以手动地重新摆放或者重新调整子图层的大小，但是不能像 UIView 的 autoresizingMask 和 constraints 属性做到自适应屏幕旋转。
 这也是为什么最好使用视图而不是单独的图层来构建应用程序的另一个重要原因之一。
 
 */
