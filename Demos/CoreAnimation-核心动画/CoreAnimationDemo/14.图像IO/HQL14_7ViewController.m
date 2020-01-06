//
//  HQL14_7ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL14_7ViewController.h"

@interface HQL14_7ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HQL14_7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 压缩 RGB 部分的 JPEG 图片
    UIImage *image = [UIImage imageNamed:@"Snowman.jpg"];
    
    // 压缩透明通道的 PNG 图片
    UIImage *mask = [UIImage imageNamed:@"SnowmanMask.png"];
    
    // 将遮罩转换为正确格式
    //convert mask to correct format
    CGColorSpaceRef graySpace = CGColorSpaceCreateDeviceGray();
    CGImageRef maskRef = CGImageCreateCopyWithColorSpace(mask.CGImage, graySpace);
    CGColorSpaceRelease(graySpace);
    
    // 组合图片
    //combine images
    CGImageRef resultRef = CGImageCreateWithMask(image.CGImage, maskRef);
    UIImage *result = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    CGImageRelease(maskRef);
    
    //display result
    self.imageView.image = result;
}



@end
