//
//  HQL10_7ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL10_7ViewController.h"

@interface HQL10_7ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation HQL10_7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add ball image view
    UIImage *ballImage = [UIImage imageNamed:@"Ball.png"];
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

// 复制 Core Animation 的插值机制。这是一个传入起点和终点，然后在这两个点之间指定时间点产出一个新点的机制。
float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

// 在起点和终点之间插值，自动寻找关键帧动画的中间点
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
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time),
                                         interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }

    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

// 使用 bounceEaseOut 函数
float bounceEaseOut(float t)
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
    
    // 设置动画参数
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    CFTimeInterval duration = 1.0;
    
    //generate keyframes
    // 注意到我们用了 60 x 动画时间（秒做单位）作为关键帧的个数，这时因为 Core Animation 按照每秒 60 帧去渲染屏幕更新，所以如果我们每秒生成 60 个关键帧，就可以保证动画足够的平滑。
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++)
    {
        float time = 1.0/(float)numFrames * i;
        
        // 缓冲时间
        time = bounceEaseOut(time);
        
        // 添加关键帧
        [frames addObject:[self interpolateFromValue:fromValue
                                             toValue:toValue
                                                time:time]];
    }
    
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    // 动画持续时间
    animation.duration = 1.0;
    // 关键帧动画的各个关键点
    animation.values = frames;
    
    // 添加动画到图层
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
}


@end
