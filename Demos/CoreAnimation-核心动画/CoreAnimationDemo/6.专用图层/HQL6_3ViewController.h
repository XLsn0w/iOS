//
//  HQL6_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用 CATransformLayer 装配一个 3D 图层体系
 
 但是并不像以前那样直接将立方面添加到容器视图的宿主图层，我们将他们放置到一个 CATransformLayer 中创建一个独立的立方体对象，然后将两个这样的立方体放进容器中。
 我们随机地给立方面染色以将他们区分开来，这样就不用靠标签或是光亮来区分他们。
 */
@interface HQL6_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CATransformLayer
 
 CATransformLayer 不同于普通的 CALayer，因为它不能显示它自己的内容。
 只有当存在了一个能作用域子图层的变换它才真正存在。CATransformLayer 并不平面化它的子图层，所以它能够用于构造一个层级的 3D 结构。
 
 
 
 
 
 */
