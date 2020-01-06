//
//  HQL10_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL10_2ViewController.h"

@interface HQL10_2ViewController ()
@property (nonatomic, strong) UIView *colorView;
@end

@implementation HQL10_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个红色的视图
    self.colorView = [[UIView alloc] init];
    self.colorView.bounds = CGRectMake(0, 0, 100, 100);
    self.colorView.center = CGPointMake(self.view.bounds.size.width / 2,
                                        self.view.bounds.size.height / 2);
    self.colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.colorView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 执行动画
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{      
        // 设置位置
        self.colorView.center = [[touches anyObject] locationInView:self.view];
                         
    } completion:NULL];
}

@end
