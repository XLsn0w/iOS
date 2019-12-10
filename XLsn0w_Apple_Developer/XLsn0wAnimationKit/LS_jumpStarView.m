//
//  LS_jumpStarView.m
//  LSLearnAni06
//
//  Created by xiaoT on 16/4/4.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import "LS_jumpStarView.h"

#define jumpDuration 0.125
#define downDuration 0.215

@interface LS_jumpStarView()

@property (nonatomic, strong) UIImageView *starView;

@property (nonatomic, strong) UIImageView *shadowView;

@end

@implementation LS_jumpStarView{
    BOOL animating;
}

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.bounds = CGRectMake(0, 0, 19, 19);
    if (self.starView == nil) {
        self.starView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - (self.bounds.size.width - 6) / 2, 0, self.bounds.size.width - 6, self.bounds.size.width - 6)];
//        NSLog(@"self.bounds.size.width = %f",self.bounds.size.width);
        self.starView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.starView];
    }
    if (self.shadowView == nil) {
        self.shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 10 / 2, self.bounds.size.height - 3, 10, 3)];
        self.shadowView.alpha = 0.4;
        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
        [self addSubview:self.shadowView];
    }
}

-(void)setState:(STATE)state
{
    _state = state;
    self.starView.image = _state == Mark? _markImage : _non_markImage;
}

-(void)animation
{
    if (animating == YES) {
        return;
    }
    animating = YES;
    
    CABasicAnimation *transformAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAni.fromValue = @(0);
    transformAni.toValue = @(M_PI_2);
    transformAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *positionAni = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAni.fromValue = @(self.starView.center.y);
    positionAni.toValue = @(self.starView.center.y - 14);
    positionAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[transformAni, positionAni];
    animGroup.duration = jumpDuration;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.delegate = self;
    
    [self.starView.layer addAnimation:animGroup forKey:@"jumpUp"];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.starView.layer animationForKey:@"jumpUp"]) {
        self.state = self.state == Mark ? NONMark : Mark;
        
        CABasicAnimation *transformAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        transformAni.fromValue = @(M_PI_2);
        transformAni.toValue = @(M_PI);
        transformAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *positionAni = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAni.fromValue = @(self.starView.center.y - 14);
        positionAni.toValue = @(self.starView.center.y);
        positionAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.animations = @[transformAni, positionAni];
        animGroup.duration = downDuration;
        animGroup.removedOnCompletion = NO;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.delegate = self;
        
        [self.starView.layer addAnimation:animGroup forKey:@"jumpDown"];
    }  else if (anim == [self.starView.layer animationForKey:@"jumpDown"]) {
        [self.starView.layer removeAllAnimations];
        animating = NO;
    }
}

-(void)animationDidStart:(CAAnimation *)anim
{
    if (anim == [self.starView.layer animationForKey:@"jumpUp"]) {
        [UIView animateWithDuration:jumpDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.shadowView.alpha = 0.2;
            self.shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width * 1.6, _shadowView.bounds.size.height);
        } completion:^(BOOL finished) {
            
        }];
    } else if (anim == [self.starView.layer animationForKey:@"jumpDown"]) {
        [UIView animateWithDuration:jumpDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.shadowView.alpha = 0.4;
            self.shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width / 1.6, _shadowView.bounds.size.height);
        } completion:^(BOOL finished) {
            
        }];

    }
}
@end
