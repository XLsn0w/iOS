//
//  HQL15_5ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL15_5ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 对象回收
 
 处理巨大数量的相似视图或图层时还有一个技巧就是回收他们。对象回收在 iOS 颇为常见；UITableView 和 UICollectionView 都有用到，MKMapView 中的动画 pin 码也有用到，还有其他很多例子。

 对象回收的基础原则就是你需要创建一个相似对象池。当一个对象的指定实例（本例子中指的是图层）结束了使命，你把它添加到对象池中。每次当你需要一个实例时，你就从池中取出一个。当且仅当池中为空时再创建一个新的。
 这样做的好处在于避免了不断创建和释放对象（相当消耗资源，因为涉及到内存的分配和销毁）而且也不必给相似实例重复赋值。
 
 本例中，我们只有图层对象这一种类型，但是 UIKit 有时候用一个标识符字符串来区分存储在不同对象池中的不同的可回收对象类型。

 你可能注意到当设置图层属性时我们用了一个 CATransaction 来抑制动画效果。
 在之前并不需要这样做，因为在显示之前我们给所有图层设置一次属性。
 但是既然图层正在被回收，禁止隐式动画就有必要了，不然当属性值改变时，图层的隐式动画就会被触发。
 
 
 # Core Graphics 绘制
 
 当排除掉对屏幕显示没有任何贡献的图层或者视图之后，长远看来，你可能仍然需要减少图层的数量。
 例如，如果你正在使用多个 UILabel 或者 UIImageView 实例去显示固定内容，你可以把他们全部替换成一个单独的视图，然后用 -drawRect: 方法绘制出那些复杂的视图层级。

 这个提议看上去并不合理因为大家都知道软件绘制行为要比 GPU 合成要慢而且还需要更多的内存空间，但是在因为图层数量而使得性能受限的情况下，软件绘制很可能提高性能呢，因为它避免了图层分配和操作问题。
 你可以自己实验一下这个情况，它包含了性能和栅格化的权衡，但是意味着你可以从图层树上去掉子图层（用 shouldRasterize，与完全遮挡图层相反）。
 
 
 # -renderInContext: 方法
 
 用 Core Graphics 去绘制一个静态布局有时候会比用层级的 UIView 实例来得快，但是使用 UIView 实例要简单得多而且比用手写代码写出相同效果要可靠得多，更边说 Interface Builder 来得直接明了。
 为了性能而舍弃这些便利实在是不应该。

 幸好，你不必这样，如果大量的视图或者图层真的关联到了屏幕上将会是一个大问题。没有与图层树相关联的图层不会被送到渲染引擎，也没有性能问题（在他们被创建和配置之后）。
 使用 CALayer 的 -renderInContext: 方法，你可以将图层及其子图层快照进一个 Core Graphics 上下文然后得到一个图片，它可以直接显示在 UIImageView 中，或者作为另一个图层的 contents。
 不同于 shouldRasterize —— 要求图层与图层树相关联 —— ，这个方法没有持续的性能消耗。
 当图层内容改变时，刷新这张图片的机会取决于你（不同于 shouldRasterize，它自动地处理缓存和缓存验证），但是一旦图片被生成，相比于让 Core Animation 处理一个复杂的图层树，你节省了相当客观的性能。
 
 */
