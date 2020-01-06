//
//  HQL6_10ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 它使用了 OpenGL ES 2.0 的绘图上下文，并渲染了一个有色三角
 */
@interface HQL6_10ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAEAGLLayer
 
 -------------------------------------------------------------------------------------
 ⚠️ OpenGL 和 OpenCL 自 iOS 12 开始失效！Apple 推荐开发者使用 Metal 框架。
 
 参考：
 <https://www.imore.com/opengl-and-opencl-be-depreciated-ios-12-and-macos-mojave>
 <https://www.raywenderlich.com/9211-moving-from-opengl-to-metal>
 -------------------------------------------------------------------------------------
 
 
 
 当 iOS 要处理高性能图形绘制时，必要时就是使用 OpenGL。应该说它是最后的杀手锏，至少对于非游戏的应用来说是这样的。
 因为相比 Core Animation 和 UIkit 框架，它不可思议地复杂。
 
 OpenGL 提供了 Core Animation 的基础，它是底层的 C 接口，直接和 iPhone，iPad 的硬件通信，极少地抽象出来的方法。
 OpenGL 没有对象或者图层继承的概念。它只是简单地处理三角形。
 OpenGL 中所有东西都是 3D 空间中有颜色和纹理的三角形。用起来非常复杂和强大，但是用 OpenGL 绘制 iOS 用户界面就需要很多很多的工作了。
 
 为了能够以高性能的方式使用 Core Animation，首先，你要判断你需要绘制的是哪种内容（矢量图形，例子，文本，等等），然后选择合适的图层去呈现这些内容，Core Animation 中只有一些特定类型的内容是被高度优化的；所以如果你想绘制的东西并不能找到标准的图层类，想要得到高性能就比较费事情了。
 
 因为 OpenGL 根本不会对你的内容进行假设，它能够绘制得相当快。利用 OpenGL，你可以绘制任何你知道必要的集合信息和形状逻辑的内容。所以很多游戏都喜欢用 OpenGL（这些情况下，Core Animation 的限制就明显了：它优化过的内容类型并不一定能满足需求），但是这样依赖，方便的高度抽象接口就没了。
 
 在 iOS 5 中，苹果引入了一个新的框架叫做 GLKit，它去掉了一些设置 OpenGL 的复杂性，提供了一个叫做 GLKView 的 UIView 的子类，帮你处理大部分的设置和绘制工作。
 前提是各种各样的 OpenGL 绘图缓冲的底层可配置项仍然需要你用 CAEAGLLayer 完成，它是 CALayer 的一个子类，用来显示任意的 OpenGL 图形。
 
 大部分情况下你都不需要手动设置 CAEAGLLayer（假设用 GLKView），过去的日子就不要再提了。特别的，我们将设置一个 OpenGL ES 2.0 的上下文，它是现代的 iOS 设备的标准做法。
 
 尽管不需要 GLKit 也可以做到这一切，但是 GLKit 囊括了很多额外的工作，比如设置顶点和片段着色器，这些都以类 C 语言叫做 GLSL 自包含在程序中，同时在运行时载入到图形硬件中。编写 GLSL 代码和设置 EAGLayer 没有什么关系，所以我们将用 GLKBaseEffect 类将着色逻辑抽象出来。其他的事情，我们还是会有以往的方式。
 
 在一个真正的 OpenGL 应用中，我们可能会用 NSTimer 或 CADisplayLink 周期性地每秒钟调用 -drawRrame 方法 60 次，同时会将几何图形生成和绘制分开以便不会每次都重新生成三角形的顶点（这样也可以让我们绘制其他的一些东西而不是一个三角形而已）
 */




/*
 # OpenGL
 
 参考：<https://blog.csdn.net/hejjunlin/article/details/61615215>
 
 OpenGL™ 是行业领域中最为广泛接纳的 2D/3D 图形 API，其自诞生至今已催生了各种计算机平台及设备上的数千优秀应用程序。OpenGL™ 是独立于视窗操作系统或其它操作系统的，亦是网络透明的。在包含 CAD、内容创作、能源、娱乐、游戏开发、制造业、制药业及虚拟现实等行业领域中，OpenGL™ 帮助程序员实现在 PC、工作站、超级计算机等硬件设备上的高性能、极具冲击力的高视觉表现力图形处理软件的开发。
 */

/*
 # OpenGL ES
 
 GLKit 是苹果 iOS 5 引入的一个为简化 OpenGL ES 的使用的框架，它为 OpenGL ES 的使用提供了相关的类和函数，GLKit 是 Cocoa Touch 以及多个其他的框架（包含 UIKit）的一部分。而 GLKView 和 GLKViewController 类名字中的 GLK 前缀表明这些类是 GLKit 框架的一部分。
 
 GLKViewController 类是支持 OpenGL ES 特有的行为和动画时的 UIViewController 的内建子类。
 GLKView 是 Cocoa Touch UIView 类的内建子类。
 
 GLKView 简化了通过用 Core Animation 层来自动创建并管理帧缓存和渲染缓存共享内存所需要做的工作。
 GLKView 相关的 GLKViewController 实例是视图的委托并接收当视图需要重绘时的消息。
 
 
 */
