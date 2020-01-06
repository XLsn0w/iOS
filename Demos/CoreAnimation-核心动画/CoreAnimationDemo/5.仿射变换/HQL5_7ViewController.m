//
//  HQL5_7ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL5_7ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface HQL5_7ViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *faces;

@end

@implementation HQL5_7ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化容器视图，设置 透视、sublayerTransform 属性
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    // 通过调整容器视图的 sublayerTransform 去旋转照相机视角
    // X 轴、Y 轴方向反向旋转 45°
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;

    // 添加立方体面1 - 沿着 Z 轴方向作 3D 平移 100 像素
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];

    // 添加立方体面2 - 沿着 X 轴方向作 3D 平移 100 像素
    transform = CATransform3DMakeTranslation(100, 0, 0);
    // 沿着 Y 轴方向作 3D 旋转 90°
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];

    //add cube face 3
    //move this code after the setup for face no. 6 to enable button
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];

    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];

    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];

    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];

}

#pragma mark - Private

// 添加立方体
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    // 获取立方体的每个面，然后将它们添加到容器视图中
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];

    // 将容器视图中的每个面视图居中放置
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0,
                              containerSize.height / 2.0);

    // 添加旋转
    face.layer.transform = transform;

    // 为立方体的每个面的 layer 图层添加光亮效果
    [self applyLightingToFace:face.layer];
}

// 通过 <GLKit> 框架对每个面应用光亮效果
- (void)applyLightingToFace:(CALayer *)face {

    // 添加光影图层
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];

    /*

     将每个面的 CATransform3D 值转换成 GLKMatrix4，然后通过 GLKMatrix4GetMatrix3 函数得出一个 3×3 的旋转矩阵。
     这个旋转矩阵指定了图层的方向，然后可以用它来得到正太向量的值。

     */
  //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    // convert face transform to matrix
    // (GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);

    // get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);

    // get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);

    // set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

#pragma mark - IBActions

// 响应按钮点击事件
// 注：把除了表面 3 的其他视图 userInteractionEnabled 属性都设置成 NO 来禁止事件传递。
- (IBAction)buttonDidClicker:(id)sender {
    // 1.实例化alertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题"
                                                                   message:@"消息"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // 2.实例化按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       // 点击按钮，调用此block
                                                       NSLog(@"Button Click");
                                                   }];
    [alert addAction:action];
    
    //  3.显示alertController
    [self presentViewController:alert animated:YES completion:nil];
}

@end
