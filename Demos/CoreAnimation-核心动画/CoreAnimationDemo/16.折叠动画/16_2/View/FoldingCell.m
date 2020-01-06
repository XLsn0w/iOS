//
//  FoldingCell.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/29.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "FoldingCell.h"

@interface RotatedView () <CAAnimationDelegate>

// 动画执行完成之后是否隐藏整个 RotatedView 视图
@property (nonatomic, assign) BOOL hiddenAfterAnimation;

@end

@implementation RotatedView

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _hiddenAfterAnimation = NO;
}

#pragma mark - Public

- (void)addBackViewWithHeight:(CGFloat)height andColor:(UIColor *)color
{
    // 1.添加旋转时的反面视图
    self.backView = [[RotatedView alloc] initWithFrame:CGRectZero];
    self.backView.backgroundColor = color;
    self.backView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.backView.transform3D = [self transform3d];
    self.backView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.backView];
    
    // 2.设置高度约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.backView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:1.0
                                                                        constant:height];
    [self.backView addConstraint:heightConstraint];
    
    /*
     这里距离顶部距离位置下调 height / 2
     是为了抵消设置了锚点 CGPointMake(0.5, 1) 后图层位置会自动上移的 height / 2。
     */
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.backView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:self.bounds.size.height - height / 2];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.backView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.backView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0];
    [self addConstraints:@[top, leading, trailing]];
}

// 3D 旋转动画
- (void)foldingAnimationWithTimingFunctionName:(CAMediaTimingFunctionName)name
                                     fromValue:(CGFloat)from
                                       toValue:(CGFloat)to
                                         delay:(NSTimeInterval)delay
                                      duration:(NSTimeInterval)duration
                                        hidden:(BOOL)hidden
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:name];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:from];
    rotateAnimation.toValue = [NSNumber numberWithFloat:to];
    rotateAnimation.duration = duration;
    rotateAnimation.delegate = self;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.beginTime = CACurrentMediaTime() + delay;
    [self.layer addAnimation:rotateAnimation forKey:@"rotation.x"];
    
    _hiddenAfterAnimation = hidden;
}

#pragma mark Private

// 为图层添加 3D 透视效果
- (CATransform3D)transform3d {
    // 创建一个新的 3D 单位矩阵变换
    CATransform3D transform3D = CATransform3DIdentity;
    // 添加透视效果
    transform3D.m34 = - 1.0 / 500.0;
    return transform3D;
}

#pragma mark - CAAnimationDelegate

// 动画开始之前调用
- (void)animationDidStart:(CAAnimation *)anim
{
    // 参考：https://www.cnblogs.com/feng9exe/p/10334751.html
    // self.layer.shouldRasterize = YES;
    self.hidden = NO;
}

// 动画完成之后调用
// 注：这里的「动画完成」有两种情况：可能是完整的动画过程执行完成，也可能是动画所依附的视图被从其父视图上移除了。
// 如果是前者的情况，这里的 flag 值为 true，否则为 false。
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.hidden = _hiddenAfterAnimation;
    [self.layer removeAllAnimations];
    
    // self.layer.shouldRasterize = NO;
}

@end



@interface FoldingCell ()

@property (nonatomic, strong) NSMutableArray *rotatedViewsArray;
@property (nonatomic, strong) UIColor *rotatedViewBackColor;
@property (nonatomic, strong) NSLayoutConstraint *containerViewTop;

@end

@implementation FoldingCell

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureDefaultState];
}

