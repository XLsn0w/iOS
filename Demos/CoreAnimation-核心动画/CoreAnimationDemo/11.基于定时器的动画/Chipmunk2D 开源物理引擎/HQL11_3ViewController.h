//
//  HQL11_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用开源物理引擎 Chipmunk
@interface HQL11_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 物理模拟
 
 注：在 iOS 7 中引入了 UIKit Dyanmics ，它是 UIKit 下的一个二维的物理引擎。
 
 # 开源物理引擎 Chipmunk
 
 我们来基于物理学创建一个真实的重力模拟效果来取代当前基于缓冲的弹性动画，但即使模拟 2D 的物理效果就已经极其复杂了，所以就不要尝试去实现它了，直接用开源的物理引擎库好了。
 
 我们将要使用的物理引擎叫做 Chipmunk。另外的 2D 物理引擎也同样可以（例如 Box2D），但是 Chipmunk 使用纯 C 写的，而不是 C++，好处在于更容易和 Objective-C 项目整合。Chipmunk 有很多版本，包括一个和 Objective-C 绑定的 “indie” 版本。C 语言的版本是免费的，所以我们就用它好了。在本书写作的时候 7.0.3 是最新的版本；你可以从 http://chipmunk-physics.net 下载它。
 
 Star：1300+
 源码：https://github.com/slembcke/Chipmunk2D
 参考：http://chipmunk-physics.net/documentation.php
 Chipmunk2D 中文手册：https://github.com/iTyran/ChipmunkDocsCN/blob/master/Chipmunk2D.md
 
 Chipmunk 完整的物理引擎相当巨大复杂，但是我们只需要会使用如下几个类：
 * cpSpace - 这是所有的物理结构体的容器。它有一个大小和一个可选的重力矢量
 * cpBody - 它是一个固态无弹力的刚体。它有一个坐标，以及其他物理属性，例如质量，运动和摩擦系数等等。
 * cpShape - 它是一个抽象的几何形状，用来检测碰撞。可以给结构体添加一个多边形，而且 cpShape 有各种子类来代表不同形状的类型。
 
 在本例中，我们来对一个木箱建模，然后在重力的影响下下落。我们来创建一个 Crate 类，包含屏幕上的可视效果（一个 UIImageView）和一个物理模型（一个 cpBody 和一个 cpPolyShape，一个 cpShape 的多边形子类来代表矩形木箱）。
 用 C 版本的 Chipmunk 会带来一些挑战，因为它现在并不支持 Objective-C 的引用计数模型，所以我们需要准确的创建和释放对象。为了简化，我们把 cpShape 和 cpBody 的生命周期和 Crate 类进行绑定，然后在木箱的 -init 方法中创建，在 -dealloc 中释放。木箱物理属性的配置很复杂，所以阅读了 Chipmunk 文档会很有意义。
 视图控制器用来管理 cpSpace，还有和之前一样的计时器逻辑。在每一步中，我们更新 cpSpace（用来进行物理计算和所有结构体的重新摆放）然后迭代对象，然后再更新我们的木箱视图的位置来匹配木箱的模型（在这里，实际上只有一个结构体，但是之后我们将要添加更多）。
 
 Chipmunk 使用了一个和 UIKit 颠倒的坐标系（Y 轴向上为正方向）。为了使得物理模型和视图之间的同步更简单，我们需要通过使用 geometryFlipped 属性翻转容器视图的集合坐标（第 3 章中有提到），于是模型和视图都共享一个相同的坐标系。
 具体的代码见清单 11.3。注意到我们并没有在任何地方释放 cpSpace 对象。在这个例子中，内存空间将会在整个 app 的生命周期中一直存在，所以这没有问题。但是在现实世界的场景中，我们需要像创建木箱结构体和形状一样去管理我们的空间，封装在标准的 Cocoa 对象中，然后来管理 Chipmunk 对象的生命周期。图 11.1 展示了掉落的木箱。
 */
