//
//  BQDragCardView.h
//  BQCardAnimation
//
//  Created by wbq on 17/5/8.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BQDragCardViewComplete)(void);

@interface BQDragCardView : UIView

@property (strong, nonatomic)  NSMutableArray *disPlayCardArr;
@property (strong, nonatomic)  NSMutableArray *sourceObjectArr;

@end
