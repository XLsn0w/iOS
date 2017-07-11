//
//  BQDragCardView.m
//  BQCardAnimation
//
//  Created by wbq on 17/5/8.
//  Copyright © 2017年 汪炳权. All rights reserved.

#import "BQDragCardView.h"
#import "BQDragCardItem.h"
#import "Define.h"



//展示的卡片数量
#define CARD_NUM 5

//一级一级的缩小比例
#define CARD_SCALE 0.95

#define CARD_WIDTH 333
#define CARD_HEIGHT 400


@interface BQDragCardView () <BQDragCardItemDelegate>

/**
 *   最后一张卡片的中心点
 */
@property (assign, nonatomic) CGPoint lastCardCenter;

/**
 *   最后一张卡片的位置状态
 */
@property (assign, nonatomic) CGAffineTransform lastCardTransform;

@end

@implementation BQDragCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.disPlayCardArr =  [NSMutableArray new];
        self.sourceObjectArr = [NSMutableArray new];
        
        //创建卡牌
        [self initCards];
        [self addControls];
        
        

        
        
        
        //dispatch_after(一定时间后，将执行的操作加入到队列中)
        /* NSEC_PER_SEC 秒
         * NSEC_PER_MSEC 毫秒
         * NSEC_PER_USEC 微秒
         */
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);

        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self requestSourceData:YES];
        });
    
    }
    return self;
}

#pragma mark ----------- 创建卡牌
-(void)initCards{
    for (int i = 0; i<CARD_NUM; i++) {
        
        BQDragCardItem * card = [[BQDragCardItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH +CARD_WIDTH, self.center.y- CARD_HEIGHT/2, CARD_WIDTH, CARD_HEIGHT)];
        
        if (i > 0&& i < CARD_NUM-1) {
            //一张比一张小
            card.transform = CGAffineTransformScale(card.transform, pow(CARD_SCALE, i), pow(CARD_SCALE, i));
        }else if(i==CARD_NUM-1){
            card.transform = CGAffineTransformScale(card.transform, pow(CARD_SCALE, i-1), pow(CARD_SCALE, i-1));
        }
        card.transform = CGAffineTransformMakeRotation(ROTATION_ANGLE);
        card.delegate = self;
        
        [self.disPlayCardArr addObject:card];
        if (i==0) {
            card.userInteractionEnabled = YES;
        }else{
            card.userInteractionEnabled = NO;
        }
    }
    
    for (int i= CARD_NUM - 1; i >= 0; i--){
        
        //倒序一次加载进来
        [self addSubview:self.disPlayCardArr[i]];
        
    }
}

#pragma mark ----------- 添加控件
-(void)addControls{
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [reloadBtn setTitle:@"重置" forState:UIControlStateNormal];
    reloadBtn.frame = CGRectMake(self.center.x-25, self.frame.size.height-60, 50, 30);
    [reloadBtn addTarget:self action:@selector(refreshAllCards) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadBtn];
}



#pragma mark - 请求数据
-(void)requestSourceData:(BOOL)needRefresh{
    
    /*
     在此添加网络数据请求代码
     */
    
    NSMutableArray *objectArray = [@[] mutableCopy];
    for (int i = 1; i<=10; i++) {
        [objectArray addObject:[NSNumber numberWithInteger:i]];
    }
    
    [self.sourceObjectArr addObjectsFromArray:objectArray];
    
    
    //如果只是补充数据则不需要重新load卡片，而若是刷新卡片组则需要重新load
    if (needRefresh) {
        [self loadAllCards];
    }
    
}

#pragma mark - 重新加载卡片
-(void)loadAllCards{
    
    for (int i=0; i<self.disPlayCardArr.count; i++) {
        
        BQDragCardItem *card=self.disPlayCardArr[i];
        
        if ([self.disPlayCardArr firstObject]) {
            
            [self.sourceObjectArr removeObjectAtIndex:0];
            
            card.hidden=NO;
            
        }else{
            
            card.hidden=YES;//如果没有数据则隐藏卡片
            
        }
    }
    
    for (int i=0; i< self.disPlayCardArr.count ;i++) {
        
        BQDragCardItem * card =self.disPlayCardArr[i];
        
        CGPoint finishPoint = CGPointMake(self.center.x, CARD_HEIGHT/2 + 40);
        
        [UIView animateKeyframesWithDuration:0.5 delay:0.06*i options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            card.center = finishPoint;
            card.transform = CGAffineTransformMakeRotation(0);
            
            if (i>0&&i<CARD_NUM-1) {
                //前面一张卡片
                BQDragCardItem * preCard = [self.disPlayCardArr objectAtIndex:i-1];
                card.transform=CGAffineTransformScale(card.transform, pow(CARD_SCALE, i), pow(CARD_SCALE, i));
                CGRect frame=card.frame;
                frame.origin.y= preCard.frame.origin.y+(preCard.frame.size.height-frame.size.height)+10*pow(0.7,i);
                card.frame=frame;
                
            }else if (i==CARD_NUM-1) {
                
                //最后一张卡片与前一张一样
                BQDragCardItem *preCard=[self.disPlayCardArr objectAtIndex:i-1];
                card.transform=preCard.transform;
                card.frame=preCard.frame;
            }
        } completion:^(BOOL finished) {
            
        }];
        
        card.originalCenter = card.center;
        card.originalTransform=card.transform;

        if (i==CARD_NUM-1) {
            
            self.lastCardCenter=card.center;
            self.lastCardTransform=card.transform;
            
        }
    }
}


