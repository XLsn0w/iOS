//
//  HQL9_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL9_2ViewController.h"

@interface HQL9_2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HQL9_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add the door
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
    [self.containerView.layer addSublayer:doorLayer];
    
    // 添加 3D透视变换
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    // 添加摇摆动画，本质是一个重复来回的旋转动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = INFINITY; // 无限重复动画
    animation.autoreverses = YES; // 每次间隔交替循环过程中自动回放
    [doorLayer addAnimation:animation forKey:nil];
}



@end
