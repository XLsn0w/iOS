//
//  HQL5_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL5_3ViewController.h"

@interface HQL5_3ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *layerView;

@end

@implementation HQL5_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 对视图内的图层绕 Y 轴做 45 度角的旋转
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
}

/*
 看起来图层并没有被旋转，而是仅仅在水平方向上的一个压缩，是哪里出了问题呢？
 其实完全没错，视图看起来更窄实际上是因为我们在用一个斜向的视角看它，而不是透视。
 */

@end
