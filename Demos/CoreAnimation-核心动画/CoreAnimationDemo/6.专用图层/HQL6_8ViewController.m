//
//  HQL6_8ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL6_8ViewController.h"

@interface HQL6_8ViewController () <CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) CATiledLayer *tiledLayer;

@end

@implementation HQL6_8ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 添加 CATiledLayer 砖块图层
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(0, 0, 2048, 2048);
    tileLayer.delegate = self;
    
    // 为了以屏幕的原生分辨率来渲染 CATiledLayer，我们需要设置图层的 contentsScale 来匹配 UIScreen 的 scale 属性
    tileLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.scrollView.layer addSublayer:tileLayer];
    self.tiledLayer = tileLayer;
    
    // configure the scroll view
    self.scrollView.contentSize = tileLayer.frame.size;
    
    // draw layer
    [tileLayer setNeedsDisplay];
}

// 解除引用，防止应用崩溃
- (void)dealloc {
    self.tiledLayer.delegate = nil;
}

#pragma mark - CALayerDelegate

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx
{
    // determine tile coordinate 确定平铺坐标
//    CGRect bounds = CGContextGetClipBoundingBox(ctx);
//    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
//    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    //determine tile coordinate
    // 通过这个方法纠正 scale 也意味着我们的雪人图将以一半的大小渲染在 Retina 设备上（总尺寸是 1024*1024，而不是 2048*2048）。
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    CGFloat scale = [UIScreen mainScreen].scale;
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width * scale);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height * scale);
    
    // load tile image 加载砖块图片
    NSString *imageName = [NSString stringWithFormat:@"Snowman_%02li_%02li", (long)x, (long)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    // draw tile 绘制砖块
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

@end

/*
 注：
 当你滑动这个图片时，你会发现当 CATiledLayer 载入小图的时候，他们会淡入到界面中。这是 CATiledLayer 的默认行为。（你可能已经在 iOS 6 之前的苹果地图程序中见过这个效果）你可以用 fadeDuration 属性改变淡入时长或直接禁用掉。CATiledLayer（不同于大部分的 UIKit 和 Core Animation 方法）支持多线程绘制，
 -drawLayer:inContext: 方法可以在多个线程中同时地并发调用，所以请小心谨慎地确保你在这个方法中实现的绘制代码是线程安全的。
 
 
 */
