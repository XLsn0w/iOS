//
//  HQL6_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 CATextLayer 实现 UILabel 效果
 */
@interface HQL6_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CATextLayer
 
 Core Animation 提供了一个 CALayer 的子类 CATextLayer，它以图层的形式包含了 UILabel 几乎所有的绘制特性，并且额外提供了一些新的特性。
 
 同样，CATextLayer 也要比 UILabel 渲染得快得多。很少有人知道在 iOS 6 及之前的版本，UILabel 其实是通过 WebKit 来实现绘制的，这样就造成了当有很多文字的时候就会有极大的性能压力。而 CATextLayer 使用了 Core text，并且渲染得非常快。
 
 # 富文本
 
 
 
 */
