//
//  HQL2_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL2_3ViewController.h"

@interface HQL2_3ViewController ()

@property (weak, nonatomic) IBOutlet UIView *coneView;
@property (weak, nonatomic) IBOutlet UIView *shipView;
@property (weak, nonatomic) IBOutlet UIView *iglooView;
@property (weak, nonatomic) IBOutlet UIView *anchorView;

@end

@implementation HQL2_3ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 图片拼合技术
    // 一次性加载一张包含多张小图的大图
    // 提高载入性能，单张大图比多张小图载入地更快
    UIImage *image = [UIImage imageNamed:@"Sprites"];
    
    // 雪屋
    [self addSpriteImage:image
         withContentRect:CGRectMake(0, 0, 0.5, 0.5)
                 toLayer:self.iglooView.layer];
    
    // 锥体
    [self addSpriteImage:image
         withContentRect:CGRectMake(0.5, 0, 0.5, 0.5)
                 toLayer:self.coneView.layer];
    
    // 船锚
    [self addSpriteImage:image
         withContentRect:CGRectMake(0, 0.5, 0.5, 0.5)
                 toLayer:self.anchorView.layer];
    
    // 飞船
    [self addSpriteImage:image
         withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5)
                 toLayer:self.shipView.layer];
}

#pragma mark - Private

- (void)addSpriteImage:(UIImage *)image
       withContentRect:(CGRect)rect
               toLayer:(CALayer *)layer
{
    // 设置图片
    layer.contents = (__bridge id)image.CGImage;
    
    // 缩放内容以自适应大小
    layer.contentsGravity = kCAGravityResizeAspect;
    
    // 设置 contentsRect 属性
    layer.contentsRect = rect;
}


@end
