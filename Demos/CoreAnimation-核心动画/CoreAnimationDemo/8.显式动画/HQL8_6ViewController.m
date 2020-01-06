//
//  HQL8_6ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_6ViewController.h"

@interface HQL8_6ViewController ()

@end

@implementation HQL8_6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)PerformTransition:(id)sender {
    
    // 保留当前视图的快照
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 在此前面插入快照视图
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    // 更新视图 (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    // 更新视图的背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:red
                                                green:green
                                                 blue:blue
                                                alpha:1.0];

    // 执行动画 (anything you like)
    [UIView animateWithDuration:1 animations:^{
        
        // 改变原始视图的背景色的时候对截图快速转动并且淡出
        // scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;

    } completion:^(BOOL finished){

        // 动画完成后移除快照视图
        [coverView removeFromSuperview];
    }];
}


@end
