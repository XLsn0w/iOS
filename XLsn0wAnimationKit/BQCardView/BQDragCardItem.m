//
//  BQCardView.m
//  BQCardAnimation
//
//  Created by wbq on 17/5/4.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BQDragCardItem.h"
#import "Define.h"

@interface BQDragCardItem ()

/**
 * x轴距离中心的位置
 */
@property (nonatomic,assign)CGFloat xFromCenter;

/**
 * y轴距离中心的位置
 */
@property (nonatomic,assign)CGFloat yFromCenter;

/**
 * 卡片飞出去倾斜角度
 */
@property (nonatomic,assign)CGFloat rotationAngel;

@end

@implementation BQDragCardItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius      = 4;
        self.layer.shadowRadius      = 3;
        self.layer.shadowOpacity     = 0.2;
        self.layer.shadowOffset      = CGSizeMake(1, 1);
        self.layer.shadowPath        = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        
        UIView *bgView            = [[UIView alloc]initWithFrame:self.bounds];
        bgView.layer.cornerRadius = 4;
        bgView.clipsToBounds      = YES;
        bgView.backgroundColor = BQRandomColor_RGB;
        [self addSubview:bgView];
        //消除锯齿
        self.layer.allowsEdgeAntialiasing                 = YES;
        bgView.layer.allowsEdgeAntialiasing               = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self  addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        panGesture.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panGesture];
        
    }
    return self;
}



-(void)panGesture:(UIPanGestureRecognizer *)gesture {

 
    self.xFromCenter = [gesture translationInView:self].x;
    self.yFromCenter = [gesture translationInView:self].y;
    
    //translationInView : 手指在视图上移动的位置（x,y）向下和向右为正，向上和向左为负。
    //locationInView ： 手指在视图上的位置（x,y）就是手指在视图本身坐标系的位置。
    //velocityInView： 手指在视图上移动的速度（x,y）, 正负也是代表方向，值得一体的是在绝对值上|x| > |y| 水平移动， |y|>|x| 竖直移动。


    
    //NSLog(@"%@", NSStringFromCGPoint([gesture translationInView:self]));
    //NSLog(@"%@", NSStringFromCGPoint([gesture locationInView:self]));
    NSLog(@"%@", NSStringFromCGPoint([gesture velocityInView:self]));
    
    
    switch (gesture.state) {
            
        case UIGestureRecognizerStateBegan:
        {
            
            CGFloat  locationY = [gesture locationInView:self].y;
            
            if(locationY < self.frame.size.height/2)
            {
                //在卡片的上半部分,正方向倾斜
                self.rotationAngel =   ROTATION_ANGLE;
            }else
            {
                //在卡片的下半部分,负方向倾斜
                self.rotationAngel =  -ROTATION_ANGLE;
            
            }
        
        }
            break;
            
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat rotationStrength = MIN(self.xFromCenter / SCREEN_WIDTH, 1.0);
            
            CGFloat temoRotationAngel;
            
            temoRotationAngel = (CGFloat) self.rotationAngel * rotationStrength;
        
            //改变中心点
            self.center = CGPointMake(self.originalCenter.x + self.xFromCenter, self.originalCenter.y + self.yFromCenter);
            
            //伴随旋转
            self.transform = CGAffineTransformMakeRotation(temoRotationAngel);
            
            //将移动距离暴露给外部
            if(self.delegate) [self.delegate moveCardsX:self.xFromCenter Y:self.yFromCenter];
            
        }
            break;
        case UIGestureRecognizerStateEnded: {
            
            //放开手指，进行后续操作
            [self followUpActionWithDistance:self.xFromCenter andVelocity:[gesture velocityInView:self.superview]];
        }
            break;
            
        default:
            break;
    }
    



}


-(void)tapGesture:(UITapGestureRecognizer *)gesture {
    
    
    
    
    
}

