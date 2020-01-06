//
//  HQL6_11ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/20.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL6_11ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface HQL6_11ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HQL6_11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取视频 URL
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
    
    // 获取视频 URL 方法二
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"Ship" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:videoPath];
    
    // 创建播放器和播放器图层
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];

    // 设置播放器图层边界，并添加到视图中
    playerLayer.frame = self.containerView.bounds;
    playerLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:playerLayer];
    
    // 旋转图层
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;
    
    // 添加圆角和边框
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0;

    // 播放视频
    [player play];
}

@end
