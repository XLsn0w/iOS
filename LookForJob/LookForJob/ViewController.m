//
//  ViewController.m
//  LookForJob
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 XLsn0w. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSDefaultRunLoopMode
    
//    Default（NSDefaultRunLoopMode）：默认，一般情况下使用；
//    Connection（NSConnectionReplyMode）：一般系统用来处理NSConnection相关事件，开发者一般用不到；
//    Modal（NSModalPanelRunLoopMode）：处理modal panels事件；
//    Event Tracking（NSEventTrackingRunLoopMode）：用于处理拖拽和用户交互的模式。
//    Common（NSRunloopCommonModes）：模式合集。默认包括Default，Modal，Event Tracking三大模式，可以处理几乎所有事件。
    
    // 方法1
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeat:) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    // 方法2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeat:) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] run];
    });
}


@end
