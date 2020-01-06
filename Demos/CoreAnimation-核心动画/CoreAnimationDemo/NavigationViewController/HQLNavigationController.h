//
//  HQLNavigationController.h
//  XuZhouSS
//
//  Created by ToninTech on 2017/6/28.
//  Copyright © 2017年 ToninTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQLNavigationController : UINavigationController

/*
 删除导航栏底部线条
 
 推荐替代方法：位于 ChameleonDemo：该方法会把所有页面的底部线条删除
 self.navigationController.hidesNavigationBarHairline = YES;
 */
- (void)removeUnderline;

@end
