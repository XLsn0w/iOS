//
//  HQL8_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_1ViewController.h"

@interface HQL8_1ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@property (weak, nonatomic) IBOutlet UIView *view1;


@end

@implementation HQL8_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建子图层
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // 添加子图层到视图中
    [self.layerView.layer addSublayer:self.colorLayer];
}

// 动画完成后修改图层背景色
- (IBAction)changeColor:(id)sender {
    // 创建随机色
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 创建基础动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.fromValue = (__bridge id)self.colorLayer.backgroundColor;
    animation.toValue = (__bridge id)color.CGColor;
    animation.duration = 0.5;
    // 在动画执行过程中保留最后一帧，解决“回退”问题
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    // 添加动画到图层
    [self.colorLayer addAnimation:animation forKey:@"keyvalue"];
}

// 平移动画
- (IBAction)movePosition:(id)sender {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    //basicAnimation.fromValue = @30;
    basicAnimation.toValue = @200;
    basicAnimation.duration = 2.0;
    // 在动画执行过程中保留最后一帧
    basicAnimation.fillMode = kCAFillModeForwards;
    /*
     一般说来，动画在结束之后被自动移除，除非设置 removedOnCompletion 为 NO，如果你设置动画在结束之后不被自动移除，那么当它不需要的时候你要手动移除它；
     否则它会一直存在于内存中，直到图层被销毁。
     */
    basicAnimation.removedOnCompletion = NO;
    [self.view1.layer addAnimation:basicAnimation forKey:nil];
    
}


#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    //set the backgroundColor property to match animation toValue
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

@end
