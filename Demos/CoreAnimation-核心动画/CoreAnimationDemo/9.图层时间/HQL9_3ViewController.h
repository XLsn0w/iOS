//
//  HQL9_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL9_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # 相对时间
 
 在 Core Animation 中，时间都是相对的，每个动画都有它自己描述的时间，可以独立地加速，延时或者偏移。
 
 ## beginTime 属性
 
 beginTime 属性指定了动画开始之前的的延迟时间。这里的延迟从动画添加到可见图层的那一刻开始测量，默认是 0（就是说动画会立刻执行）。
 
 ## speed 属性
 
 speed 属性是一个时间的倍数，默认 1.0，减少它会减慢图层/动画的时间，增加它会加快速度。如果 2.0 的速度，那么对于一个 duration 为 1 的动画，实际上在 0.5 秒的时候就已经完成了。
 
 ## timeOffset 属性
 
 timeOffset 属性和 beginTime 属性类似，但是和增加 beginTime 导致的延迟动画不同，增加 timeOffset 只是让动画快进到某一点，例如，对于一个持续 1 秒的动画来说，设置 timeOffset 为 0.5 意味着动画将从一半的地方开始。
 
 和 beginTime 不同的是，timeOffset 并不受 speed 的影响。所以如果你把 speed 设为 2.0，把 timeOffset 设置为 0.5，那么你的动画将从动画最后结束的地方开始，因为 1 秒的动画实际上被缩短到了 0.5 秒。然而即使使用了 timeOffset 让动画从结束的地方开始，它仍然播放了一个完整的时长，这个动画仅仅是循环了一圈，然后从头开始播放。
 
 
 
 */
