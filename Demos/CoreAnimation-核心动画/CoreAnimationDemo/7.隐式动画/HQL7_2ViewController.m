//
//  HQL7_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL7_2ViewController.h"

@interface HQL7_2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation HQL7_2ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 直接设置 layerView 图层的背景色
    self.layerView.layer.backgroundColor = [UIColor blueColor].CGColor;
    
    // 测试 UIView 的 actionForLayer:forKey: 实现
    [self testUIViewDefaultAction];
}

// 清单 7.5
// 当属性在动画块之外发生改变，UIView 直接通过返回 nil 来禁用隐式动画。
// 但如果在动画块范围之内，根据动画具体类型返回相应的属性。
- (void)testUIViewDefaultAction {
    // 在 animation block 之外测试图层行为
    NSLog(@"Outside: %@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    // 输出：Outside: <null>
    
    // 开始 animation block
    [UIView beginAnimations:nil context:nil];
    
    // 在 animation block 之内测试图层行为
    NSLog(@"Inside: %@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    // 输出：Inside: <CABasicAnimation: 0x280374420>
    
    // 结束 animation block
    [UIView commitAnimations];
}

#pragma mark - IBActions

- (IBAction)changeColor:(id)sender {
    
    // 开始一个新的事务
    [CATransaction begin];
    
    // 当然返回 nil 并不是禁用隐式动画唯一的办法，CATransacition 有个方法叫做 +setDisableActions:，可以用来对所有属性打开或者关闭隐式动画。
    // [CATransaction setDisableActions:YES];
    
    // 设置新事务的动画时长为 1s，默认为 0.25s
    [CATransaction setAnimationDuration:1.0];
    
//    // 添加完成块：每次颜色变化结束之后切换到另一个旋转 90° 的动画
//    // 注意旋转动画要比颜色渐变快得多，这是因为完成块是在颜色渐变的事务提交并出栈之后才被执行，
//    // 于是，用默认的事务做变换，默认的时间也就变成了 0.25 秒。
//    [CATransaction setCompletionBlock:^{
//        // 旋转图层 90°
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.colorLayer.affineTransform = transform;
//    }];
    
    // 随机改变图层背景颜色
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.layerView.layer.backgroundColor = [UIColor colorWithRed:red
                                                      green:green
                                                       blue:blue
                                                      alpha:1.0].CGColor;
    
    // 执行事务
    [CATransaction commit];
}

@end
