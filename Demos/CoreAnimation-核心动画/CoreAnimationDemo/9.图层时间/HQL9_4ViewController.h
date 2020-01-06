//
//  HQL9_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL9_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # fillMode 属性
 
 CAMediaTiming 的 fillMode 属性，fillMode 是一个 NSString 类型，可以接受如下四种常量：
 
 * kCAFillModeForwards
 * kCAFillModeBackwards
 * kCAFillModeBoth
 * kCAFillModeRemoved，当动画不再播放的时候就显示图层模型指定的值剩下的三种类型向前，向后或者即向前又向后去填充动画状态，使得动画在开始前或者结束后仍然保持开始和结束那一刻的值
 
 当用它来解决这个问题的时候，需要把 removeOnCompletion 设置为 NO，另外需要给动画添加一个非空的键，以便可以在不需要动画的时候把它从图层上移除。
 
 # 层级关系时间
 
 每个动画和图层在时间上都有它自己的层级概念，相对于它的父亲来测量。对图层调整时间将会影响到它本身和子图层的动画，但不会影响到父图层。另一个相似点是所有的动画都被按照层级组合（使用 CAAnimationGroup 实例）。
 
 对 CALayer 或者 CAGroupAnimation 调整 duration 和 repeatCount/repeatDuration 属性并不会影响到子动画。
 但是 beginTime，timeOffset 和 speed 属性将会影响到子动画。
 
 然而在层级关系中，beginTime 指定了父图层开始动画（或者组合关系中的父动画）和对象将要开始自己动画之间的偏移。
 类似的，调整 CALayer 和 CAGroupAnimation 的 speed 属性将会对动画以及子动画速度应用一个缩放的因子。
 
 
 # 全局时间和本地时间
 
 CoreAnimation 有一个全局时间的概念，也就是所谓的马赫时间（“马赫” 实际上是 iOS 和 Mac OS 系统内核的命名）。
 马赫时间在设备上所有进程都是全局的 -- 但是在不同设备上并不是全局的 -- 不过这已经足够对动画的参考点提供便利了，你可以使用 CACurrentMediaTime 函数来访问马赫时间：
 
 CFTimeInterval time = CACurrentMediaTime();
 
 这个函数返回的值其实无关紧要（它返回了设备自从上次启动后的秒数，并不是你所关心的），它真实的作用在于对动画的时间测量提供了一个相对值。
 注意当设备休眠的时候马赫时间会暂停，也就是所有的 CAAnimations（基于马赫时间）同样也会暂停。
 因此马赫时间对长时间测量并不有用。比如用 CACurrentMediaTime 去更新一个实时闹钟并不明智。（可以用 [NSDate date] 代替。
 
 每个 CALayer 和 CAAnimation 实例都有自己本地时间的概念，是根据父图层/动画层级关系中的 beginTime，timeOffset 和 speed 属性计算。就和转换不同图层之间坐标关系一样，CALayer 同样也提供了方法来转换不同图层之间的本地时间。如下：
 
 - (CFTimeInterval)convertTime:(CFTimeInterval)t fromLayer:(CALayer *)l;
 - (CFTimeInterval)convertTime:(CFTimeInterval)t toLayer:(CALayer *)l;
 
 当用来同步不同图层之间有不同的 speed，timeOffset 和 beginTime 的动画，这些方法会很有用。


 # 暂停，倒回和快进
 
 设置动画的 speed 属性为 0 可以暂停动画，但在动画被添加到图层之后不太可能再修改它了，所以不能对正在进行的动画使用这个属性。
 给图层添加一个 CAAnimation 实际上是给动画对象做了一个不可改变的拷贝，所以对原始动画对象属性的改变对真实的动画并没有作用。
 相反，直接用 -animationForKey: 来检索图层正在进行的动画可以返回正确的动画对象，但是修改它的属性将会抛出异常。

 如果移除图层正在进行的动画，图层将会急速返回动画之前的状态。但如果在动画移除之前拷贝呈现图层到模型图层，动画将会看起来暂停在那里。但是不好的地方在于之后就不能再恢复动画了。
 
 一个简单的方法是可以利用 CAMediaTiming 来暂停图层本身。如果把图层的 speed 设置成 0，它会暂停任何添加到图层上的动画。
 类似的，设置 speed 大于 1.0 将会快进，设置成一个负值将会倒回动画。
 
 通过增加主窗口图层的 speed，可以暂停整个应用程序的动画。这对 UI 自动化提供了好处，我们可以加速所有的视图动画来进行自动化测试（注意对于在主窗口之外的视图并不会被影响，比如 UIAlertview）。可以在 app delegate 设置如下进行验证
 
 self.window.layer.speed = 100;
 
 你也可以通过这种方式来减速，但其实也可以在模拟器通过切换慢速动画来实现。
 
 
 # 手动动画
 
 timeOffset 一个很有用的功能在于你可以用它实现手动控制动画进程，
 通过设置 speed 为 0，可以禁用动画的自动播放，然后来使用 timeOffset 来来回显示动画序列。
 这可以使得运用手势来手动控制动画变得很简单。
 
 
 
 */
