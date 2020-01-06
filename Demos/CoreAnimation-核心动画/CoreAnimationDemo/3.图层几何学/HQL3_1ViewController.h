//
//  HQL3_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL3_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 布局
 
 UIView 有三个比较重要的布局属性：frame，bounds 和 center，
 CALayer 对应地叫做 frame，bounds 和 position。
 
 frame 代表了图层的外部坐标（也就是在父图层上占据的空间），
 bounds 是内部坐标（{0, 0} 通常是图层的左上角），
 center 和 position 都代表了相对于父图层 anchorPoint 所在的位置。
 
 
 # UIView 和 CALayer 的坐标系
 
 视图的 frame，bounds 和 center 属性仅仅是存取方法，当操纵视图的 frame，实际上是在改变位于视图下方 CALayer 的 frame，不能够独立于图层之外改变视图的 frame。
 
 当对图层做变换的时候，比如旋转或者缩放，frame 实际上代表了覆盖在图层旋转之后的整个轴对齐的矩形区域，也就是说 frame 的宽高可能和 bounds 的宽高不再一致了。
 
 
 # 锚点
 
 视图的 center 属性和图层的 position 属性都指定了 anchorPoint 相对于父图层的位置。
 图层的 anchorPoint 通过 position 来控制它的 frame 的位置，你可以认为 anchorPoint 是用来移动图层的把柄。
 
 anchorPoint 用单位坐标来描述，也就是图层的相对坐标，图层左上角是 {0, 0}，右下角是 {1, 1}，因此默认坐标是 {0.5, 0.5}
 
 # 坐标系
 
 CALayer 给不同坐标系之间的图层转换提供了一些工具类方法
 
 - (CGPoint)convertPoint:(CGPoint)point fromLayer:(CALayer *)layer;
 - (CGPoint)convertPoint:(CGPoint)point toLayer:(CALayer *)layer;
 - (CGRect)convertRect:(CGRect)rect fromLayer:(CALayer *)layer;
 - (CGRect)convertRect:(CGRect)rect toLayer:(CALayer *)layer;
 
 这些方法可以把定义在一个图层坐标系下的点或者矩形转换成另一个图层坐标系下的点或者矩形.
 (把在一个图层坐标系下的绝对位置转换为在另一个图层坐标系下的绝对位置，可以这么理解，阿姨的儿子称呼他妈为妈妈，但是称呼你为哥哥。阿姨、你是两个不同的图层，儿子是一个点，称谓就是坐标位置)
 
 # 翻转的几何结构，geometryFlipped 属性
 
 常规说来，在 iOS 上，一个图层的 position 位于父图层的左上角，但是在 Mac OS 上，通常是位于左下角。
 Core Animation 可以通过 geometryFlipped 属性来适配这两种情况，它决定了一个图层的坐标是否相对于父图层垂直翻转，是一个 BOOL 类型。
 在 iOS 上通过设置它为 YES 意味着它的子图层将会被垂直翻转，也就是将会沿着底部排版而不是通常的顶部（它的所有子图层也同理，除非把它们的 geometryFlipped 属性也设为 YES）

 */
