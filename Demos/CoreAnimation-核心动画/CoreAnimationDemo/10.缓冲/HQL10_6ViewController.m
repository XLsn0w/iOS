//
//  HQL10_6ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL10_6ViewController.h"

@interface HQL10_6ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation HQL10_6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add ball image view
    UIImage *ballImage = [UIImage imageNamed:@"Ball.png"];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    [self.containerView addSubview:self.ballView];
    
    // animate
    [self animate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //replay animation on tap
    [self animate];
}

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    // 把一条复杂曲线分割成多段，每一段都是一个关键帧动画
    animation.values = @[
        [NSValue valueWithCGPoint:CGPointMake(150, 32)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
        [NSValue valueWithCGPoint:CGPointMake(150, 140)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
        [NSValue valueWithCGPoint:CGPointMake(150, 220)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
        [NSValue valueWithCGPoint:CGPointMake(150, 250)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)]
    ];
    // 通过缓冲函数将每段曲线连接起来
    animation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
    ];
    // 指定每个关键帧的时间偏移
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    
    // 添加动画
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
}

@end
