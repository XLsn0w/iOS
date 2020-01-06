//
//  HQL2_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL2_1ViewController.h"

@interface HQL2_1ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

@end

@implementation HQL2_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubLayer1];
    
    [self addSubLayer2];
}

// 场景1：利用 CALayer 在一个普通的 UIView 中显示一张图片
- (void)addSubLayer1 {
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"snowman"];
    
    // 添加到 layer 层
    self.layerView1.layer.contents = (__bridge id)image.CGImage;
}

// 场景2：利用 CALayer 在一个普通的 UIView 中显示一张图片
- (void)addSubLayer2 {
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"snowman"];
    
    // 添加到 layer 层
    self.layerView2.layer.contents = (__bridge id)image.CGImage;
    
    // 自动拉伸图片以适应图层的边界
    self.layerView2.layer.contentsGravity = kCAGravityResizeAspect;
}

@end
