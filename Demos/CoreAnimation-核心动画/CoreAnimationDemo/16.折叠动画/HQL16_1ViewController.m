//
//  HQL16_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/28.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL16_1ViewController.h"

@interface HQL16_1ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *rotatedImageView1;
@property (weak, nonatomic) IBOutlet UIView *view1;

@end

@implementation HQL16_1ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置视图的锚点
    self.rotatedImageView1.layer.anchorPoint = CGPointMake(0.5, 0);

    // 创建一个新的 3D 单位矩阵变换
    CATransform3D transform3D = CATransform3DIdentity;
    // 添加透视效果
    transform3D.m34 = - 1.0 / 500.0;
    // 将透视效果添加到图层
    self.rotatedImageView1.layer.transform = transform3D;
}

#pragma mark - IBActions

// 打开
- (IBAction)rotateAnimation:(id)sender {
    
    // 添加属性动画，transform.rotation 是一个虚拟属性
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    // 为动画设置时间缓冲函数
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // 设置旋转角度为 -90 度，
    animation.fromValue = @ M_PI_2;
    animation.toValue = @ 0;
    // duration 表示单次动画的持续时间
    animation.duration = 2;
    animation.delegate = self;
    // 在动画执行过程中保留最后一帧，解决“回退”问题
    animation.fillMode = kCAFillModeForwards;
    /*
     一般说来，动画在结束之后被自动移除，除非设置 removedOnCompletion 为 NO，如果你设置动画在结束之后不被自动移除，那么当它不需要的时候你要手动移除它；
     否则它会一直存在于内存中，直到图层被销毁。
     */
    animation.removedOnCompletion = NO;
    animation.beginTime = CACurrentMediaTime() + 0; // 开始动画时间，默认为 0

    [self.rotatedImageView1.layer addAnimation:animation forKey:nil];

}

// 折叠
- (IBAction)foldingAnimation:(id)sender {
    // 添加属性动画，transform.rotation 是一个虚拟属性
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    // 为动画设置时间缓冲函数
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    // 设置旋转角度为 90 度
    animation.fromValue = @ -M_PI_2;
    animation.toValue = @ 0;
    // duration 表示单次动画的持续时间
    animation.duration = 2;
    animation.delegate = self;
    // 在动画执行过程中保留最后一帧，解决“回退”问题
    animation.fillMode = kCAFillModeForwards;
    /*
     一般说来，动画在结束之后被自动移除，除非设置 removedOnCompletion 为 NO，如果你设置动画在结束之后不被自动移除，那么当它不需要的时候你要手动移除它；
     否则它会一直存在于内存中，直到图层被销毁。
     */
    animation.removedOnCompletion = NO;
    animation.beginTime = CACurrentMediaTime() + 0; // 开始动画时间，默认为 0

    [self.rotatedImageView1.layer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate

// 动画开始时执行
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"%s",__func__);
    self.rotatedImageView1.hidden = NO;
    
    
}

// 当一个完整动画执行完成或者执行动画的视图从父视图上被移除时执行
// 如果是一个完整动画执行完成后调用的这个方法，那么 flag 返回 true
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%s",__func__);
    
    // 动画结束后，移除所有添加到图层上的动画
    [self.rotatedImageView1.layer removeAllAnimations];
    self.rotatedImageView1.hidden = YES;
    
    
}

@end
