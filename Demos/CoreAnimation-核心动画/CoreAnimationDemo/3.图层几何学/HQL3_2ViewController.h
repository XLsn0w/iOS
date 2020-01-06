//
//  HQL3_2ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL3_2ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # Z 坐标轴
 
 和 UIView 严格的二维坐标系不同，CALayer 存在于一个三维空间当中。
 除了我们已经讨论过的 position 和 anchorPoint 属性之外，
 CALayer 还有另外两个属性，zPosition 和 anchorPointZ，二者都是在 Z 轴上描述图层位置的浮点类型。
 
 除了做变换之外，zPosition 最实用的功能就是改变图层的显示顺序了。
 
 通常，图层是根据它们子图层的 sublayers 出现的顺序来类绘制的，
 但是通过增加图层的 zPosition，就可以把图层向相机方向前置，于是它就在所有其他图层的前面了。
 
 
 */
