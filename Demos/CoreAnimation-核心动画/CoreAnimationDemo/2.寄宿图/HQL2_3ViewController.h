//
//  HQL2_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL2_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 ## contentsRect 属性
 
 在图层边框里显示寄宿图的一个子域。
 
 contentsRect 使用单位坐标，
 单位坐标指定在 0 到 1 之间，是一个相对值（像素和点就是绝对值）。所以他们是相对于寄宿图的尺寸的。
 
 点（虚拟像素、逻辑像素）：在标准设备上，一个点就是一个像素，但是在 Retina 设备上，一个点等于 2*2 个像素。
 像素：物理像素坐标并不会用来布局屏幕，但是仍然与图片有相对关系。UIImage 是一个屏幕分辨率解决方案，所以指定点来度量大小。但是一些底层的图片表示如 CGImage 就会使用像素，所以你要清楚在 Retina 设备和普通设备上，他们表现出来了不同的大小。
 单位：对于与图片大小或是图层边界相关的显示，单位坐标是一个方便的度量方式，当大小改变的时候，也不需要再次调整。
      单位坐标在 OpenGL 这种纹理坐标系统中用得很多，Core Animation 中也用到了单位坐标。
 
 默认的 contentsRect 是 {0, 0, 1, 1}，
 这意味着整个寄宿图默认都是可见的，如果我们指定一个小一点的矩形，图片就会被裁剪。
 
 contentsRect 在 app 中最有趣的地方在于一个叫做 image sprites（图片拼合）的用法。
 图片拼合后可以打包整合到一张大图上一次性载入。
 相比多次载入不同的图片，这样做能够带来很多方面的好处：内存使用，载入时间，渲染性能等等。
 
 ## 开源库
 LayerSprites：https://github.com/nicklockwood/LayerSprites
 
 它能够读取 Cocos2D 格式中的拼合图并在普通的 Core Animation 层中显示出来。
 
 */
