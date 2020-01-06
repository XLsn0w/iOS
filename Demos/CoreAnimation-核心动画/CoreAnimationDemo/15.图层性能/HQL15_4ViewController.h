//
//  HQL15_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 绘制 3D 图层矩阵
/// ⚠️ 该示例有 BUG。
@interface HQL15_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 WIDTH，HEIGHT 和 DEPTH 常量控制着图层的生成。
 在这个情况下，我们得到的是 10*10*10 个图层，总量为 1000 个，不过一次性显示在屏幕上的大约就几百个。

 如果把 WIDTH 和 HEIGHT 常量增加到 100，我们的程序就会慢得像龟爬了。
 这样我们有了 100000 个图层，性能下降一点儿也不奇怪。
 
 但是显示在屏幕上的图层数量并没有增加，那么根本没有额外的东西需要绘制。程序慢下来的原因其实是因为在管理这些图层上花掉了不少功夫。他们大部分对渲染的最终结果没有贡献，但是在丢弃这么图层之前，Core Animation 要强制计算每个图层的位置，就这样，我们的帧率就慢了下来。
 
 我们的图层是被安排在一个均匀的栅格中，我们可以计算出哪些图层会被最终显示在屏幕上，根本不需要对每个图层的位置进行计算。这个计算并不简单，因为我们还要考虑到透视的问题。如果我们直接这样做了，Core Animation 就不用费神了。
 
 既然这样，让我们来重构我们的代码吧。改造后，随着视图的滚动动态地实例化图层而不是事先都分配好。这样，在创造他们之前，我们就可以计算出是否需要他。接着，我们增加一些代码去计算可视区域这样就可以排除区域之外的图层了
 

 
 这个计算机制并不具有普适性，但是原则上是一样。（当你用一个 UITableView 或者 UICollectionView 时，系统做了类似的事情）。这样做的结果？我们的程序可以处理成百上千个『虚拟』图层而且完全没有性能问题！因为它不需要一次性实例化几百个图层。
 
 */
