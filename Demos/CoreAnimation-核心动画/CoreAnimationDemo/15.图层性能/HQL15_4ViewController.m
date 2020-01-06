//
//  HQL15_4ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL15_4ViewController.h"

/*
WIDTH，HEIGHT 和 DEPTH 常量控制着图层的生成。
在这个情况下，我们得到的是 10*10*10 个图层，总量为 1000 个，不过一次性显示在屏幕上的大约就几百个。

如果把 WIDTH 和 HEIGHT 常量增加到 100，我们的程序就会慢得像龟爬了。
这样我们有了 100000 个图层，性能下降一点儿也不奇怪。
*/
#define WIDTH 100
#define HEIGHT 100
#define DEPTH 10

#define SIZE 100
#define SPACING 150

#define CAMERA_DISTANCE 500
#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)

@interface HQL15_4ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HQL15_4ViewController

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
}

- (void)viewDidLayoutSubviews
{
    [self updateLayers];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateLayers];
}

- (void)updateLayers
{
    //calculate clipping bounds
    CGRect bounds = self.scrollView.bounds;
    bounds.origin = self.scrollView.contentOffset;
    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
    
    //create layers
    NSMutableArray *visibleLayers = [NSMutableArray array];
    for (int z = DEPTH - 1; z >= 0; z--)
    {
        //increase bounds size to compensate for perspective
        CGRect adjusted = bounds;
        adjusted.size.width /= PERSPECTIVE(z*SPACING);
        adjusted.size.height /= PERSPECTIVE(z*SPACING);
        adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2;
        adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2;
        
        for (int y = 0; y < HEIGHT; y++)
        {
            //check if vertically outside visible rect
            if (y*SPACING < adjusted.origin.y ||
                y*SPACING >= adjusted.origin.y + adjusted.size.height)
            {
                continue;
            }
            
            for (int x = 0; x < WIDTH; x++)
            {
                //check if horizontally outside visible rect
                if (x*SPACING < adjusted.origin.x ||
                    x*SPACING >= adjusted.origin.x + adjusted.size.width)
                {
                    continue;
                }

                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1 - z*(1.0/DEPTH)
                                                          alpha:1.0].CGColor;
                //attach to scroll view
                [visibleLayers addObject:layer];
            }
        }
    }
    
    //update layers
    self.scrollView.layer.sublayers = visibleLayers;
    
    //log
    NSLog(@"displayed: %lu/%i", (unsigned long)[visibleLayers count], DEPTH*HEIGHT*WIDTH);
}

@end
