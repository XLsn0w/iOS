//
//  HQL13_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL13_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 脏矩形
 
 有时候用 CAShapeLayer 或者其他矢量图形图层替代 Core Graphics 并不是那么切实可行。
 比如我们的绘图应用：我们用线条完美地完成了矢量绘制。但是设想一下如果我们能进一步提高应用的性能，让它就像一个黑板一样工作，然后用『粉笔』来绘制线条。模拟粉笔最简单的方法就是用一个『线刷』图片然后将它粘贴到用户手指碰触的地方，但是这个方法用 CAShapeLayer 没办法实现。
 我们可以给每个『线刷』创建一个独立的图层，但是实现起来有很大的问题。屏幕上允许同时出现图层上线数量大约是几百，那样我们很快就会超出的。这种情况下我们没什么办法，就用 Core Graphics 吧（除非你想用 OpenGL 做一些更复杂的事情）。
 
 */