#pragma mark ----------- 后续动作判断
-(void)followUpActionWithDistance:(CGFloat)distance andVelocity:(CGPoint)velocity {
    if (self.xFromCenter > 0 && (distance > ACTION_MARGIN_RIGHT || velocity.x > ACTION_VELOCITY )) {
        [self rightAction:velocity];
    } else if(self.xFromCenter < 0 && (distance < - ACTION_MARGIN_RIGHT || velocity.x < -ACTION_VELOCITY)) {
        [self leftAction:velocity];
    }else {
        //回到原点
        [UIView animateWithDuration:RESET_ANIMATION_TIME delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            self.center = self.originalCenter;
            
            self.transform = CGAffineTransformMakeRotation(0);
            
        } completion:nil];
        
        
        [self.delegate moveBackCards];
    }
}

#pragma mark ----------- 自然右边飞出
-(void)rightAction:(CGPoint)velocity {
    
    CGFloat distanceX= SCREEN_WIDTH + self.frame.size.width ;//横向移动距离
    CGFloat distanceY=distanceX * self.yFromCenter / self.xFromCenter;//纵向移动距离
    CGPoint finishPoint = CGPointMake(distanceX, self.originalCenter.y + distanceY);//目标center点
    
    CGFloat vel = sqrtf(pow(velocity.x, 2)+pow(velocity.y, 2));//滑动手势横纵合速度
    CGFloat displace = sqrt(pow(distanceX - self.xFromCenter,2)+pow(distanceY - self.yFromCenter,2));//需要动画完成的剩下距离
    
    CGFloat duration=fabs(displace/vel);//动画时间
    
    if (duration>0.4) {
        duration=0.4;
    }else if(duration<0.1){
        duration=0.1;
    }
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                        self.center = finishPoint;
                         
                        self.transform = CGAffineTransformMakeRotation(self.rotationAngel);
                         
                     }completion:^(BOOL complete){
                         
                        [self.delegate swipCard:self Direction:YES];
                         
                     }];
    
    //调整别的卡片
    [self.delegate adjustOtherCards];
    
}

#pragma mark ----------- 自然左边飞出
-(void)leftAction:(CGPoint)velocity {
    //横向移动距离
    CGFloat distanceX = - self.frame.size.width - self.originalCenter.x;
    //纵向移动距离
    CGFloat distanceY = distanceX * self.yFromCenter/ self.xFromCenter;
    //目标center点
    CGPoint finishPoint = CGPointMake(distanceX, self.originalCenter.y+ distanceY );
    
    CGFloat vel = sqrtf(pow(velocity.x, 2) + pow(velocity.y, 2));
    CGFloat displace = sqrtf(pow(distanceX - self.xFromCenter, 2) + pow(distanceY - self.yFromCenter, 2));
    
    CGFloat duration = fabs(displace/vel);
    if (duration>0.4) {
        duration = 0.4;
    }else if(duration < 0.1) {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.center = finishPoint;
                         
                         self.transform = CGAffineTransformMakeRotation( - self.rotationAngel);
                  
                         
                     } completion:^(BOOL finished) {
                         
                         [self.delegate swipCard:self Direction:NO];
                     }];
    
    [self.delegate adjustOtherCards];
}

#pragma mark ----------- 按钮右边飞出
-(void)rightButtonClickAction {
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    CGPoint finishPoint = CGPointMake(SCREEN_WIDTH+ self.frame.size.width *2/3, 2 *PAN_DISTANCE + self.frame.origin.y);
    
    [UIView animateWithDuration:CLICK_ANIMATION_TIME
                     animations:^{
                         
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(ROTATION_ANGLE);
                         
                     } completion:^(BOOL finished) {
                        
                         [self.delegate swipCard:self Direction:YES];
                         
                     }];
    
    [self.delegate adjustOtherCards];
}

#pragma mark ----------- 按钮左边飞出
-(void)leftButtonClickAction {
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    CGPoint finishPoint = CGPointMake(- self.frame.size.width *2/3, 2 *PAN_DISTANCE + self.frame.origin.y);
    [UIView animateWithDuration:CLICK_ANIMATION_TIME
                     animations:^{
                        
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                         
                     } completion:^(BOOL finished) {
                         
                         [self.delegate swipCard:self Direction:NO];
                         
                     }];
    [self.delegate adjustOtherCards];
}


@end
