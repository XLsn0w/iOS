//
//  ViewController.m
//  KeyboardDismiss
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 XLsn0w. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end

/*
1、UITableView自带的属性

tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;UIScrollViewKeyboardDismissModeNone,//默认第二种,  为noneUIScrollViewKeyboardDismissModeOnDrag,//键盘会当tableView上下滚动的时候自动收起

第三种,  为UIScrollViewKeyboardDismissModeInteractive, // 设置键盘的消失方式为拖拉并点击页面，iOS7新增特性

2、用的比较多的方法：点击背景View收起键盘或者直接使用也可以（你的View必须是继承于UIControl）

 [self.view endEditing:YES];

3、万能方法：在任何地方都可以使用这种方法来关闭/收起键盘

[[[UIApplication sharedApplication] keyWindow] endEditing:YES];

4、点击Return按扭时收起键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{

    return [textField resignFirstResponder];

}

5､ 直接发送 resignFirstResponder 消息

[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

这种方法调用了私用API,如果上架到AppStore,审核通不过

使用场景：

 

能获取到 UITextField 对象时，最好使用 [obj resignFirstResponder] 方法;
有很多个 UITextField 对象，也可获取到 viewController 的 view 时，可以使用 [[[UIApplication sharedApplication] keyWindow] endEditing:YES] 方法;
如果当前 ViewController比较难获取，可以使用第2种或第4种方法。
6､触摸UITableView收起键盘，一般聊天会涉及到

 

UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:sel

 

f action:@selector(commentTableViewTouchInSide)];


tableViewGesture.numberOfTapsRequired = 1;


tableViewGesture.cancelsTouchesInView = NO;


[commentTableView addGestureRecognizer:tableViewGesture];
  
- (void)commentTableViewTouchInSide{


[messageTextField resignFirstResponder];

 
}

 */
