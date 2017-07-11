//
//  ViewController.h
//  XLsn0wCAAnimation
//
//  Created by XLsn0w on 2017/6/27.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

// Use the timerWithTimeInterval:invocation:repeats: or timerWithTimeInterval:target:selector:userInfo:repeats: class method to create the timer object without scheduling it on a run loop. (After creating it, you must add the timer to a run loop manually by calling the addTimer:forMode: method of the corresponding NSRunLoop object.)
// 创建一个定时器，但是么有添加到运行循环，我们需要在创建定时器后手动的调用 NSRunLoop 对象的 addTimer:forMode: 方法。
//+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

// Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
// 创建一个timer并把它指定到一个默认的runloop模式中，并且在 TimeInterval时间后 启动定时器
//+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

// Use the timerWithTimeInterval:invocation:repeats: or timerWithTimeInterval:target:selector:userInfo:repeats: class method to create the timer object without scheduling it on a run loop. (After creating it, you must add the timer to a run loop manually by calling the addTimer:forMode: method of the corresponding NSRunLoop object.)
// 创建一个定时器，但是么有添加到运行循环，我们需要在创建定时器后手动的调用 NSRunLoop 对象的 addTimer:forMode: 方法。
//+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

// Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
// 创建一个timer并把它指定到一个默认的runloop模式中，并且在 TimeInterval时间后 启动定时器
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

// 默认的初始化方法，（创建定时器后，手动添加到 运行循环，并且手动触发才会启动定时器）
- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(nullable id)ui repeats:(BOOL)rep NS_DESIGNATED_INITIALIZER;


// You can use this method to fire a repeating timer without interrupting its regular firing schedule. If the timer is non-repeating, it is automatically invalidated after firing, even if its scheduled fire date has not arrived.
// 启动 Timer 触发Target的方法调用但是并不会改变Timer的时间设置。 即 time没有到达到，Timer会立即启动调用方法且没有改变时间设置，当时间 time 到了的时候，Timer还是会调用方法。
- (void)fire;

// 这是设置定时器的启动时间，常用来管理定时器的启动与停止
@property (copy) NSDate *fireDate;
// 启动定时器
timer.fireDate = [NSDate distantPast];
//停止定时器
timer.fireDate = [NSDate distantFuture];
// 开启
[time setFireDate:[NSDate  distanPast]]
// NSTimer   关闭
［time  setFireDate:[NSDate  distantFunture]］
//继续。
[timer setFireDate:[NSDate date]];


// 这个是一个只读属性，获取定时器调用间隔时间
//@property (readonly) NSTimeInterval timeInterval;

// 这是7.0之后新增的一个属性，因为NSTimer并不完全精准，通过这个值设置误差范围
//@property NSTimeInterval tolerance NS_AVAILABLE(10_9, 7_0);

// 停止 Timer ---> 唯一的方法将定时器从循环池中移除
//- (void)invalidate;

// 获取定时器是否有效
//@property (readonly, getter=isValid) BOOL valid;

// 获取参数信息---> 通常传入的是 nil
//@property (nullable, readonly, retain) id userInfo;




/*
 属性动画 CAPropertyAnimation 基类 不能直接使用
 子类：
 1.CABasicAnimation 基础动画
 2.CAKeyframeAnimation 关键帧动画
 通过改变图层或者视图上面的属性值（支持动画的属性）产生的动画
 属性动画的常用方法属性
 1.初始化
 
 + (instancetype)animationWithKeyPath:(nullable NSString *)path
 path：需要产生动画的属性 如：中心点 -> 移动
 2.KeyPath 描述 动画的属性
 
 可以通过改变animationWithKeyPath来改变动画的属性：
 改变动画的属性：
 
 transform.scale = 比例转换
 transform.scale.x
 transform.scale.y
 transform.rotation.z
 opacity   透明度
 zPosition
 backgroundColor 背景颜色
 cornerRadius 拐角
 borderWidth  边框的宽度
 bounds
 contents     内容
 contentsRect
 frame
 hidden
 masksToBounds
 opacity
 position
 shadowColor
 shadowOffset
 shadowOpacity
 shadowRadius
 基础动画 CABasicAnimation
 介绍：通过改变某个属性的值 到某个值 只能设置两个值 产生的动画
 fromValue 开始值 如果不设置不会返回到初始位置
 toValue 结束值
 byValue 通过哪个值
 
 
 */
