//
//  HQL1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL1ViewController.h"

@interface HQL1ViewController ()

// 矩形白色视图
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation HQL1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个 CALayer 图层，将它添加到 UIView 相关联的子图层中。
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // 添加到白色矩形中
    [self.layerView.layer addSublayer:blueLayer];
}

@end
