//
//  HQL9_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL9_1ViewController.h"

@interface HQL9_1ViewController () <CAAnimationDelegate>

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UITextField *durationField;
@property (nonatomic, weak) IBOutlet UITextField *repeatField;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation HQL9_1ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载一张“飞船”图片，作为 CALayer 图层
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
}

#pragma mark - IBActions

- (IBAction)startAnimation:(id)sender {
    // 从「文本输入框」读取「动画一次执行的持续时间」和「执行次数」
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeatCount = [self.repeatField.text floatValue];
        
    // 添加旋转飞船动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    
    //disable controls
    [self setControlsEnabled:NO];
}

- (IBAction)hideKeyboard
{
    [self.durationField resignFirstResponder];
    [self.repeatField resignFirstResponder];
}

#pragma mark - Private

- (void)setControlsEnabled:(BOOL)enabled
{
    for (UIControl *control in @[self.durationField, self.repeatField, self.startButton])
    {
        control.enabled = enabled;
        control.alpha = enabled? 1.0f: 0.25f;
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //re-enable controls
    [self setControlsEnabled:YES];
}

@end
