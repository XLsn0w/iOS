//
//  FoldingCell.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/29.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 动画类型
typedef NS_ENUM(NSUInteger, FoldAnimationType) {
    FoldAnimationTypeFold, // 折叠动画
    FoldAnimationTypeExpand, // 展开动画
};

typedef void(^animationCompletionHandle)(void);

/// 可旋转视图
@interface RotatedView : UIView

// 翻转时显示的背面视图
@property (nonatomic, strong) RotatedView *backView;

- (void)addBackViewWithHeight:(CGFloat)height andColor:(UIColor *)color;

- (void)foldingAnimationWithTimingFunctionName:(CAMediaTimingFunctionName)name
                                     fromValue:(CGFloat)from
                                       toValue:(CGFloat)to
                                         delay:(NSTimeInterval)delay
                                      duration:(NSTimeInterval)duration
                                        hidden:(BOOL)hidden;

@end

@interface FoldingCell : UITableViewCell

@property (nonatomic, weak) IBOutlet RotatedView *foregroundView;
@property (nonatomic, weak) IBOutlet UIView *containerView;
// 前景视图与顶点的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foregroundTopConstraint;
// 容器视图与顶点点距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewTopConstraint;

- (BOOL)isAnimating;

- (CGFloat)returnSumTime;

- (void)executeAnimationWithSelected:(BOOL)selected
                            animated:(BOOL)animated
                    completionHandle:(animationCompletionHandle)completionHandle;

@end

NS_ASSUME_NONNULL_END
