//
//  HQL11_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/26.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL11_2ViewController.h"

@interface HQL11_2ViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeOffset;
@property (nonatomic, assign) CFTimeInterval lastStep;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation HQL11_2ViewController

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

float interpolate112(float from, float to, float time)
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
            CGPoint result = CGPointMake(interpolate112(from.x, to.x, time),
                                         interpolate112(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }

    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

float bounceEaseOut112(float t)
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

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    
    //configure the animation
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    
    //stop the timer if it's already running
    [self.timer invalidate];
    
    // 在每帧开始刷新的时候用 CACurrentMediaTime() 记录当前时间
    self.lastStep = CACurrentMediaTime();
    // 开启定时器，使用 CADisplayLink
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    // 将 CADisplayLink 添加到 Run Loop
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
    
}

- (void)step:(CADisplayLink *)timer
{
    //calculate time delta
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    
    //update time offset
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    
    //apply easing
    time = bounceEaseOut112(time);
    
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
