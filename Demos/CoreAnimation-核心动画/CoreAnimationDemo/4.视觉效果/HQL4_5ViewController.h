//
//  HQL4_5ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL4_5ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 图层蒙板
 
 使用图层蒙板的场景：
 你希望展现的内容不是在一个矩形或圆角矩形中。
 比如，你想展示一个有星形框架的图片，又或者想让一些古卷文字慢慢渐变成背景色，而不是一个突兀的边界。
 
 CALayer 有一个属性叫做 mask 可以解决这个问题。
 这个属性本身就是个 CALayer 类型，有和其他图层一样的绘制和布局属性。
 它类似于一个子图层，相对于父图层（即拥有该属性的图层）布局，但是它却不是一个普通的子图层。
 不同于那些绘制在父图层中的子图层，mask 图层定义了父图层的部分可见区域。
 
 mask 图层的 Color 属性是无关紧要的，真正重要的是图层的轮廓。
 mask 属性就像是一个饼干切割机，mask 图层实心的部分会被保留下来，其他的则会被抛弃。
 
 如果 mask 图层比父图层要小，只有在 mask 图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。

 CALayer 蒙板图层真正厉害的地方在于蒙板图不局限于静态图。
 任何有图层构成的都可以作为 mask 属性，这意味着你的蒙板可以通过代码甚至是动画实时生成。
 
 
 
 */
