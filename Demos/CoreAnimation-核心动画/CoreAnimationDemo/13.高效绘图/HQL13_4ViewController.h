//
//  HQL13_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 清单 13.4 展示了一个 -addBrushStrokeAtPoint: 方法的升级版，它只重绘当前线刷的附近区域。
 另外也会刷新之前线刷的附近区域，我们也可以用 CGRectIntersectsRect() 来避免重绘任何旧的线刷以不至于覆盖已更新过的区域。这样做会显著地提高绘制效率
 */
@interface HQL13_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 为了减少不必要的绘制，Mac OS 和 iOS 设备将会把屏幕区分为需要重绘的区域和不需要重绘的区域。
 那些需要重绘的部分被称作『脏区域』。在实际应用中，鉴于非矩形区域边界裁剪和混合的复杂性，通常会区分出包含指定视图的矩形位置，而这个位置就是『脏矩形』。
 
 当一个视图被改动过了，TA 可能需要重绘。但是很多情况下，只是这个视图的一部分被改变了，所以重绘整个寄宿图就太浪费了。
 但是 Core Animation 通常并不了解你的自定义绘图代码，它也不能自己计算出脏区域的位置。然而，你的确可以提供这些信息。
 
 当你检测到指定视图或图层的指定部分需要被重绘，你直接调用 -setNeedsDisplayInRect: 来标记它，然后将影响到的矩形作为参数传入。
 这样就会在一次视图刷新时调用视图的 -drawRect:（或图层代理的 -drawLayer:inContext: 方法）。
 
 传入 -drawLayer:inContext: 的 CGContext 参数会自动被裁切以适应对应的矩形。
 为了确定矩形的尺寸大小，你可以用 CGContextGetClipBoundingBox() 方法来从上下文获得大小。
 调用 -drawRect() 会更简单，因为 CGRect 会作为参数直接传入。
 
 你应该将你的绘制工作限制在这个矩形中。任何在此区域之外的绘制都将被自动无视，但是这样 CPU 花在计算和抛弃上的时间就浪费了，实在是太不值得了。
 
 相比依赖于 Core Graphics 为你重绘，裁剪出自己的绘制区域可能会让你避免不必要的操作。那就是说，如果你的裁剪逻辑相当复杂，那还是让 Core Graphics 来代劳吧，记住：当你能高效完成的时候才这样做。


 # 异步绘制
 
 UIKit 的单线程天性意味着寄宿图通畅要在主线程上更新，这意味着绘制会打断用户交互，甚至让整个 app 看起来处于无响应状态。我们对此无能为力，但是如果能避免用户等待绘制完成就好多了。
 
 针对这个问题，有一些方法可以用到：一些情况下，我们可以推测性地提前在另外一个线程上绘制内容，然后将由此绘出的图片直接设置为图层的内容。
 这实现起来可能不是很方便，但是在特定情况下是可行的。Core Animation 提供了一些选择：CATiledLayer 和 drawsAsynchronously 属性。
 
 
 ## CATiledLayer
 
 我们在第六章简单探索了一下 CATiledLayer。
 除了将图层再次分割成独立更新的小块（类似于脏矩形自动更新的概念），CATiledLayer 还有一个有趣的特性：
 在多个线程中为每个小块同时调用 -drawLayer:inContext: 方法。
 这就避免了阻塞用户交互而且能够利用多核心新片来更快地绘制。只有一个小块的 CATiledLayer 是实现异步更新图片视图的简单方法。
 
 
 ## drawsAsynchronously
 
 
 iOS 6 中，苹果为 CALayer 引入了这个令人好奇的属性，drawsAsynchronously 属性对传入 -drawLayer:inContext: 的 CGContext 进行改动，允许 CGContext 延缓绘制命令的执行以至于不阻塞用户交互。
 它与 CATiledLayer 使用的异步绘制并不相同。它自己的 -drawLayer:inContext: 方法只会在主线程调用，但是 CGContext 并不等待每个绘制命令的结束。相反地，它会将命令加入队列，当方法返回时，在后台线程逐个执行真正的绘制。
 根据苹果的说法。这个特性在需要频繁重绘的视图上效果最好（比如我们的绘图应用，或者诸如 UITableViewCell 之类的），对那些只绘制一次或很少重绘的图层内容来说没什么太大的帮助。
 
 */
