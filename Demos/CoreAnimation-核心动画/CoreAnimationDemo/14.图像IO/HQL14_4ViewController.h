//
//  HQL14_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL14_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 如第 6 章 “专用图层” 中的例子所示，CATiledLayer 可以用来异步加载和显示大型图片，而不阻塞用户输入。
 但是我们同样可以使用 CATiledLayer 在 UICollectionView 中为每个表格创建分离的 CATiledLayer 实例加载传动器图片，每个表格仅使用一个图层。
 
 这样使用 CATiledLayer 有几个潜在的弊端：
 CATiledLayer 的队列和缓存算法没有暴露出来，所以我们只能祈祷它能匹配我们的需求
 CATiledLayer 需要我们每次重绘图片到 CGContext 中，即使它已经解压缩，而且和我们单元格尺寸一样（因此可以直接用作图层内容，而不需要重绘）。
 
 
 需要解释几点：

 CATiledLayer 的 tileSize 属性单位是像素，而不是点，所以为了保证瓦片和表格尺寸一致，需要乘以屏幕比例因子。
 在 -drawLayer:inContext: 方法中，我们需要知道图层属于哪一个 indexPath 以加载正确的图片。这里我们利用了 CALayer 的 KVC 来存储和检索任意的值，将图层和索引打标签。
 
     结果 CATiledLayer 工作的很好，性能问题解决了，而且和用 GCD 实现的代码量差不多。仅有一个问题在于图片加载到屏幕上后有一个明显的淡入
 
 我们可以调整 CATiledLayer 的 fadeDuration 属性来调整淡入的速度，或者直接将整个渐变移除，但是这并没有根本性地去除问题：在图片加载到准备绘制的时候总会有一个延迟，这将会导致滑动时候新图片的跳入。这并不是 CATiledLayer 的问题，使用 GCD 的版本也有这个问题。

 即使使用上述我们讨论的所有加载图片和缓存的技术，有时候仍然会发现实时加载大图还是有问题。就和 13 章中提到的那样，iPad 上一整个视网膜屏图片分辨率达到了 2048x1536，而且会消耗 12MB 的 RAM（未压缩）。第三代 iPad 的硬件并不能支持 1/60 秒的帧率加载，解压和显示这种图片。即使用后台线程加载来避免动画卡顿，仍然解决不了问题。
 我们可以在加载的同时显示一个占位图片，但这并没有根本解决问题，我们可以做到更好。
 
 ## 分辨率交换
 
 视网膜分辨率（根据苹果市场定义）代表了人的肉眼在正常视角距离能够分辨的最小像素尺寸。但是这只能应用于静态像素。当观察一个移动图片时，你的眼睛就会对细节不敏感，于是一个低分辨率的图片和视网膜质量的图片没什么区别了。
     
 如果需要快速加载和显示移动大图，简单的办法就是欺骗人眼，在移动传送器的时候显示一个小图（或者低分辨率），然后当停止的时候再换成大图。这意味着我们需要对每张图片存储两份不同分辨率的副本，但是幸运的是，由于需要同时支持 Retina 和非 Retina 设备，本来这就是普遍要做到的。
     如果从远程源或者用户的相册加载没有可用的低分辨率版本图片，那就可以动态将大图绘制到较小的 CGContext，然后存储到某处以备复用。
     为了做到图片交换，我们需要利用 UIScrollView 的一些实现 UIScrollViewDelegate 协议的委托方法（和其他类似于 UITableView 和 UICollectionView 基于滚动视图的控件一样）：
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
     
 你可以使用这几个方法来检测传送器是否停止滚动，然后加载高分辨率的图片。只要高分辨率图片和低分辨率图片尺寸颜色保持一致，你会很难察觉到替换的过程（确保在同一台机器使用相同的图像程序或者脚本生成这些图片）。
 
 */
