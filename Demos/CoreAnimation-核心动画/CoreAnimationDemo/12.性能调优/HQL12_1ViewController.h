//
//  HQL12_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用 Instruments 来检测和修复性能问
/// 因为 Demo 示例中用到的 iOS 版本太老，可能示例本身存在很大问题，所以暂不进行探讨。
@interface HQL12_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 性能调优
 
 ## CPU vs GPU
 
 关于绘图和动画有两种处理的方式：CPU（中央处理器）和 GPU（图形处理器）。在现代 iOS 设备中，都有可以运行不同软件的可编程芯片，但是由于历史原因，我们可以说 CPU 所做的工作都在软件层面，而 GPU 在硬件层面。
 总的来说，我们可以用软件（使用 CPU）做任何事情，但是对于图像处理，通常用硬件会更快，因为 GPU 使用图像对高度并行浮点运算做了优化。由于某些原因，我们想尽可能把屏幕渲染的工作交给硬件去处理。问题在于 GPU 并没有无限制处理性能，而且一旦资源用完的话，性能就会开始下降了（即使 CPU 并没有完全占用）
 大多数动画性能优化都是关于智能利用 GPU 和 CPU，使得它们都不会超出负荷。于是我们首先需要知道 Core Animation 是如何在这两个处理器之间分配工作的。
 
 ## 动画的舞台
 
     Core Animation 处在 iOS 的核心地位：应用内和应用间都会用到它。一个简单的动画可能同步显示多个 app 的内容，例如当在 iPad 上多个程序之间使用手势切换，会使得多个程序同时显示在屏幕上。在一个特定的应用中用代码实现它是没有意义的，因为在 iOS 中不可能实现这种效果（App 都是被沙箱管理，不能访问别的视图）。
 
     动画和屏幕上组合的图层实际上被一个单独的进程管理，而不是你的应用程序。这个进程就是所谓的渲染服务。在 iOS5 和之前的版本是 SpringBoard 进程（同时管理着 iOS 的主屏）。在 iOS6 之后的版本中叫做 BackBoard。
 
     当运行一段动画时候，这个过程会被四个分离的阶段被打破：
    布局 - 这是准备你的视图 / 图层的层级关系，以及设置图层属性（位置，背景色，边框等等）的阶段。
    显示 - 这是图层的寄宿图片被绘制的阶段。绘制有可能涉及你的 -drawRect: 和 -drawLayer:inContext: 方法的调用路径。
    准备 - 这是 Core Animation 准备发送动画数据到渲染服务的阶段。这同时也是 Core Animation 将要执行一些别的事务例如解码动画过程中将要显示的图片的时间点。
    提交 - 这是最后的阶段，Core Animation 打包所有图层和动画属性，然后通过 IPC（内部处理通信）发送到渲染服务进行显示。
 
    ...
 
 
 ## 测量，而不是猜测
 
 要点：
 1. 当你开始做一些性能方面的工作时，一定要在真机上测试，而不是模拟器。
 2. 性能测试一定要用发布配置，而不是调试模式。
 3. 最好在你支持的设备中性能最差的设备上测试。
 
 ## 保持一致的帧率
 
 Instruments 工具：
 * 时间分析器 - 用来测量被方法/函数打断的 CPU 使用情况。
 * Core Animation - 用来调试各种 Core Animation 性能问题。
 * OpenGL ES 驱动 - 用来调试 GPU 性能问题。这个工具在编写 Open GL 代码的时候很有用，但有时也用来处理 Core Animation 的工作。
 
 
 
 
 
 */
