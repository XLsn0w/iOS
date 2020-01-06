//
//  HQL11_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL11_1ViewController.h"

@interface HQL11_1ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) UIImageView *ballView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation HQL11_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add ball image view
    UIImage *ballImage = [UIImage imageNamed:@"Ball"];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    [self.containerView addSubview:self.ballView];
    
    //animate
    [self animate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //replay animation on tap
    [self animate];
}

// C 函数
// 注：因为同名C函数编译时会出现符号重复错误，因此这里改了函数名以防重名冲突
float interpolate11(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue
                   toValue:(id)toValue
                      time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]])
    {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0)
        {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate11(from.x, to.x, time),
                                         interpolate11(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }

    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

float bounceEaseOut11(float t)
{
    if (t < 4/11.0)
    {
        return (121 * t * t)/16.0;
    }
    else if (t < 8/11.0)
    {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    }
    else if (t < 9/10.0)
    {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

/*
 基于 NSTimer 定时器动画存在的问题：
 
 当你设置一个 NSTimer，他会被插入到当前任务列表中，然后直到指定时间过去之后才会被执行。
 但是何时启动定时器并没有一个时间上限，而且它只会在列表中上一个任务完成之后开始执行。
 这通常会导致有几毫秒的延迟，但是如果上一个任务过了很久才完成就会导致延迟很长一段时间。
 此时，定时器就不会严格遵循一秒执行 60 次，可能会存在延迟导致的动画卡顿问题！
 */

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    
    //configure the animation
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    
    // stop the timer if it's already running
    [self.timer invalidate];
    
    // 开启计时器，一秒执行 60 次
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0
                                                  target:self
                                                selector:@selector(step:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)step:(NSTimer *)step
{
    //update time offset
    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
    
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    
    //apply easing
    time = bounceEaseOut11(time);
    
    //interpolate position
    id position = [self interpolateFromValue:self.fromValue
                                     toValue:self.toValue
                                        time:time];
    
    //move ball view to new position
    self.ballView.center = [position CGPointValue];
    
    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= self.duration)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
