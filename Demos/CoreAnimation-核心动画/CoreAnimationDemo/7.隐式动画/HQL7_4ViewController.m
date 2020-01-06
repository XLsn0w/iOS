//
//  HQL7_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL7_4ViewController.h"

@interface HQL7_4ViewController ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation HQL7_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个 CALayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2,
                                           self.view.bounds.size.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // check if we've tapped the moving layer
    // 通过呈现图层的值来获取当前屏幕上真正显示出来的值。
    // 呈现图层代表了用户当前看到的图层位置，而不是当前动画结束之后的位置。
    /*
     [self.colorLayer.presentationLayer hitTest:point] 表示：
     判断触摸点是不是在 colorLayer 当前呈现的图层上（可能这个图层正在移动中）
     
     [self.colorLayer hitTest:point]
     判断触摸点是不是在 colorLayer 的模型图层上（只能判断起点和终点，无法判断移动过程中的位置）
     */
    
    
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        // 1.如果「触摸点在当前呈现图层上」，设置图层的随机背景颜色
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red
                                                          green:green
                                                           blue:blue
                                                          alpha:1.0].CGColor;
    } else {
        // 2.否则缓慢移动图层到触摸点的坐标位置
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0]; // 设置新事务的动画时长为 4s，默认为 0.25s
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}


@end
