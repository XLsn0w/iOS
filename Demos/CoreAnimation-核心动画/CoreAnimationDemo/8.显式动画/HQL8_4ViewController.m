//
//  HQL8_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_4ViewController.h"

@interface HQL8_4ViewController ()

@end

@implementation HQL8_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个贝塞尔曲线路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(30, 400)];
    [bezierPath addCurveToPoint:CGPointMake(330, 400)
                  controlPoint1:CGPointMake(120, 300)
                  controlPoint2:CGPointMake(220, 500)];
    
    // 使用 CAShapeLayer 绘制路径
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    // 添加一个有颜色的图层
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(30, 400, 64, 64);
    colorLayer.position = CGPointMake(30, 400);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    
    // 动画1：创建关键帧动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    // 对 position 属性作关键帧动画
    animation1.keyPath = @"position";
    // 设置动画路径：贝塞尔曲线路径
    animation1.path = bezierPath.CGPath;
    // 通过 rotationMode 自动对齐图层到曲线，图层将会根据曲线的切线自动旋转
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    // 动画2：创建基础动画
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;

    // 创建动画组
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    
    // 将动画组添加到颜色图层
    [colorLayer addAnimation:groupAnimation forKey:nil];
}



@end