- (void)configureDefaultState {
    
    // 1.设置 contaienrView
    // contaienrView 位置上移，与 foregroundView 重叠
    self.containerViewTopConstraint.constant = _foregroundTopConstraint.constant;
    self.containerView.hidden = YES;
    
    // 1.1 设置 contaienrView 的子视图高度
    for (NSLayoutConstraint *constraint in self.containerView.constraints) {
        if ([constraint.identifier isEqualToString:@"yPosition"]) {
            // 设置锚点后位置会下移半个高度（注意，这边的锚点位置在视图上方）
            [constraint.firstItem layer].anchorPoint = CGPointMake(0.5, 0);
            // 位置上调半个图层高度，以抵消高度差
            constraint.constant -= [constraint.firstItem layer].bounds.size.height / 2;
            // 添加 3D 透视效果
            [constraint.firstItem layer].transform = [self transform3d];
        }
    }
    
    // 添加执行动画时的反面视图
    RotatedView *lastView;
    for (UIView *subView in self.containerView.subviews) {
        if (subView.tag > 1 && [subView isKindOfClass:[RotatedView class]]) {
            RotatedView *tempView = (RotatedView *)subView;
            // 「当前子视图的反面」被添加到了上一个子视图上
            [lastView addBackViewWithHeight:tempView.bounds.size.height andColor:self.rotatedViewBackColor];
            lastView = tempView;
        }
    }
        
    // 2.设置 foregroundView
    // 设置锚点后位置会上移半个高度（注意，这边的锚点位置在视图下方）
    self.foregroundView.layer.anchorPoint = CGPointMake(0.5, 1);
    // 位置下调半个图层高度，以抵消高度差
    self.foregroundTopConstraint.constant += self.foregroundView.bounds.size.height / 2;
    // 添加 3D 透视效果
    self.foregroundView.layer.transform = [self transform3d];
    // 将前景视图显示在最前面
    [self.contentView bringSubviewToFront:self.foregroundView];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Custom Accessors

// 旋转视图反面颜色
- (UIColor *)rotatedViewBackColor {
    if (!_rotatedViewBackColor) {
        _rotatedViewBackColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    }
    return _rotatedViewBackColor;
}

// 将所有可旋转视图添加到数组中
- (NSMutableArray *)rotatedViewsArray {
    if (!_rotatedViewsArray) {
        _rotatedViewsArray = [NSMutableArray array];
        
        // 1. 前景视图是 RotatedView 实例
        [_rotatedViewsArray addObject:self.foregroundView];
        
        // 2. 容器视图中的 RotatedView 实例
        /*
         这边有一个 Bug，就是遍历 containerView.subviews 时，子视图的被遍历顺序可能并不是
         按你想象的那样是按照 tag 为 1、2、3、4 的顺序执行的，可能是 1、2、4、3。
         解决方法是在 Interface Builder 中把两个子视图替换一下顺序。
         */
        for (UIView *itemView in self.containerView.subviews) {
            if ([itemView isKindOfClass:[RotatedView class]]) {
                RotatedView *rotatedView = (RotatedView *)itemView;
                [_rotatedViewsArray addObject:rotatedView];

                // 2.1 RotatedView 类型的子视图中的 backView 也被添加进来了
                if (rotatedView.backView) {
                    [_rotatedViewsArray addObject:rotatedView.backView];
                }
            }
        }
    }
    return _rotatedViewsArray;
}

#pragma mark - Public

/**
Open or close cell

- parameter selected: true：展开 cell。false：折叠 cell.
- parameter animated: true：以动画方式执行变化，false：立即变化
- parameter completion: 动画序列结束时执行的 Block 对象。
*/
- (void)executeAnimationWithSelected:(BOOL)selected
                            animated:(BOOL)animated
                    completionHandle:(animationCompletionHandle)completionHandle
{
    if (selected) {
        // cell 被选中，执行展开动画
        self.containerView.hidden = NO;
        for (UIView *subView in self.containerView.subviews) {
            subView.hidden = NO;
        }
        
        if (animated) {
            [self expandingAnimation:completionHandle];
        } else {
            self.foregroundView.hidden = YES;
            for (UIView *subView in self.containerView.subviews) {
                if ([subView isKindOfClass:[RotatedView class]]) {
                    RotatedView *rotateView = (RotatedView *)subView;
                     rotateView.backView.hidden = YES;
                }
            }
        }
    } else {
        // cell 没有被选中，执行折叠动画
        if (animated) {
            [self foldingAnimation:completionHandle];
        } else {
            self.foregroundView.hidden = NO;
            self.containerView.hidden = YES;
        }
    }
}

- (BOOL)isAnimating {
    for (UIView *view in self.rotatedViewsArray) {
        if (view.layer.animationKeys.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (CGFloat)returnSumTime {
    NSMutableArray *tempArray = [self durationSequence];
    CGFloat sumTime = 0.0;
    for (NSNumber *number in tempArray) {
        CGFloat time = [number floatValue];
        sumTime += time;
    }
    return sumTime;
}

#pragma mark - Private

// 折叠动画
- (void)foldingAnimation:(animationCompletionHandle)completionHandle {
    
    NSArray *durationSequenceArray = [self durationSequence];
    durationSequenceArray = [[durationSequenceArray reverseObjectEnumerator] allObjects];
    NSTimeInterval delay = 0;
    CAMediaTimingFunctionName timingFunctionName = kCAMediaTimingFunctionEaseIn; // 动画时间函数：慢慢加速
    // {0,  M_PI_2 } 视图会顺时针从原始位置向屏幕里面转
    CGFloat from = 0.0;
    CGFloat to = M_PI_2;
    BOOL hidden = YES;
    [self configureAnimationItems:FoldAnimationTypeFold];
    for (int index = 0; index < self.rotatedViewsArray.count; index++) {
        float duration = [durationSequenceArray[index] floatValue];
        NSArray *tempArray = [[self.rotatedViewsArray reverseObjectEnumerator] allObjects];
        RotatedView *animatedView = tempArray[index];
        [animatedView foldingAnimationWithTimingFunctionName:timingFunctionName
                                                   fromValue:from
                                                     toValue:to
                                                       delay:delay
                                                    duration:duration
                                                      hidden:hidden];

        from = (from == 0.0 ? -M_PI_2 : 0.0);
        to = (to == 0.0 ? M_PI_2 : 0.0);
        timingFunctionName = (timingFunctionName == kCAMediaTimingFunctionEaseIn ? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseIn);
        hidden = !hidden;
        delay += duration;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 折叠动画完成后，隐藏容器视图
        self.containerView.hidden = YES;
        if (completionHandle) {
            completionHandle();
        }
    });

    RotatedView *firstItemView;
    for (UIView *view in self.containerView.subviews) {
        if (view.tag == 0) {
            firstItemView = (RotatedView *)view;
        }

        float value = (delay - [[durationSequenceArray lastObject] floatValue] * 1.5);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(value * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 执行了 4 次，应该是每个旋转动画执行完成后，都会执行这个 Block
            NSLog(@"closeAnimation");
        });
    }
}

// 展开动画
- (void)expandingAnimation:(animationCompletionHandle)completionHandle {
    
    NSArray *durtions = [self durationSequence];
    NSTimeInterval delay = 0;
    CAMediaTimingFunctionName timingFunctionName = kCAMediaTimingFunctionEaseIn; // 慢慢加速
    // [0 -> -M_PI_2]，foregroundView 向外翻转
    CGFloat from = 0.0;
    CGFloat to = -M_PI_2;
    BOOL hidden = YES;
    [self configureAnimationItems:FoldAnimationTypeExpand];

    for (int index = 0; index < self.rotatedViewsArray.count; index++) {
        float duration = [durtions[index] floatValue];
        RotatedView *animatedView = self.rotatedViewsArray[index];
        [animatedView foldingAnimationWithTimingFunctionName:timingFunctionName
                                                   fromValue:from
                                                     toValue:to
                                                       delay:delay
                                                    duration:duration
                                                      hidden:hidden];
        
        from = (from == 0 ? M_PI_2 : 0.0);
        to = (to == 0.0 ? -M_PI_2 : 0.0);
        timingFunctionName = (timingFunctionName == kCAMediaTimingFunctionEaseIn ? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseIn);
        hidden = !hidden;
        delay += duration;
    }
    
    for (UIView *view in self.containerView.subviews) {
        if (view.tag == 1) {
            // 第一个视图：左上 + 右上 切圆角
            RotatedView *firstItemView = (RotatedView *)view;
            firstItemView.layer.masksToBounds = YES;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:firstItemView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            firstItemView.layer.mask = maskLayer;
        } else if (view.tag == 4) {
            // 最后一个视图：左下 + 右下 切圆角
            RotatedView *lastItemView = (RotatedView *)view;
            lastItemView.layer.masksToBounds = YES;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lastItemView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            lastItemView.layer.mask = maskLayer;
        }
    }

    // 前景动画执行完成后调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([durtions[0] floatValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 只执行一次
        NSLog(@"openAnimation");
    });

    // 所有动画执行完成后调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completionHandle) {
            completionHandle();
        }
    });
}

