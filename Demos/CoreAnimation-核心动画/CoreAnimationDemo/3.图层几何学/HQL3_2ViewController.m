//
//  HQL3_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL3_2ViewController.h"

@interface HQL3_2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIView *redView;

@end

@implementation HQL3_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给 zPosition 提高一个像素就可以让绿色视图前置
    //move the green view zPosition nearer to the camera
    self.greenView.layer.zPosition = 1.0f;
}

@end
