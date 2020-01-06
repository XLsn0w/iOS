//
//  HQL2_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL2_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 ## contentsCenter 属性
 
 contentsCenter 是一个 CGRect，它定义了一个固定的边框和一个在图层上可拉伸的区域。
 改变 contentsCenter 的值并不会影响到寄宿图的显示，除非这个图层的大小改变了，你才看得到效果。
 
 默认情况下，contentsCenter 是 {0, 0, 1, 1}，这意味着如果大小（由 conttensGravity 决定）改变了，那么寄宿图将会均匀地拉伸开。
 
 但是如果我们增加原点的值并减小尺寸。我们会在图片的周围创造一个边框。
 {0.25, 0.25, 0.5, 0.5}
 
 注：contentsCenter 属性也可以在 Interface Builder 里面配置。
 */
