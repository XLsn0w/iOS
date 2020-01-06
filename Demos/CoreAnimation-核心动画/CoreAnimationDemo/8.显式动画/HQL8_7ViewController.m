//
//  HQL8_7ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_7ViewController.h"

// 旋转动画的 key 值，是一个静态字符串，这里我们可以设置为常量
static NSString *const KShipAnimationKey = @"rotateAnimation";

@interface HQL8_7ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation HQL8_7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加飞船图层
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
}

#pragma mark - IBActions

// 通过开始和停止按钮控制的旋转动画
- (IBAction)startAnimation:(id)sender {
    
    // 添加旋转动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:KShipAnimationKey];
}

- (IBAction)stopAnimation:(id)sender {
    [self.shipLayer removeAnimationForKey:KShipAnimationKey];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    // 打印日志，查看动画是否停止
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}

@end
