//
//  HQL8_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_3ViewController.h"

@interface HQL8_3ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *containerView2;

@end

@implementation HQL8_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAnimationDemo1];
    [self addAnimationDemo2];
}

// 用 transform 属性对图层做动画
- (void)addAnimationDemo1 {
    // 添加飞船图片
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    // 旋转飞船，对“旋转”作动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = 2.0;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    [shipLayer addAnimation:animation forKey:nil];
}

// 
// 对虚拟的 transform.rotation 属性做动画
- (void)addAnimationDemo2 {
    // 添加飞船图片
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship"].CGImage;
    [self.containerView2.layer addSublayer:shipLayer];
    
    // 旋转飞船，对“transform.rotation”作动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 4.0;
    animation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:animation forKey:nil];
}

@end
