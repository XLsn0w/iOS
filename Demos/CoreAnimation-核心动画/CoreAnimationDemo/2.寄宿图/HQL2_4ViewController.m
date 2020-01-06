//
//  HQL2_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL2_4ViewController.h"

@interface HQL2_4ViewController ()

@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation HQL2_4ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载按钮图片
    UIImage *image = [UIImage imageNamed:@"Button1"];
    
    // 加载正常大小图片
    // 添加到 layer 层
    self.view0.layer.contents = (__bridge id)image.CGImage;
    // 自适应图片大小，自动拉伸图片以适应图层的边界
    self.view0.layer.contentsGravity = kCAGravityResizeAspect;
    
    // 加载拉伸图片
    //set button 1
    [self addStretchableImage:image
            withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5)
                      toLayer:self.view1.layer];
    
    //set button 2
    [self addStretchableImage:image
            withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5)
                      toLayer:self.view2.layer];
}

#pragma mark - Private

- (void)addStretchableImage:(UIImage *)image
          withContentCenter:(CGRect)rect
                    toLayer:(CALayer *)layer
{
    // 设置图片
    layer.contents = (__bridge id)image.CGImage;
    
    // 设置 contentsCenter 属性
    layer.contentsCenter = rect;
}

@end
