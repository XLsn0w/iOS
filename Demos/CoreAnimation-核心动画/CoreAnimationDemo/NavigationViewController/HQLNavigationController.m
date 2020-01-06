//
//  HQLNavigationController.m
//  XuZhouSS
//
//  Created by ToninTech on 2017/6/28.
//  Copyright © 2017年 ToninTech. All rights reserved.
//

#import "HQLNavigationController.h"

@interface HQLNavigationController ()

@end

@implementation HQLNavigationController

#pragma mark - Lifecycle

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Public

- (void)removeUnderline {
    [self.navigationBar setShadowImage:[UIImage new]];
}

// 执行此方法时，统一设置下一个视图控制器的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 第一个controller左button不确定, 其他controller左button为特定样式
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:nil];
        viewController.navigationItem.backBarButtonItem = backBarButtonItem;
        // 从第二个视图控制器开始，推入下一个视图控制器时隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
