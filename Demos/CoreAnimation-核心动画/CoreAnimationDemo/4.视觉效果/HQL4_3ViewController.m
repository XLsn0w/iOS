//
//  HQL4_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL4_3ViewController.h"

@interface HQL4_3ViewController ()

@property (nonatomic, weak) IBOutlet UIView *layerView1; // Left White View
@property (nonatomic, weak) IBOutlet UIView *layerView2; // Right White View
@property (nonatomic, weak) IBOutlet UIView *shadowView; // Shadow View

@end

@implementation HQL4_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置图层的圆角半径
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    // 设置图层边框
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    
    // 设置 layerView1 阴影
    self.layerView1.layer.shadowOpacity = 0.5f; // 阴影的不透明度
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f); // 阴影偏移
    self.layerView1.layer.shadowRadius = 5.0f; // 阴影的模糊度
    
    // add same shadow to shadowView (not layerView2)
    // 用额外的阴影转换视图包裹被裁剪的视图
    // 设置 shadowView 的阴影
    // shadowView 只是对 layerView2 做了一层包装（套壳）
    // 注：IB 中，shadowView 的背景色要设置成透明色
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.shadowView.layer.shadowRadius = 5.0f;
    
    // 启动裁剪
    // 当前视图层级下的所有子视图也会跟着被裁剪
    self.layerView2.layer.masksToBounds = YES;
}

@end
