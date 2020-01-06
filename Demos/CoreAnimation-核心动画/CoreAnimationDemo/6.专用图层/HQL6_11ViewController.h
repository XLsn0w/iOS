//
//  HQL6_11ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用 AVPlayerLayer 图层播放视频，给视频增加变换，边框和圆角
 */
@interface HQL6_11ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # AVPlayerLayer
 
 尽管 AVPlayerLayer 不是 Core Animation 框架的一部分（AV 前缀看上去像），AVPlayerLayer 是有别的框架（AVFoundation）提供的，它和 Core Animation 紧密地结合在一起，提供了一个 CALayer 子类来显示自定义的内容类型。
 
 AVPlayerLayer 是用来在 iOS 上播放视频的。他是高级接口例如 MPMoivePlayer 的底层实现，提供了显示视频的底层控制。
 
 AVPlayerLayer 的使用相当简单：你可以用
 +playerLayerWithPlayer:
 方法创建一个已经绑定了视频播放器的图层，或者你可以先创建一个图层，然后用 player 属性绑定一个 AVPlayer 实例。
 
 # Tips
 写这个示例当中发生的问题：应用程序包中明明有这个视频文件（Ship.mp4），就是死活加载不进来。
 
 解决方法：将视频文件拖进项目中时，切记勾选将视频添加到应用程序的 Target 中！！！
 
 
 */
