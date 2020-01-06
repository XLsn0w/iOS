//
//  HQL5_6ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL5_6ViewController.h"

@interface HQL5_6ViewController ()

@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet UIView *innerView;

@property (weak, nonatomic) IBOutlet UIView *outerView2;
@property (weak, nonatomic) IBOutlet UIView *innerView2;

@end

@implementation HQL5_6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScenes1];
    
    [self setupScenes2];
}

// 场景1:绕 Z 轴做相反的旋转变换
- (void)setupScenes1 {
    // 外视图绕 Z 轴正向旋转 45°
    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.outerView.layer.transform = outer;
    
    // 内视图绕 Z 轴反向旋转 45°
    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.innerView.layer.transform = inner;
}

// 场景2:让内外两个视图绕 Y 轴旋转，再加上透视效果
- (void)setupScenes2 {
    CATransform3D outer = CATransform3DIdentity;
    // 添加透视效果
    outer.m34 = -1.0 / 500.0;
    // 外视图绕 Y 轴旋转 45°
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.outerView2.layer.transform = outer;
    
    // 内视图绕 Y 轴反向旋转 45°
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.innerView2.layer.transform = inner;
}

@end
