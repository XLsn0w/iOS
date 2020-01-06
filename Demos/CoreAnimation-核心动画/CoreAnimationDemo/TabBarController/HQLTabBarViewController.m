//
//  HQLTabBarViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQLTabBarViewController.h"

@interface HQLTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation HQLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

#pragma mark - UITabBarControllerDelegate

// 示例 8.5：显式动画-对图层树的动画
// 在 UITabBarController 切换标签页的时候添加淡入淡出的动画。

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    // 添加过渡动画
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    
    /*
     要确保 CATransition 添加到的图层在过渡动画发生时不会在树状结构中被移除，否则 CATransition 将会和图层一起被移除。
     一般来说，你只需要将动画添加到被影响图层的 superlayer。
     
     把动画添加到 UITabBarController 的视图图层上，于是在标签被替换的时候动画不会被移除。
     */
    [self.view.layer addAnimation:transition forKey:nil];
}

@end
