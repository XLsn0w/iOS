//
//  HQL8_6ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 对当前视图状态截图，然后在我们改变原始视图的背景色的时候对截图快速转动并且淡出
@interface HQL8_6ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 过渡动画做基础的原则就是对原始的图层外观截图，然后添加一段动画，平滑过渡到图层改变之后那个截图的效果。
 如果我们知道如何对图层截图，我们就可以使用属性动画来代替 CATransition 或者是 UIKit 的过渡方法来实现动画。
 
 事实证明，对图层做截图还是很简单的。
 CALayer 有一个 -renderInContext: 方法，可以通过把它绘制到 Core Graphics 的上下文中捕获当前内容的图片，然后在另外的视图中显示出来。
 如果我们把这个截屏视图置于原始视图之上，就可以遮住真实视图的所有变化，于是重新创建了一个简单的过渡效果。
 
 ⚠️ -renderInContext: 捕获了图层的图片和子图层，但是不能对子图层正确地处理变换效果，而且对视频和 OpenGL 内容也不起作用。
 但是用 CATransition，或者用私有的截屏方式就没有这个限制了。
 
 */
