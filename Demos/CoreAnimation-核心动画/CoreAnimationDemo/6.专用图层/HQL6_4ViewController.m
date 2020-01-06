//
//  HQL6_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL6_4ViewController.h"
#import <Chameleon.h>

@interface HQL6_4ViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView1;
@property (nonatomic, weak) IBOutlet UIView *containerView2;
@property (nonatomic, weak) IBOutlet UIView *containerView3;

@end

@implementation HQL6_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContainerView1GradientLayer];
    [self setupContainerView2GradientLayer];
    [self setupContainerView3GradientLayer];
}

// 基础渐变
- (void)setupContainerView1GradientLayer {

    // 创建一个渐变图层 CAGradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView1.bounds;
    [self.containerView1.layer addSublayer:gradientLayer];
    
    // 设置渐变色
    // 数组接受的是 CGColorRef 类型的值，因此需要通过 __bridge 桥接
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    // 渐变的 startPoint 和 endPoint 属性决定了渐变的方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

// 多重渐变
- (void)setupContainerView2GradientLayer {
    
    // 创建一个渐变图层 CAGradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView2.bounds;
    [self.containerView2.layer addSublayer:gradientLayer];
    
    // 设置渐变色
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor];
    
    // 调整渐变色的空间分布
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    // 渐变的 startPoint 和 endPoint 属性决定了渐变的方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

// 使用 <Chameleon.h> 框架实现渐变效果
- (void)setupContainerView3GradientLayer {
    // 渐变颜色数组
    NSArray *colorArray = @[[UIColor flatGreenColor],
                            [UIColor flatMintColor],
                            [UIColor flatYellowColor]];
    
    // 创建渐变色
    UIColor *gradientColor = [UIColor colorWithGradientStyle:UIGradientStyleRadial
                                                   withFrame:self.containerView3.bounds
                                                   andColors:colorArray];
    
    self.containerView3.backgroundColor = gradientColor;
}



@end
