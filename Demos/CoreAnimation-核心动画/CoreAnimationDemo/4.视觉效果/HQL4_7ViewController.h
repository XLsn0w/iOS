//
//  HQL4_7ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 这一章想要演示的示例是说：按钮的不透明度是 50%，按钮上面还有一个 Label，Label 也有背景颜色，它的不透明度是 50% + 25%
 按钮的 50% 白色不透明背景和 标签的 75% 白色不透明背景不搭，需要修复！
 但是，真机演示并没有出现这个问题，不知道是苹果修复了这个问题还是哪里设置默认修复了这个问题。
 
 就是说「组透明」的问题在当前系统下不存在！
 */
@interface HQL4_7ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 组透明
 
 UIView 有一个叫做 alpha 的属性来确定视图的透明度。
 CALayer 有一个等同的属性叫做 opacity，这两个属性都是影响子层级的。也就是说，如果你给一个图层设置了 opacity 属性，那它的子图层都会受此影响。
 
理想状况下，当你设置了一个图层的透明度，你希望它包含的整个图层树像一个整体一样的透明效果。
 你可以通过设置 Info.plist 文件中的 UIViewGroupOpacity 为 YES 来达到这个效果，但是这个设置会影响到这个应用，整个 app 可能会受到不良影响。
 如果 UIViewGroupOpacity 并未设置，iOS 6 和以前的版本会默认为 NO（也许以后的版本会有一些改变）。
 
 另一个方法就是，你可以设置 CALayer 的一个叫做 shouldRasterize 属性（见清单 4.7）来实现组透明的效果，如果它被设置为 YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了
 
 
 */
