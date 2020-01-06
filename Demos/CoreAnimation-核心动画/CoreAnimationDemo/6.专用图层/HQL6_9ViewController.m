//
//  HQL6_9ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL6_9ViewController.h"

@interface HQL6_9ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HQL6_9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建粒子发射器图层
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    // 配置粒子发射器
    // preservesDepth 属性：是否将 3D 例子系统平面化到一个图层（默认值）或者可以在 3D 空间中混合其他的图层
    // renderMode 属性控制着在视觉上粒子图片是如何混合的。
    // kCAEmitterLayerAdditive：合并粒子重叠部分的亮度使得看上去更亮。
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0,
                                          emitter.frame.size.height / 2.0);
    
    // 创建一个粒子模版
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"Spark"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    // color 属性：指定一个可以混合图片内容颜色的混合色
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.2 alpha:1.0].CGColor;
    // alphaSpeed 属性：指定值在时间线上的变化。
    // 将 alphaSpeed 设置为 -0.4，就是说粒子的透明度每过一秒就是减少 0.4
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    // emissionRange 属性：粒子某一个属性的变换范围，
    // 属性的值是 2π，这意味着例子可以从 360 度任意位置反射出来。如果指定一个小一些的值，就可以创造出一个圆锥形
    cell.emissionRange = M_PI * 2.0;
    
    // add particle template to emitter
    emitter.emitterCells = @[cell];
}

@end
