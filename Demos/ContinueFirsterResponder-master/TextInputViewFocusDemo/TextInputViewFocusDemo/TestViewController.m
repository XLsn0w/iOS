//
//  TestViewController.m
//  TextInputViewFocusDemo
//
//  Created by rztime on 2017/11/13.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "TestViewController.h"
#import "DemoTableViewCell.h"
#import "ItemModel.h"
#import "UIView+KeepFirstResponder.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) ItemModel *model;

@end

@implementation TestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[ItemModel alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一个" style:0 target:self action:@selector(next)];
}

- (void)next {
    static int i = 0;
    if (i == 0) {
        [_model addName];
    }
    if (i == 1) {
        [_model addsex];
    }
    
    if (i == 3) {
        [_model removeName];
    }
    
    if (i == 4) {
        [_model removeSex];
        i = -1;
    }
    i++;
    
    
    // 刷新方法写这里，将保持之前的第一响应的文本框
    [_tableView keepFirstResponder_reloadData:^(TagFirstResponder *nextResponder) {
        [_tableView reloadData];
        // 下边两个方法，二选一
        // 如果对应nextFirstResponderIndex 或者 nextFirstResponderTagIdentity 找不到，则会找刷新前的那个继续作为第一响应
        // 如果刷新前的那个也找不到了，则会按照刷新前的那个的index继续往下找，找不到的时候，以最后一个文本框作为第一响应
//        nextResponder.nextFirstResponderIndex = 3; // 指定刷新后按从上到下（从左到右）依次序排到第n个为第一响应
        nextResponder.nextFirstResponderTagIdentity = @"ItemModelTypeDefault2"; // 指定刷新后此id为第一响应
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.dataSourcce.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DemoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ItemModelType type = [_model.dataSourcce[indexPath.row] integerValue];
    [cell setModelType:type];
    return cell;
}


@end
