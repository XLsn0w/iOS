//
//  HQL10_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL10_1ViewController.h"

@interface HQL10_1ViewController ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation HQL10_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个红色图层
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2.0,
                                           self.view.bounds.size.height / 2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 创建隐式动画，开始一个事务
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    // 创建缓冲函数
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    // 设置 CAAnimation 的 timingFunction 属性
    [CATransaction setAnimationTimingFunction:function];
    
    //set the position
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    
    //commit transaction
    [CATransaction commit];
}

@end
