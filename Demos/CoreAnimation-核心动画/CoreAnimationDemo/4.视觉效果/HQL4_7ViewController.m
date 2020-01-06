//
//  HQL4_7ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL4_7ViewController.h"

@interface HQL4_7ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HQL4_7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个不透明按钮
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(80, 150);
    // button1.alpha = 0.5;
    [self.containerView addSubview:button1];
    
    // 创建一个半透明按钮
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [self.containerView addSubview:button2];
    
    // enable rasterization for the translucent button
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIButton *)customButton {
    // 创建按钮
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    // 添加标签
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}

@end
