//
//  HQL16_2TableViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/29.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL16_2TableViewController.h"
#import "FoldingCell.h"

static const CGFloat kCloseCellHeight  = 136; // 折叠高度
static const CGFloat kOpenCellHeight = 496;   // 打开高度

static NSString * const cellReuserIdentifier = @"foldingcell";

@interface HQL16_2TableViewController ()

@property (nonatomic, strong) NSMutableArray *heightArray;

@end

@implementation HQL16_2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([FoldingCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:cellReuserIdentifier];
    

    // 初始化存放高度的数组，默认全部闭合
    self.heightArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [self.heightArray addObject:[NSNumber numberWithFloat:kCloseCellHeight]];
    }
}

#pragma mark - UITableViewDataSource

// 一共 10 行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// 每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heightArray[indexPath.row] floatValue];
}

// 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoldingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuserIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[FoldingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuserIdentifier];
    }
    
    if ([self.heightArray[indexPath.row] floatValue] == kCloseCellHeight) {
        // 如果该行是闭合状态
        [cell executeAnimationWithSelected:NO animated:NO completionHandle:nil];
    } else {
        // 如果该行是打开状态
        [cell executeAnimationWithSelected:YES animated:NO completionHandle:nil];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

// 该行被选中时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FoldingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 如果选中的 cell 正在执行动画，则立即返回。
    if ([cell isAnimating]) return;
    
    // duration 表示单次动画的持续时间
    CGFloat duration = 0.0;
    if ([self.heightArray[indexPath.row] floatValue] == kCloseCellHeight) {
        // 折叠 -> 打开：执行展开动画
        [_heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:kOpenCellHeight]];
        duration = 0.3;
        [cell executeAnimationWithSelected:YES animated:YES completionHandle:nil];
    } else {
        // 打开 -> 折叠：执行折叠动画
        duration = [cell returnSumTime];
        [_heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:kCloseCellHeight]];
        [cell executeAnimationWithSelected:NO animated:YES completionHandle:nil];
    }
    
    [UIView animateWithDuration:duration + 0.3 animations:^{
        if (@available(iOS 11.0, *)) {
            [self.tableView performBatchUpdates:nil completion:nil];
        } else {
            // Fallback on earlier versions
            // 参考：https://www.jianshu.com/p/6efc5cf5c569
            // 简而言之，成对使用以下两个方法可以在不重载 cell 的情况下更新 cell 的高度，而且自带动画。
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }
    }];
}



@end
