//
//  HQL16_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/30.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL16_3ViewController.h"

@interface HQL16_3ViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@end

@implementation HQL16_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCornerRadiusWithView1];
    [self setCornerRadiusWithView2];
    [self setCornerRadiusWithView3];
    
}

- (void)setCornerRadiusWithView1 {
    
    self.view1.layer.cornerRadius = 30;
    self.view1.layer.masksToBounds = YES;
}

- (void)setCornerRadiusWithView2 {
    // 创建左上角和右上角是圆角的贝塞尔曲线路径
    UIRectCorner rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view1.bounds
                                               byRoundingCorners:rectCorner
                                                     cornerRadii:CGSizeMake(30, 30)];
    
    // 创建 CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    
    // 设置图层蒙版
    self.view2.layer.mask = shapeLayer;
    
}

- (void)setCornerRadiusWithView3 {
        // 创建左下角和右下角是圆角的贝塞尔曲线路径
        UIRectCorner rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view3.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(30, 30)];
        
        // 创建 CAShapeLayer 图层
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        
        // 设置图层蒙版
        self.view3.layer.mask = shapeLayer;
}

@end
