//
//  HQL10_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL10_3ViewController.h"

@interface HQL10_3ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet CALayer *colorLayer;

@end

@implementation HQL10_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // add it to our view
    [self.containerView.layer addSublayer:self.colorLayer];
}

// 该示例可以对比：8.显式动画中的关键帧动画。
- (IBAction)changeColor:(id)sender {
    // 创建一个关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor
                         ];
    
    // CAKeyframeAnimation 有一个 NSArray 类型的 timingFunctions 属性，我们用它来对每次动画的步骤指定不同的计时函数。
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:
                                 kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn, fn, fn];
    
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
    
    
}

@end
