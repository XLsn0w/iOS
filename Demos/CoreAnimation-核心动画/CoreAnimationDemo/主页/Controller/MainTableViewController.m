//
//  MainTableViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/18.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "MainTableViewController.h"

// Frameworks
#import <YYKit/NSObject+YYModel.h>

// Controller
#import "HQL1ViewController.h"

#import "HQL2_1ViewController.h"
#import "HQL2_2ViewController.h"
#import "HQL2_3ViewController.h"
#import "HQL2_4ViewController.h"
#import "HQL2_5ViewController.h"

#import "HQL3_1ViewController.h"
#import "HQL3_2ViewController.h"
#import "HQL3_3ViewController.h"
#import "HQL3_4ViewController.h"

#import "HQL4_1ViewController.h"
#import "HQL4_2ViewController.h"
#import "HQL4_3ViewController.h"
#import "HQL4_4ViewController.h"
#import "HQL4_5ViewController.h"
#import "HQL4_6ViewController.h"
#import "HQL4_7ViewController.h"

#import "HQL5_1ViewController.h"
#import "HQL5_2ViewController.h"
#import "HQL5_3ViewController.h"
#import "HQL5_4ViewController.h"
#import "HQL5_5ViewController.h"
#import "HQL5_6ViewController.h"
#import "HQL5_7ViewController.h"

#import "HQL6_1ViewController.h"
#import "HQL6_2ViewController.h"
#import "HQL6_3ViewController.h"
#import "HQL6_4ViewController.h"
#import "HQL6_5ViewController.h"
#import "HQL6_6ViewController.h"
#import "HQL6_7ViewController.h"
#import "HQL6_8ViewController.h"
#import "HQL6_9ViewController.h"
#import "HQL6_10ViewController.h"
#import "HQL6_11ViewController.h"

#import "HQL7_1ViewController.h"
#import "HQL7_2ViewController.h"
#import "HQL7_3ViewController.h"
#import "HQL7_4ViewController.h"

#import "HQL8_1ViewController.h"
#import "HQL8_2ViewController.h"
#import "HQL8_3ViewController.h"
#import "HQL8_4ViewController.h"
#import "HQL8_5ViewController.h"
#import "HQL8_6ViewController.h"
#import "HQL8_7ViewController.h"

#import "HQL9_1ViewController.h"
#import "HQL9_2ViewController.h"
#import "HQL9_3ViewController.h"
#import "HQL9_4ViewController.h"

#import "HQL10_1ViewController.h"
#import "HQL10_2ViewController.h"
#import "HQL10_3ViewController.h"
#import "HQL10_4ViewController.h"
#import "HQL10_5ViewController.h"
#import "HQL10_6ViewController.h"
#import "HQL10_7ViewController.h"

#import "HQL11_1ViewController.h"
#import "HQL11_2ViewController.h"
#import "HQL11_3ViewController.h"

#import "HQL12_1ViewController.h"

#import "HQL13_1ViewController.h"
#import "HQL13_2ViewController.h"
#import "HQL13_3ViewController.h"
#import "HQL13_4ViewController.h"

#import "HQL14_1ViewController.h"
#import "HQL14_2ViewController.h"
#import "HQL14_3ViewController.h"
#import "HQL14_4ViewController.h"
#import "HQL14_5ViewController.h"
#import "HQL14_6ViewController.h"
#import "HQL14_7ViewController.h"
#import "HQL14_8ViewController.h"

#import "HQL15_1ViewController.h"
#import "HQL15_2ViewController.h"
#import "HQL15_3ViewController.h"
#import "HQL15_4ViewController.h"
#import "HQL15_5ViewController.h"

#import "HQL16_1ViewController.h"
#import "HQL16_2TableViewController.h"
#import "HQL16_3ViewController.h"

// View
#import "UITableViewCell+ConfigureModel.h"

// Model
#import "HQLTableViewCellGroupedModel.h"
#import "HQLTableViewCellStyleDefaultModel.h"

// Delegate
#import "HQLGroupedArrayDataSource.h"

// cell 重用标识符
static NSString * const cellReusreIdentifier = @"UITableViewCellStyleDefault";


@interface MainTableViewController ()

@property (nonatomic, strong) NSArray *groupedModelsArray;
@property (nonatomic, strong) HQLGroupedArrayDataSource *arrayDataSource;

@end

@implementation MainTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Core Animation 示例";
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 让页面自动滑动到本次要测试的 cell 分类上
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:15] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - Custom Accessors

