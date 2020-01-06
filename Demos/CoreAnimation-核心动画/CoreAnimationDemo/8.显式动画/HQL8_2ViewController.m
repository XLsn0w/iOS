//
//  HQL8_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_2ViewController.h"

@interface HQL8_2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HQL8_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAnimationDemo2];
}

// 1.对背景颜色作关键帧动画
- (IBAction)changeColor:(id)sender {
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    // 将动画添加到图层
    [self.view1.layer addAnimation:animation forKey:nil];
}

// 2.沿着一个贝塞尔曲线对图层做动画
- (void)addAnimationDemo2 {
    // 创建一个贝塞尔曲线路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150)
                  controlPoint1:CGPointMake(75, 0)
                  controlPoint2:CGPointMake(225, 300)];
    
    // 使用 CAShapeLayer 绘制路径
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    // 添加飞船图片
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    // 对 position 属性作关键帧动画
    animation.keyPath = @"position";
    // 设置动画时长
    animation.duration = 4.0;
    // 设置动画路径
    animation.path = bezierPath.CGPath;
    // 通过 rotationMode 自动对齐图层到曲线，图层将会根据曲线的切线自动旋转
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil]; // 在图层上添加动画
}

@end
