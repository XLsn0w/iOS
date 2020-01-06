//
//  HQL2_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL2_2ViewController.h"

@interface HQL2_2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

@end

@implementation HQL2_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubLayer1];
    
    [self addSubLayer2];
}

// 利用 CALayer 在一个普通的 UIView 中显示一张图片
- (void)addSubLayer1 {
    // 加载图片
    // 使用 UIImage 读取到的是高质量的 Retina 版本的图片。
    UIImage *image = [UIImage imageNamed:@"snowman"];
    
    // 添加到 layer 层
    // 当使用 CGImage 来设置图层内容时，“拉伸”这个因素在转换时就会被丢失。
    self.layerView1.layer.contents = (__bridge id)image.CGImage;
    
    // 图片居中，kCAGravityCenter 不会自动拉伸图片
    self.layerView1.layer.contentsGravity = kCAGravityCenter;
    
    // 设置 contentsScale 以匹配图像拉伸
    self.layerView1.layer.contentsScale = image.scale;
}

// 利用 CALayer 在一个普通的 UIView 中显示一张图片
- (void)addSubLayer2 {
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"snowman"];
    
    // 添加到 layer 层
    self.layerView2.layer.contents = (__bridge id)image.CGImage;
    
    // 图片居中，kCAGravityCenter 不会自动拉伸图片
    self.layerView2.layer.contentsGravity = kCAGravityCenter;
    
    // 设置 contentsScale 以匹配图像拉伸
    self.layerView2.layer.contentsScale = image.scale;
    
    // clip the snowman to fit his bounds，切掉超出视图部分的内容
    self.layerView2.layer.masksToBounds = YES;
}

@end
