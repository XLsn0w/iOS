//
//  HQL15_3ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL15_3ViewController.h"

/*
 WIDTH，HEIGHT 和 DEPTH 常量控制着图层的生成。
 在这个情况下，我们得到的是 10*10*10 个图层，总量为 1000 个，不过一次性显示在屏幕上的大约就几百个。
 
 如果把 WIDTH 和 HEIGHT 常量增加到 100，我们的程序就会慢得像龟爬了。
 这样我们有了 100000 个图层，性能下降一点儿也不奇怪。
 */
#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10

#define SIZE 100
#define SPACING 150

#define CAMERA_DISTANCE 500

@interface HQL15_3ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HQL15_3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set content size
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING,
                                             (HEIGHT - 1)*SPACING);
    
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
    
    //create layers
    for (int z = DEPTH - 1; z >= 0; z--)
    {
        for (int y = 0; y < HEIGHT; y++)
        {
            for (int x = 0; x < WIDTH; x++)
            {
                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1 - z*(1.0/DEPTH)
                                                          alpha:1].CGColor;
                
                //attach to scroll view
                [self.scrollView.layer addSublayer:layer];
            }
        }
    }
    
    //log
    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
}

@end
