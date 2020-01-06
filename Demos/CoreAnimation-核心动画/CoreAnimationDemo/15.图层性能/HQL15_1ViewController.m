//
//  HQL15_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL15_1ViewController.h"

@interface HQL15_1ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation HQL15_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个 CAShapeLayer
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.fillColor = [UIColor blueColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:
                      CGRectMake(0, 0, 100, 100) cornerRadius:20].CGPath;
    
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];
}



@end
