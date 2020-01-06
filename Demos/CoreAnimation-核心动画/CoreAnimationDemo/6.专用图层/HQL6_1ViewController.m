//
//  HQL6_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL6_1ViewController.h"

@interface HQL6_1ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *containerView2;

@end

@implementation HQL6_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContainerView1];
    [self setupContaienrView2];

}

// 用 CAShapeLayer 绘制一个简单的火柴人
- (void)setupContainerView1 {
    // 创建路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    // create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5; // 线宽
    shapeLayer.lineJoin = kCALineJoinRound; // 线条之间的结合点样式
    shapeLayer.lineCap = kCALineCapRound; // 线条结尾样式
    shapeLayer.path = path.CGPath;
    // add it to our view
    [self.containerView.layer addSublayer:shapeLayer];
}

// 用 CAShapeLayer 绘制了一个有三个圆角一个直角的矩形
- (void)setupContaienrView2 {
    //define path parameters
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    // create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5; // 线宽
    shapeLayer.lineJoin = kCALineJoinRound; // 线条之间的结合点样式
    shapeLayer.lineCap = kCALineCapRound; // 线条结尾样式
    shapeLayer.path = path.CGPath;
    // add it to our view
    [self.containerView2.layer addSublayer:shapeLayer];
}

@end
