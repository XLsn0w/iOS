//
//  HQL6_4ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 渐变效果
 */
@interface HQL6_4ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # CAGradientLayer
 
 CAGradientLayer 是用来生成两种或更多颜色平滑渐变的。
 用 Core Graphics 复制一个 CAGradientLayer 并将内容绘制到一个普通图层的寄宿图也是有可能的，但是 CAGradientLayer 的真正好处在于绘制使用了硬件加速。
 
 # 基础渐变
 
 CAGradientLayer 也有 startPoint 和 endPoint 属性，他们决定了渐变的方向。
 这两个参数是以单位坐标系进行的定义，所以左上角坐标是 {0, 0}，右下角坐标是 {1, 1}。
 
 
 
 # 多重渐变
 
 如果你愿意，colors 属性可以包含很多颜色，所以创建一个彩虹一样的多重渐变也是很简单的。
 默认情况下，这些颜色在空间上均匀地被渲染，但是我们可以用 locations 属性来调整空间。
 locations 属性是一个浮点数值的数组（以 NSNumber 包装）。这些浮点数定义了 colors 属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定。0.0 代表着渐变的开始，1.0 代表着结束。
 
 locations 数组并不是强制要求的，但是如果你给它赋值了就一定要确保 locations 的数组大小和 colors 数组大小一定要相同，否则你将会得到一个空白的渐变。
 
 */
