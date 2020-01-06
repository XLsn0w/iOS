//
//  HQL6_9ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用 CAEmitterLayer 创建爆炸效果
 */
@interface HQL6_9ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAEmitterLayer
 
 CAEmitterLayer 是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
 
 CAEmitterLayer 看上去像是许多 CAEmitterCell 的容器，这些 CAEmitierCell 定义了一个例子效果。
 你将会为不同的例子效果定义一个或多个 CAEmitterCell 作为模版，同时 CAEmitterLayer 负责基于这些模版实例化一个粒子流。
 一个 CAEmitterCell 类似于一个 CALayer：它有一个 contents 属性可以定义为一个 CGImage，另外还有一些可设置属性控制着表现和行为。
 */
