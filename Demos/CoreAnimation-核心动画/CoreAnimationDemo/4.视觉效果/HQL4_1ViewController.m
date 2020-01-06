//
//  HQL4_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL4_1ViewController.h"
#import <Chameleon.h>

@interface HQL4_1ViewController ()

@property (nonatomic, weak) IBOutlet UIView *layerView1;
@property (nonatomic, weak) IBOutlet UIView *layerView2;

@end

@implementation HQL4_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 验证 cornerRadius 属性只会影响背景颜色，
    // 所以你可以按照需要决定是否设置 masksToBounds，以减少系统做离屏渲染
    self.layerView1.backgroundColor = [UIColor flatMintColor];
    
    // 设置图层的圆角半径
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    // masksToBounds: 沿着边界裁剪图形
    // 当前视图层级下的所有子视图也会跟着被裁剪
    self.layerView2.layer.masksToBounds = YES;
}

@end