// 持续时间序列
- (NSMutableArray *)durationSequence
{
    NSMutableArray *durationArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:0.5], nil];
    
    NSMutableArray *durtions = [NSMutableArray array];
    for (int index = 0; index < self.containerView.subviews.count - 1; index++) {
        
        // FIXME: 数组边界溢出
        NSNumber *tempDuration = durationArray[index];
        float temp = [tempDuration floatValue] / 2;
        NSNumber *duration = [NSNumber numberWithFloat:temp];

        [durtions addObject:duration];
        [durtions addObject:duration];
    }
    return durtions;
}

- (void)configureAnimationItems:(FoldAnimationType)animationType
{
    switch (animationType) {
        case FoldAnimationTypeFold: {
            // 折叠动画，先显示可旋转视图，隐藏背景视图
            for (UIView *view in self.containerView.subviews) {
                if ([view isKindOfClass:[RotatedView class]]) {
                    RotatedView *rotatedView = (RotatedView *)view;
                    rotatedView.hidden = NO;
                    rotatedView.backView.hidden = YES;
                }
            }
            break;
        }
        case FoldAnimationTypeExpand: {
            // 展开动画，先隐藏容器视图中的可旋转视图
            for (UIView *view in self.containerView.subviews) {
                if ([view isKindOfClass:[RotatedView class]]) {
                    view.hidden = YES;
                }
            }
            break;
        }
    }
}



//3d偏移属性设置
- (CATransform3D)transform3d
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 500.0;
    return transform;
}

@end
