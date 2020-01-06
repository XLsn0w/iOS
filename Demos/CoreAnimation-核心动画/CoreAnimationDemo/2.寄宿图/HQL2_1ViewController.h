//
//  HQL2_1ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL2_1ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 CALayer 的寄宿图，即图层中包含的图片
 
 ------------------------------------
 ## contents 属性
 
 给 contents 赋的值需要是 CGImage 类型。
 事实上，你真正要赋值的类型应该是 CGImageRef，它是一个指向 CGImage 结构的指针。
 UIImage 的 CGImage 属性返回的是 CGImageRef。
 但是 CGImageRef 并不是一个真正的 Cocoa 对象，而是一个 Core Foundation 类型。
 可以通过 bridged 关键字转换实现类型兼容：
 
 layer.contents = (__bridge id)image.CGImage;
 
 
 ------------------------------------
 ## contentGravity 属性：决定内容在图层的边界中怎么对齐
 
 在 UIImageView 中，解决图片变胖的问题：
 view.contentMode = UIViewContentModeScaleAspectFit;
 
 在 CALayer 中，与 contentMode 对应的属性叫做 contentsGravity，但是它是一个 NSString 类型：
 
 kCAGravityCenter
 kCAGravityTop
 kCAGravityBottom
 kCAGravityLeft
 kCAGravityRight
 kCAGravityTopLeft
 kCAGravityTopRight
 kCAGravityBottomLeft
 kCAGravityBottomRight
 kCAGravityResize
 kCAGravityResizeAspect
 kCAGravityResizeAspectFill
 
 // 设置图片在图层的边界对齐方式，同时它还能在图层中等比例拉伸以适应图层的边界
 self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
 */
