//
//  HQL15_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL15_2ViewController.h"

@interface HQL15_2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation HQL15_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建 CALayer 图层
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    // 注意下面的这个设置
    blueLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.0, 0.0);
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    blueLayer.contents =
        (__bridge id)[UIImage imageNamed:@"Rounded"].CGImage;
    
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];
}



@end
