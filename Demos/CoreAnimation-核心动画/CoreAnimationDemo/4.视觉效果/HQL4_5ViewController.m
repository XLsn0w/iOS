//
//  HQL4_5ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL4_5ViewController.h"

@interface HQL4_5ViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation HQL4_5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建蒙版图层：锥体
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"Cone"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    // 将蒙板添加到图像图层
    self.imageView.layer.mask = maskLayer;
    
}

@end
