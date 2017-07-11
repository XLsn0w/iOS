//
//  LS_jumpStarView.h
//  LSLearnAni06
//
//  Created by xiaoT on 16/4/4.
//  Copyright © 2016年 赖三聘. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NONMark,
    Mark,
}STATE;

@interface LS_jumpStarView : UIView

@property (nonatomic, assign, setter=setState:) STATE state;

@property (nonatomic, strong) UIImage *markImage;

@property (nonatomic, strong) UIImage *non_markImage;

-(void)animation;
@end
