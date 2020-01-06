//
//  HQL5_5ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 并排放置两个视图，然后通过设置它们「容器视图」的透视变换，我们可以保证它们有相同的透视和灭点。
 */
@interface HQL5_5ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # sublayerTransform 属性
 
 如果有多个视图或者图层，每个都做 3D 变换，那就需要分别设置相同的 m34 值，并且确保在变换之前都在屏幕中央共享同一个 position，如果用一个函数封装这些操作的确会更加方便，但仍然有限制（例如，你不能在 Interface Builder 中摆放视图），这里有一个更好的方法。
 
 CALayer 有一个属性叫做 sublayerTransform。它也是 CATransform3D 类型，但和对一个图层的变换不同，它影响到所有的子图层。
 这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法。
 
 相较而言，通过在一个地方设置透视变换会很方便，同时它会带来另一个显著的优势：灭点被设置在容器图层的中点，从而不需要再对子图层分别设置了。
 这意味着你可以随意使用 position 和 frame 来放置子图层，而不需要把它们放置在屏幕中点，然后为了保证统一的灭点用变换来做平移。
 
 
 */
