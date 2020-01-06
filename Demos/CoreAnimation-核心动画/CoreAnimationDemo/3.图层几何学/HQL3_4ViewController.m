//
//  HQL3_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL3_4ViewController.h"

@interface HQL3_4ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong, nonatomic) CALayer *blueLayer;

@end

@implementation HQL3_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create sublayer
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // add it to our view
    [self.layerView.layer addSublayer:self.blueLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获取主视图上的触摸点
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // 获取触摸的图层
    // 如果触摸点不在图层范围内，返回 nil
    // 如果触摸点在图层范围内，返回「当前最细颗粒度的图层」
    CALayer *layer = [self.layerView.layer hitTest:point];
    
    if (layer == self.blueLayer) {
        // 1.实例化alertController
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Blue Layer"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        // 2.实例化按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
        [alert addAction:action];
        
        //  3.显示alertController
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        // 1.实例化alertController
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"White Layer"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        // 2.实例化按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
        [alert addAction:action];
        
        //  3.显示alertController
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end