// 从 mainTableViewTitleModel.plist 文件中读取数据源加载到 NSArray 类型的数组中
- (NSArray *)groupedModelsArray {
    if (!_groupedModelsArray) {
        // mainTableViewTitleModel.plist 文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"mainTableViewTitleModel" ofType:@"plist"];
        // 读取 mainTableViewTitleModel.plist 文件，并存放进 jsonArray 数组
        NSArray *jsonArray = [NSArray arrayWithContentsOfFile:path];
        // 将 jsonArray 数组中的 JSON 数据转换成 HQLTableViewCellGroupedModel 模型
        _groupedModelsArray = [NSArray modelArrayWithClass:[HQLTableViewCellGroupedModel class]
                                                      json:jsonArray];
    }
    return _groupedModelsArray;
}

#pragma mark - Private

- (void)setupTableView {
    // 配置 tableView 数据源
    HQLTableViewCellConfigureBlock configureBlock = ^(UITableViewCell *cell, HQLTableViewCellStyleDefaultModel *model) {
        [cell hql_configureForKeyValueModel:model];
    };
    self.arrayDataSource = [[HQLGroupedArrayDataSource alloc] initWithGroupsArray:self.groupedModelsArray cellReuserIdentifier:cellReusreIdentifier configureBlock:configureBlock];
    self.tableView.dataSource = self.arrayDataSource;
        
    // 隐藏 tableView 底部空白部分线条
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section = %ld, row = %ld",indexPath.section,indexPath.row);
    
    // 1.图层树
    if (indexPath.section == 0 && indexPath.row == 0) {
        HQL1ViewController *controller = [[HQL1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 2.寄宿图
    if (indexPath.section == 1 && indexPath.row == 0) {
        HQL2_1ViewController *controller = [[HQL2_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        HQL2_2ViewController *controller = [[HQL2_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        HQL2_3ViewController *controller = [[HQL2_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {
        HQL2_4ViewController *controller = [[HQL2_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 4) {
        HQL2_5ViewController *controller = [[HQL2_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 3.图层几何学
    if (indexPath.section == 2 && indexPath.row == 0) {
        HQL3_1ViewController *controller = [[HQL3_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        HQL3_2ViewController *controller = [[HQL3_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 2) {
        HQL3_3ViewController *controller = [[HQL3_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 3) {
        HQL3_4ViewController *controller = [[HQL3_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 4.视觉效果
    if (indexPath.section == 3 && indexPath.row == 0) {
        HQL4_1ViewController *controller = [[HQL4_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 1) {
        HQL4_2ViewController *controller = [[HQL4_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 2) {
        HQL4_3ViewController *controller = [[HQL4_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 3) {
        HQL4_4ViewController *controller = [[HQL4_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 4) {
        HQL4_5ViewController *controller = [[HQL4_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 5) {
        HQL4_6ViewController *controller = [[HQL4_6ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 6) {
        HQL4_7ViewController *controller = [[HQL4_7ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 5.变换
    if (indexPath.section == 4 && indexPath.row == 0) {
        HQL5_1ViewController *controller = [[HQL5_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 1) {
        HQL5_2ViewController *controller = [[HQL5_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 2) {
        HQL5_3ViewController *controller = [[HQL5_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 3) {
        HQL5_4ViewController *controller = [[HQL5_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 4) {
        HQL5_5ViewController *controller = [[HQL5_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 5) {
        HQL5_6ViewController *controller = [[HQL5_6ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 6) {
        HQL5_7ViewController *controller = [[HQL5_7ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }

    
    // 6.专用图层
    if (indexPath.section == 5 && indexPath.row == 0) {
        HQL6_1ViewController *controller = [[HQL6_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 1) {
        HQL6_2ViewController *controller = [[HQL6_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 2) {
        HQL6_3ViewController *controller = [[HQL6_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 3) {
        HQL6_4ViewController *controller = [[HQL6_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 4) {
        HQL6_5ViewController *controller = [[HQL6_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 5) {
        HQL6_6ViewController *controller = [[HQL6_6ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 6) {
        HQL6_7ViewController *controller = [[HQL6_7ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 7) {
        HQL6_8ViewController *controller = [[HQL6_8ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 8) {
        HQL6_9ViewController *controller = [[HQL6_9ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 9) {
        HQL6_10ViewController *controller = [[HQL6_10ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 5 && indexPath.row == 10) {
        HQL6_11ViewController *controller = [[HQL6_11ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 7.隐式动画
    if (indexPath.section == 6 && indexPath.row == 0) {
        HQL7_1ViewController *controller = [[HQL7_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 6 && indexPath.row == 1) {
        HQL7_2ViewController *controller = [[HQL7_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 6 && indexPath.row == 2) {
        HQL7_3ViewController *controller = [[HQL7_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 6 && indexPath.row == 3) {
        HQL7_4ViewController *controller = [[HQL7_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 8.显式动画
    if (indexPath.section == 7 && indexPath.row == 0) {
        HQL8_1ViewController *controller = [[HQL8_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 7 && indexPath.row == 1) {
        HQL8_2ViewController *controller = [[HQL8_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 7 && indexPath.row == 2) {
        HQL8_3ViewController *controller = [[HQL8_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 7 && indexPath.row == 3) {
        HQL8_4ViewController *controller = [[HQL8_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 7 && indexPath.row == 4) {
        HQL8_5ViewController *controller = [[HQL8_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 7 && indexPath.row == 5) {
        HQL8_6ViewController *controller = [[HQL8_6ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 7 && indexPath.row == 6) {
        HQL8_7ViewController *controller = [[HQL8_7ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 9.图层时间
    if (indexPath.section == 8 && indexPath.row == 0) {
        HQL9_1ViewController *controller = [[HQL9_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 8 && indexPath.row == 1) {
        HQL9_2ViewController *controller = [[HQL9_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 8 && indexPath.row == 2) {
        HQL9_3ViewController *controller = [[HQL9_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 8 && indexPath.row == 3) {
        HQL9_4ViewController *controller = [[HQL9_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 10.缓冲
    if (indexPath.section == 9 && indexPath.row == 0) {
        HQL10_1ViewController *controller = [[HQL10_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 9 && indexPath.row == 1) {
        HQL10_2ViewController *controller = [[HQL10_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 9 && indexPath.row == 2) {
        HQL10_3ViewController *controller = [[HQL10_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 9 && indexPath.row == 3) {
        HQL10_4ViewController *controller = [[HQL10_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 9 && indexPath.row == 4) {
        HQL10_5ViewController *controller = [[HQL10_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 9 && indexPath.row == 5) {
        HQL10_6ViewController *controller = [[HQL10_6ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 9 && indexPath.row == 6) {
        HQL10_7ViewController *controller = [[HQL10_7ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 11.基于定时器的动画
    if (indexPath.section == 10 && indexPath.row == 0) {
        HQL11_1ViewController *controller = [[HQL11_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 10 && indexPath.row == 1) {
        HQL11_2ViewController *controller = [[HQL11_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 10 && indexPath.row == 2) {
        HQL11_3ViewController *controller = [[HQL11_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }

    // 12.性能调优
    if (indexPath.section == 11 && indexPath.row == 0) {
        HQL12_1ViewController *controller = [[HQL12_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 13.高效绘图
    if (indexPath.section == 12 && indexPath.row == 0) {
        HQL13_1ViewController *controller = [[HQL13_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 12 && indexPath.row == 1) {
        HQL13_2ViewController *controller = [[HQL13_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 12 && indexPath.row == 2) {
        HQL13_3ViewController *controller = [[HQL13_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 12 && indexPath.row == 3) {
        HQL13_4ViewController *controller = [[HQL13_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 14.图像IO
    if (indexPath.section == 13 && indexPath.row == 0) {
        HQL14_1ViewController *controller = [[HQL14_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 1) {
        HQL14_2ViewController *controller = [[HQL14_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 2) {
        HQL14_3ViewController *controller = [[HQL14_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 3) {
        HQL14_4ViewController *controller = [[HQL14_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 4) {
        HQL14_5ViewController *controller = [[HQL14_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 5) {
        HQL14_6ViewController *controller = [[HQL14_6ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 6) {
        HQL14_7ViewController *controller = [[HQL14_7ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 13 && indexPath.row == 7) {
        HQL14_8ViewController *controller = [[HQL14_8ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 15.图层性能
    if (indexPath.section == 14 && indexPath.row == 0) {
        HQL15_1ViewController *controller = [[HQL15_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 14 && indexPath.row == 1) {
        HQL15_2ViewController *controller = [[HQL15_2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 14 && indexPath.row == 2) {
        HQL15_3ViewController *controller = [[HQL15_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 14 && indexPath.row == 3) {
        HQL15_4ViewController *controller = [[HQL15_4ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 14 && indexPath.row == 4) {
        HQL15_5ViewController *controller = [[HQL15_5ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // 16.折叠动画
    if (indexPath.section == 15 && indexPath.row == 0) {
        HQL16_1ViewController *controller = [[HQL16_1ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 15 && indexPath.row == 1) {
        HQL16_2TableViewController *controller = [[HQL16_2TableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.section == 15 && indexPath.row == 2) {
        HQL16_3ViewController *controller = [[HQL16_3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
