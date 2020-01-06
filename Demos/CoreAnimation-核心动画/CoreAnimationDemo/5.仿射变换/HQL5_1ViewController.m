//
//  HQL5_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL5_1ViewController.h"

@interface HQL5_1ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *layerView;

@end

@implementation HQL5_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 旋转 CALayer 图层 45°，即 pi/4
    // 注： iOS 的变换函数使用弧度而不是角度作为单位。
    // 弧度用数学常量 pi 的倍数表示，一个 pi 代表 180 度，所以四分之一的 pi 就是 45 度。
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerView.layer.affineTransform = transform;
}



@end
