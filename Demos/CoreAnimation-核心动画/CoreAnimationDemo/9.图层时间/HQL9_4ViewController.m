//
//  HQL9_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL9_4ViewController.h"

@interface HQL9_4ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *doorLayer;

@end

@implementation HQL9_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加图层：门
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, 128, 256);
    self.doorLayer.position = CGPointMake(150 - 64, 150);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door.png"].CGImage;
    [self.containerView.layer addSublayer:self.doorLayer];
    
    // 添加 3D透视变换
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    // 添加「平移手势识别器」以处理滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    // 暂停所有图层动画
    self.doorLayer.speed = 0.0;
    
    // 添加摇摆动画 (动画不会被播放，因为动画已经在图层级别被暂停了)
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [self.doorLayer addAnimation:animation forKey:nil];
}

/// 获取平移手势的水平偏移量，用这个偏移值去更新 timeOffset 调整动画播放位置，达到手动控制动画的效果
- (void)pan:(UIPanGestureRecognizer *)pan
{
    // get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    
    //convert from points to animation duration
    //using a reasonable scale factor
    x /= 200.0f;
    
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;

    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}

@end
