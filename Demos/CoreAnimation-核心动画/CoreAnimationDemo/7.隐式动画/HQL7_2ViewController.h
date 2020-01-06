//
//  HQL7_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 直接对 UIView 关联的图层做动画而不是一个单独的图层。
 */
@interface HQL7_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 图层行为
 
 直接对 UIView 关联的图层做动画，而不是对视图层次结构下关联的子图层做动画。
 
 运行程序，你会发现当按下按钮，图层颜色瞬间切换到新的值，而不是之前平滑过渡的动画。
 发生了什么呢？隐式动画好像被 UIView 关联图层给禁用了。
 
 我们知道 Core Animation 通常对 CALayer 的所有属性（可动画的属性）做动画，但是 UIView 把它关联的图层的这个特性关闭了。为了更好说明这一点，我们需要知道隐式动画是如何实现的。
 
 我们把改变属性时 CALayer 自动应用的动画称作「行为」，当 CALayer 的属性被修改时候，它会调用 -actionForKey: 方法，传递属性的名称。剩下的操作都在 CALayer 的头文件中有详细的说明，实质上是如下几步：
 
 1. 图层首先检测它是否有委托，并且是否实现 CALayerDelegate 协议指定的 -actionForLayer:forKey 方法。如果有，直接调用并返回结果。
 2. 如果没有委托，或者委托没有实现 -actionForLayer:forKey 方法，图层接着检查包含属性名称对应行为映射的 actions 字典。
 如果 actions字典没有包含对应的属性，那么图层接着在它的 style 字典接着搜索属性名。
 3. 最后，如果在 style 里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的 -defaultActionForKey: 方法。
 
 所以，一轮完整的搜索结束之后，-actionForKey: 要么返回空（这种情况下将不会有动画发生），要么是 CAAction 协议对应的对象，最后 CALayer 拿这个结果去对先前和当前的值做动画。
 
 于是这就解释了 UIKit 是如何禁用隐式动画的：每个 UIView 对它关联的图层都扮演了一个委托，并且提供了 -actionForLayer:forKey 的实现方法。当不在一个动画块的实现中，UIView 对所有图层行为返回 nil，但是在动画 block 范围之内，它就返回了一个非空值。
 
 总结：
 1. UIView 关联的图层禁用了隐式动画，对这种图层做动画的唯一办法就是使用 UIView 的动画函数（而不是依赖 CATransaction），或者继承 UIView，并覆盖 -actionForLayer:forKey: 方法，或者直接创建一个显式动画。
 2. 对于单独存在的图层，我们可以通过实现图层的 -actionForLayer:forKey: 委托方法，或者提供一个 actions 字典来控制隐式动画。
 
 */
