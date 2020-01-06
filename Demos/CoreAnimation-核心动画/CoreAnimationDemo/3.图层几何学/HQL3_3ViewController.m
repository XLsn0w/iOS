//
//  HQL3_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL3_3ViewController.h"

@interface HQL3_3ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong, nonatomic) CALayer *blueLayer;

@end

@implementation HQL3_3ViewController

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
    
    // convert point to the white layer's coordinates
    // 将「主视图上的触摸点坐标」转换到 「白色视图图层上的坐标点」
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    
    // get layer using containsPoint: 被转换的点是否在白色视图的图层上
    if ([self.layerView.layer containsPoint:point]) {
        
        // 将「白色视图图层上的坐标点」转换到「蓝色图层上」
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        
        if ([self.blueLayer containsPoint:point]) {
            
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
            
        } else {
            
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
}

@end
