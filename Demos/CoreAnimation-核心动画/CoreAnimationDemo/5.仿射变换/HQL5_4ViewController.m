//
//  HQL5_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL5_4ViewController.h"

@interface HQL5_4ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *layerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HQL5_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个新的 3D 单位矩阵变换
    CATransform3D transform = CATransform3DIdentity;
    // 添加透视效果
    transform.m34 = - 1.0 / 500.0;
    // 对视图内的图层绕 Y 轴做 45 度角的旋转
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    // 将变换添加到图层
    self.layerView.layer.transform = transform;
    
    
    // 背面示例
    [self setImageView3DRotate];
}

// 背面
// 将视图旋转 180 度，由于图层是双面绘制的，反面显示的是正面的一个镜像图片
// CALayer 有一个叫做 doubleSided 的属性来控制图层的背面是否要被绘制。
// 这是一个 BOOL 类型，默认为 YES，如果设置为 NO，那么当图层正面从相机视角消失的时候，它将不会被绘制
- (void)setImageView3DRotate {
    // 创建一个新的 3D 单位矩阵变换
    CATransform3D transform = CATransform3DIdentity;
    // 添加透视效果
    transform.m34 = - 1.0 / 500.0;
    // 对视图内的图层绕 Y 轴做 180 度角的旋转
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    // 将变换添加到图层
    self.imageView.layer.transform = transform;
    
    // 不绘制图层的背面，（此时看到的是透明视图）
    self.imageView.layer.doubleSided = NO;
}

@end
