//
//  HQL6_5ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL6_5ViewController.h"

@interface HQL6_5ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HQL6_5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create a replicator layer and add it to our view
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    // 指定图层重复次数
    replicator.instanceCount = 10;
    
    // 为每个实例设置 CATransform3D 位移转换
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    // 为每个实例应用颜色偏移，逐步减少蓝色、绿色通道值
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    // create a sublayer and place it inside the replicator
    // 在 CAReplicatorLayer 中创建一个白色背景的 CALayer 作为基础图层
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(150.0f, 150.0f, 80.0f, 80.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

@end