#pragma mark - 刷新所有卡片
-(void)refreshAllCards{
    
    self.sourceObjectArr=[@[] mutableCopy];
    
    // 这里要做处理移除动画完成并且请求数据完成 在进行加载动画
    [self requestSourceData:NO];
    [self disMissCardsComplete:^{
        
        [self loadAllCards];
        
    }];
  
}


-(void)disMissCardsComplete:(BQDragCardViewComplete)complete{
    
    for (int i=0; i<self.disPlayCardArr.count ;i++) {
        
        BQDragCardView *card=self.disPlayCardArr[i];
        
        CGPoint finishPoint = CGPointMake(-CARD_WIDTH, 2*PAN_DISTANCE+card.frame.origin.y);
        
        [UIView animateKeyframesWithDuration:0.5 delay:0.06*i options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            card.center = finishPoint;
            card.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
            
        } completion:^(BOOL finished) {
            
            card.transform = CGAffineTransformMakeRotation(ROTATION_ANGLE);
            card.hidden=YES;
            card.center=CGPointMake([[UIScreen mainScreen]bounds].size.width+CARD_WIDTH, self.center.y);
            
            if (i==self.disPlayCardArr.count-1) {
                
                if(complete) complete();
                
            }
        }];
    }


}

#pragma mark - 滑动后续操作
-(void)swipCard:(BQDragCardItem *)card Direction:(BOOL)isRight {
    
    BQDragCardItem * item = [self.disPlayCardArr objectAtIndex:1];
    item.userInteractionEnabled = YES;
    
    if (isRight) {
        
       
    }else{
        
        
    }
    
    [self.disPlayCardArr removeObject:card];
    card.transform = self.lastCardTransform;
    card.center = self.lastCardCenter;
    card.userInteractionEnabled = NO;
    [self insertSubview:card belowSubview:[self.disPlayCardArr lastObject]];
    [self.disPlayCardArr addObject:card];
    
    if ([self.sourceObjectArr firstObject]!=nil) {
        
        //给这一张卡片塞入数据
//        cardView.infoDict=[self.sourceObject firstObject];
//        [self.sourceObjectArr removeObjectAtIndex:0];
//        [cardView layoutSubviews];
//        if (self.sourceObject.count<MIN_INFO_NUM) {
//            [self requestSourceData:NO];
//        }
    }else{
        card.hidden=YES;//如果没有数据则隐藏卡片
    }
    
    for (int i = 0; i<CARD_NUM; i++) {
        
        BQDragCardItem * item = [self.disPlayCardArr objectAtIndex:i];
        item.originalCenter = item.center;
        item.originalTransform = item.transform;
        
    }
   
}

#pragma mark - 滑动中更改其他卡片位置
-(void)moveCardsX:(CGFloat)xDistance Y:(CGFloat)yDistance
{
    CGFloat distance =  sqrt(pow(xDistance,2)+pow(yDistance,2));
    if (fabs(distance) <= PAN_DISTANCE) {
        for (int i = 1; i<CARD_NUM-1; i++) {
            BQDragCardItem * card=self.disPlayCardArr[i];
            BQDragCardItem * preCard=[self.disPlayCardArr objectAtIndex:i-1];
            
            card.transform=CGAffineTransformScale(card.originalTransform, 1+(1/CARD_SCALE-1)*fabs(distance/PAN_DISTANCE)*0.6, 1+(1/CARD_SCALE-1)*fabs(distance/PAN_DISTANCE)*0.6);//0.6为缩减因数，使放大速度始终小于卡片移动速度
            
            CGPoint center= card.center;
            center.y=card.originalCenter.y-(card.originalCenter.y-preCard.originalCenter.y)*fabs(distance/PAN_DISTANCE)*0.6;//此处的0.6同上
            card.center=center;
        }
    }
    if (xDistance > 0) {
        
        //右边
        
    } else {
       
        //左边
        
    }
}

#pragma mark - 滑动终止后复原其他卡片
-(void)moveBackCards{
    
        [UIView animateWithDuration:RESET_ANIMATION_TIME delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            for (int i = 1; i<CARD_NUM-1; i++) {
                BQDragCardItem * card =self.disPlayCardArr[i];
                card.transform=card.originalTransform;
                card.center=card.originalCenter;
            }
        } completion:nil];

}

#pragma mark - 滑动后调整其他卡片位置
-(void)adjustOtherCards{
    

    [UIView animateWithDuration:RESET_ANIMATION_TIME delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        for (int i = 1; i<CARD_NUM-1; i++) {
            BQDragCardItem * card = self.disPlayCardArr[i];
            BQDragCardItem * preCard=[self.disPlayCardArr objectAtIndex:i-1];
            card.transform=preCard.originalTransform;
            card.center=preCard.originalCenter;
        }
        
    } completion:nil];
    
}


@end
