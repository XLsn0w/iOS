//
//  HQL7_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL7_1ViewController.h"

@interface HQL7_1ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation HQL7_1ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建并添加子图层
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.colorLayer.position = CGPointMake(self.layerView.bounds.size.width / 2,
                                           self.layerView.bounds.size.height / 2);
    [self.layerView.layer addSublayer:self.colorLayer];
}

#pragma mark - IBActions

- (IBAction)changeColor:(id)sender {
    
    // 开始一个新的事务
    [CATransaction begin];
    
    // 设置新事务的动画时长为 1s，默认为 0.25s
    [CATransaction setAnimationDuration:1.0];
    
    // 添加完成块：每次颜色变化结束之后切换到另一个旋转 90° 的动画
    // 注意旋转动画要比颜色渐变快得多，这是因为完成块是在颜色渐变的事务提交并出栈之后才被执行，
    // 于是，用默认的事务做变换，默认的时间也就变成了 0.25 秒。
    [CATransaction setCompletionBlock:^{
        // 旋转图层 90°
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    
    // 随机改变图层背景颜色
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    // 执行事务
    [CATransaction commit];
}



@end
