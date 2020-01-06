//
//  HQL6_5ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 CAReplicatorLayer - 高效生成相似图层
 */
@interface HQL6_5ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAReplicatorLayer
 
 CAReplicatorLayer 的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换
 
 CAReplicatorLayer 真正应用到实际程序上的场景比如：一个游戏中导弹的轨迹云，或者粒子爆炸（尽管 iOS 5 已经引入了 CAEmitterLayer，它更适合创建任意的粒子效果）。除此之外，还有一个实际应用是：反射
 
 */
