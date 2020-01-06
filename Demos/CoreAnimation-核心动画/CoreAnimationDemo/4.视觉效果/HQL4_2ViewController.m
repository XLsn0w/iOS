//
//  HQL4_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL4_2ViewController.h"
#import <Chameleon.h>

@interface HQL4_2ViewController ()

@property (nonatomic, weak) IBOutlet UIView *layerView1;
@property (nonatomic, weak) IBOutlet UIView *layerView2;

@end

@implementation HQL4_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置图层1的背景颜色
    self.layerView1.backgroundColor = [UIColor flatMintColor];
    
    // 设置图层的圆角半径
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    // 设置图层边框
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    
    // 设置图层边框颜色
    self.layerView2.layer.borderColor = [UIColor purpleColor].CGColor;
    
    // 启动裁剪
    // 当前视图层级下的所有子视图也会跟着被裁剪
    self.layerView2.layer.masksToBounds = YES;
}


@end
