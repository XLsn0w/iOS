//
//  HQL2_5ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL2_5ViewController.h"

@interface HQL2_5ViewController () <CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *layer;

@end

@implementation HQL2_5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个 CALayer，将它添加到 UIView 相关联的子图层中。
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // 设置控制器遵守 layer 的委托协议
    blueLayer.delegate = self;
    
    // ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    
    // 添加到白色矩形中
    [self.layerView.layer addSublayer:blueLayer];
    self.layer = blueLayer;
    
    // force layer to redraw 强制 layer 重新绘制
    // 当图层显示在屏幕上时，CALayer 不会自动重绘它的内容。它把重绘的决定权交给了开发者。
    [blueLayer display];
}

/**
 FIXME: 有一个 Bug，退出后再进来，应用会 Crash，应该是 Delegate 的原因
 */
- (void)dealloc {
    self.layer.delegate = nil;
}

#pragma mark - CALayerDelegate

// 尽管我们没有用 masksToBounds 属性，绘制的那个圆仍然沿边界被裁剪了。
// 这是因为当你使用 CALayerDelegate 绘制寄宿图的时候，并没有对超出边界外的内容提供绘制支持。
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end
