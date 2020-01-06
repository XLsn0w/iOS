//
//  HQL5_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL5_2ViewController.h"

@interface HQL5_2ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *layerView;

@end

@implementation HQL5_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 混合变换：先缩小 50%，再旋转 30 度，最后向右移动 200 个像素
    
    // 创建一个空的单位矩阵
    CGAffineTransform transform = CGAffineTransformIdentity;
    // 缩小 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    // 旋转 30 度
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
    // 向右移动 200 个像素
    transform = CGAffineTransformTranslate(transform, 200, 0);
    // 将变换添加到图层
    self.layerView.layer.affineTransform = transform;
}

/*
 注：
 图片向右边发生了平移，但并没有指定距离那么远（200 像素），另外它还有点向下发生了平移。
 原因在于当你按顺序做了变换，上一个变换的结果将会影响之后的变换，所以 200 像素的向右平移同样也被旋转了 30 度，缩小了 50%，所以它实际上是斜向移动了 100 像素。
 
 这意味着变换的顺序会影响最终的结果，也就是说「旋转之后的平移」和「平移之后的旋转」结果可能不同。
 */



@end
