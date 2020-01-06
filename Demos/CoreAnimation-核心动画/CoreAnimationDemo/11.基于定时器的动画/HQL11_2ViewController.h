//
//  HQL11_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用 CADisplayLink 实现弹性球动画
/// 通过测量每帧持续的时间来使得动画更加平滑
@interface HQL11_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CADisplayLink
 
 CADisplayLink 是 CoreAnimation 提供的另一个类似于 NSTimer 的类，它总是在屏幕完成一次更新之前启动，它的接口设计的和 NSTimer 很类似，所以它实际上就是一个内置实现的替代。
 
 但是和 timeInterval 以秒为单位不同，CADisplayLink 有一个整型的 frameInterval 属性，指定了间隔多少帧之后才执行。
 默认值是 1，意味着每次屏幕更新之前都会执行一次。
 但是如果动画的代码执行起来超过了六十分之一秒，你可以指定 frameInterval 为 2，就是说动画每隔一帧执行一次（一秒钟 30 帧）
 或者 3，也就是一秒钟 20 次，等等。
 
 用 CADisplayLink 而不是 NSTimer，会保证帧率足够连续，使得动画看起来更加平滑，但即使 CADisplayLink 也不能保证每一帧都按计划执行，一些失去控制的离散的任务或者事件（例如资源紧张的后台程序）可能会导致动画偶尔地丢帧。
 当使用 NSTimer 的时候，一旦有机会计时器就会开启，但是 CADisplayLink 却不一样：如果它丢失了帧，就会直接忽略它们，然后在下一次更新的时候接着运行。
 
 # 计算帧的持续时间
 
 无论是使用 NSTimer 还是 CADisplayLink，我们仍然需要处理一帧的时间超出了预期的六十分之一秒。
 由于我们不能够计算出一帧真实的持续时间，所以需要手动测量。我们可以在每帧开始刷新的时候用 CACurrentMediaTime() 记录当前时间，然后和上一帧记录的时间去比较。
 通过比较这些时间，我们就可以得到真实的每帧持续的时间，然后代替硬编码的六十分之一秒。
 
 # Run Loop 模式
 
 ```objc
 // 将 CADisplayLink 添加到 Run Loop
 [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                  forMode:NSDefaultRunLoopMode];
 ```
 
 注意到当创建 CADisplayLink 的时候，我们需要指定一个 run loop 和 run loop mode，对于 run loop 来说，我们就使用了主线程的 run loop，因为任何用户界面的更新都需要在主线程执行，但是模式的选择就并不那么清楚了，每个添加到 run loop 的任务都有一个指定了优先级的模式，为了保证用户界面保持平滑，iOS 会提供和用户界面相关任务的优先级，而且当 UI 很活跃的时候的确会暂停一些别的任务。
 
 一个典型的例子就是当是用 UIScrollview 滑动的时候，重绘滚动视图的内容会比别的任务优先级更高，所以标准的 NSTimer 和网络请求就不会启动，一些常见的 run loop 模式如下：
 
 * NSDefaultRunLoopMode - 标准优先级
 * NSRunLoopCommonModes - 高优先级
 * UITrackingRunLoopMode - 用于 UIScrollView 和别的控件的动画
 
 在我们的例子中，我们是用了 NSDefaultRunLoopMode，但是不能保证动画平滑的运行，所以就可以用 NSRunLoopCommonModes 来替代。
 但是要小心，因为如果动画在一个高帧率情况下运行，你会发现一些别的类似于定时器的任务或者类似于滑动的其他 iOS 动画会暂停，直到动画结束。
 
 同样可以同时对 CADisplayLink 指定多个 run loop 模式，于是我们可以同时加入 NSDefaultRunLoopMode 和 UITrackingRunLoopMode 来保证它不会被滑动打断，也不会被其他 UIKit 控件动画影响性能，像这样：
 
 ```objc
 self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
 [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
 [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
 ```
 
 和 CADisplayLink 类似，NSTimer 同样也可以使用不同的 run loop 模式配置，通过别的函数，而不是 +scheduledTimerWithTimeInterval: 构造器
 
 ```objc
 self.timer = [NSTimer timerWithTimeInterval:1/60.0
                                  target:self
                                selector:@selector(step:)
                                userInfo:nil
                                 repeats:YES];
 [[NSRunLoop mainRunLoop] addTimer:self.timer
                           forMode:NSRunLoopCommonModes];
 ```
 
 
 */
