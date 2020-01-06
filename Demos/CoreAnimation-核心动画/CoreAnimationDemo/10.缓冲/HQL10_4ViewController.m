//
//  HQL10_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/25.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL10_4ViewController.h"

@interface HQL10_4ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;
@property (weak, nonatomic) IBOutlet UIView *layerView3;
@property (weak, nonatomic) IBOutlet UIView *layerView4;
@property (weak, nonatomic) IBOutlet UIView *layerView5;

@end

@implementation HQL10_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     Timing function names. 时间缓冲函数名称

     CA_EXTERN CAMediaTimingFunctionName const kCAMediaTimingFunctionLinear
         API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
     CA_EXTERN CAMediaTimingFunctionName const kCAMediaTimingFunctionEaseIn
         API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
     CA_EXTERN CAMediaTimingFunctionName const kCAMediaTimingFunctionEaseOut
         API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
     CA_EXTERN CAMediaTimingFunctionName const kCAMediaTimingFunctionEaseInEaseOut
         API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
     CA_EXTERN CAMediaTimingFunctionName const kCAMediaTimingFunctionDefault
         API_AVAILABLE(macos(10.6), ios(3.0), watchos(2.0), tvos(9.0));
     */
    
    [self createBezierPathWithCAMediaTimingFunction:kCAMediaTimingFunctionLinear
                                        atLayerView:self.layerView1];
    [self createBezierPathWithCAMediaTimingFunction:kCAMediaTimingFunctionEaseIn
                                        atLayerView:self.layerView2];
    [self createBezierPathWithCAMediaTimingFunction:kCAMediaTimingFunctionEaseOut
                                        atLayerView:self.layerView3];
    [self createBezierPathWithCAMediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut
                                        atLayerView:self.layerView4];
    [self createBezierPathWithCAMediaTimingFunction:kCAMediaTimingFunctionDefault
                                        atLayerView:self.layerView5];
}

// 使用 UIBezierPath 绘制 CAMediaTimingFunction 自定义缓冲函数
- (void)createBezierPathWithCAMediaTimingFunction:(CAMediaTimingFunctionName)name
                                      atLayerView:(UIView *)view {
    
    // 根据 CAMediaTimingFunction 的三次贝塞尔曲线创建 UIBezierPath
    // 创建缓冲函数
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:name];
    
    // CAMediaTimingFunction 使用了一个三次贝塞尔曲线函数
    // 获取贝塞尔曲线的控制点坐标
    //    CGPoint controlPoint1, controlPoint2;
    //    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    //    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    float poi [2];
    [function getControlPointAtIndex:1 values:poi];
    CGPoint controlPoint1 = CGPointMake(poi[0], poi[1]);
    
    [function getControlPointAtIndex:2 values:poi];
    CGPoint controlPoint2 = CGPointMake(poi[0], poi[1]);
    
    
    // 根据以上的两个控制点坐标创建一个新的贝塞尔曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];         // 贝塞尔曲线起点
    [path addCurveToPoint:CGPointMake(1, 1) // 贝塞尔曲线终点
            controlPoint1:controlPoint1     // 贝塞尔曲线控制点1
            controlPoint2:controlPoint2];   // 贝塞尔曲线控制点2
    
    // 将贝塞尔曲线路径缩放到合理的尺寸以进行显示
    [path applyTransform:CGAffineTransformMakeScale(150, 150)];
    
    // 创建 CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.path = path.CGPath;
    [view.layer addSublayer:shapeLayer];
    
    // 翻转几何体，以便 （0,0） 位于界面左下角
    view.layer.geometryFlipped = YES;
}


@end
