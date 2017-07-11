//
//  AppDelegate.h
//  XLsn0wCAAnimation
//
//  Created by XLsn0w on 2017/6/27.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

/*

 
 对于复杂界面，适当的增加界面的层级有助于简化每层的逻辑结构，更利于解耦。
 
 但是会遇到不同层级之间的view进行范围判断的问题，由于view所在的层级不同，直接去比较坐标是没有意义的，
 只有把需要判断的view放置到同一个坐标系下，其坐标的判断才有可比性。
 
 
 blueView和grayView是同一个层级，redView为grayView的子视图，如何判断redView和blueView的关系呢（在内部，在外部，还是相交）？
 
 此时就需要进行坐标系转换
 官方提供了4个方法(UIView的方法)：
 
 -(CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;//点转换
 -(CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;//点转换
 -(CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;//矩形转换
 -(CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;//矩形转换
 具体使用如下：
 
 获取redView在self.view坐标系中的坐标（以下两种写法等效）:

 CGPoint redCenterInView = [self.grayView convertPoint:self.redView.center toView:self.view];
 
 CGPoint redCenterInView = [self.view convertPoint:self.redView.center fromView:self.grayView];
 
 使用注意：
 1.使用convertPoint:toView:时，调用者应为covertPoint的父视图。即调用者应为point的父控件。toView即为需要转换到的视图坐标系，以此视图的左上角为（0，0）点。
 2.使用convertPoint:fromView:时正好相反，调用者为需要转换到的视图坐标系。fromView为point所在的父控件。
 3.toView可以为nil。此时相当于toView传入self.view.window
 
 补充：有人问道为什么相对于self.view 和相对于self.view.window 不一样呢？
 因为在viewDidLoad方法中，self.view.window为nil，测试的时候注意不要直接写在viewDidLoad方法中，写在viewdidAppear中。
 --
 
 2.点在范围内的判断
 方案一： 转换为同一坐标系下后比较x，y值，判断范围。
 方案二： 利用pointInside方法进行判断。
 方案一不需介绍，下面说明下方案二的使用。
 
 UIView有如下一个方法，用于判断点是否在内部
 
 -(BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;   // default returns YES if point is in bounds
 使用注意：
 point必须为调用者的坐标系，即调用者的左上角为（0，0）的坐标系。

 比如确定redView的中心点是否在blueView上：
 
 //转换为blueView坐标系点
 CGPoint redCenterInBlueView = [self.grayView convertPoint:self.redView.center toView:self.blueView];
 
 BOOL isInside = [self.blueView pointInside:redCenterInBlueView withEvent:nil];
 
 NSLog(@"%d",isInside);
 输出结果为1。即点在范围内。
 理解了这两个方法，在做某些需求的时候就会更加得心应手。
 
 
 */
