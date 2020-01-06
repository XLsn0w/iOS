//
//  HQL7_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 随机改变图层颜色
 */
@interface HQL7_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 隐式动画
 
 讨论框架自动完成的隐式动画（除非你明确禁用了这个功能）
 
 ## 事务
 
 Core Animation 基于一个假设，屏幕上的任何东西都可以（或者可能）做动画。动画并不需要你在 Core Animation 中手动打开，相反需要明确地关闭，否则他会一直存在。
 
 当你改变 CALayer 的一个可做动画的属性，它并不能立刻在屏幕上体现出来。
 相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。
 
 隐式动画：之所以叫隐式是因为我们并没有指定任何动画的类型。
 我们仅仅改变了一个属性，然后由 Core Animation 来决定如何并且何时去做动画。
 
 但当你改变一个属性，Core Animation 是如何判断动画类型和持续时间的呢？
 实际上「动画执行的时间取决于当前事务的设置」，「动画类型取决于图层行为」。
 
 事务实际上是 Core Animation 用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
 
 事务是通过 CATransaction 类来做管理，这个类的设计有些奇怪，不像你从它的命名预期的那样去管理一个简单的事务，而是管理了一叠你不能访问的事务。
 CATransaction 没有属性或者实例方法，并且也不能用 +alloc 和 -init 方法创建它。但是可以用 +begin 和 +commit 分别来入栈或者出栈。
 
 任何可以做动画的图层属性都会被添加到栈顶的事务中，你可以通过 +setAnimationDuration: 方法设置当前事务的动画时间，或者通过 +animationDuration 方法来获取值（默认 0.25 秒）。
 
 Core Animation 在每个 run loop 周期中自动开始一次新的事务（run loop 是 iOS 负责收集用户输入，处理定时器或者网络事件并且重新绘制屏幕的东西），即使你不显式的用 [CATransaction begin] 开始一次事务，任何在一次 run loop 循环中属性的改变都会被集中起来，然后做一次 0.25 秒的动画。
 
 明白这些之后，我们就可以轻松修改变色动画的时间了。我们当然可以用当前事务的 +setAnimationDuration: 方法来修改动画时间，但在这里我们首先起一个新的事务，于是修改时间就不会有别的副作用。
 因为修改当前事务的时间可能会导致同一时刻别的动画（如屏幕旋转），所以最好还是在调整动画之前压入一个新的事务。
 
 
 如果你用过 UIView 的动画方法做过一些动画效果，那么应该对这个模式不陌生。
 UIView 有两个方法，+beginAnimations:context: 和 +commitAnimations，和 CATransaction 的 +begin 和 +commit 方法类似。实际上在 +beginAnimations:context: 和 +commitAnimations 之间所有视图或者图层属性的改变而做的动画都是由于设置了 CATransaction 的原因。
 
 在 iOS4 中，苹果对 UIView 添加了一种基于 block 的动画方法：+animateWithDuration:animations:。
 这样写对做一堆的属性动画在语法上会更加简单，但实质上它们都是在做同样的事情。
 
 CATransaction 的 +begin 和 +commit 方法在 +animateWithDuration:animations: 内部自动调用，这样 block 中所有属性的改变都会被事务所包含。
 这样也可以避免开发者由于对 +begin 和 +commit 匹配的失误造成的风险。
 
 
 # 完成块
 
 基于 UIView 的 block 的动画允许你在动画结束的时候提供一个完成的动作。
 CATranscation 接口提供的 +setCompletionBlock: 方法也有同样的功能。
 
 我们来调整上个例子，在颜色变化结束之后执行一些操作。我们来添加一个完成之后的 block，用来在每次颜色变化结束之后切换到另一个旋转 90° 的动画。
 
 */
