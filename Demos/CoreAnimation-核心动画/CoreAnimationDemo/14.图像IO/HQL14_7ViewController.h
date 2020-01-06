//
//  HQL14_7ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL14_7ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 混合图片
 
 对于包含透明的图片来说，最好是使用「压缩透明通道的 PNG 图片」和「压缩 RGB 部分的 JPEG 图片」混合起来加载。
 这就对任何格式都适用了，而且无论从质量还是文件尺寸还是加载性能来说都和 PNG 和 JPEG 的图片相近。
 
 ## JPNG
 开源库：https://github.com/nicklockwood/JPNG
 
 */
