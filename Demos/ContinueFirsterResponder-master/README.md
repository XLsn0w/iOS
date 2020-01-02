# ContinueFirsterResponder
iOS 界面刷新时 保持UITextField UITextView UISearchBar 响应，保持键盘一直打开，并可在刷新后指定定位到某输入框作为第一响应者


### 使用

```
将

UIView+RZContinueFirstResponder.h
UIView+RZContinueFirstResponder.m

文件放到自己的项目中
```

在需要使用的地方添加

```
#import "UIView+RZContinueFirstResponder.h"

```
* 如果界面刷新时，无新增或删除文本框，则不需要做任何处理，直接使用
```
// 刷新方法写这里，将保持之前的第一响应的文本框
[_tableView rzContinueFirstResponderAndExecuteCode:^(UIViewResponderHelper *nextResponder) {
    // 将刷新界面的方法写到这里，不用担忧这里会有block循环引用的问题
    [_tableView reloadData];
}];
```

* 如果界面刷新时，有新增或删除文本框，如果新增的文本框在最后面，也可以不做任何处理
```
// 刷新方法写这里，将保持之前的第一响应的文本框
[_tableView rzContinueFirstResponderAndExecuteCode:^(UIViewResponderHelper *nextResponder) {
    // 将刷新界面的方法写到这里，不用担忧这里会有block循环引用的问题
    [_tableView reloadData];
}];
```
* 如果界面刷新时，文本框较复杂，有新增或删除文本框，又需要精准的定位还原到刷新前的第一响应者身上，则可设置文本框的tagIdentity。 具体意思可参考DemoTableViewCell中文本框_textField的设置方法

```
// 初始化文本框时

- (void)setModelType:(ItemModelType )type {
    _textField.enabled = YES;
    switch (type) {
    case ItemModelTypeDefault: {
        _textField.tagIdentity = @"ItemModelTypeDefault";
        _textField.placeholder = @"默认";
        break;
    }
    case ItemModelTypeName: {
        _textField.tagIdentity = @"ItemModelTypeName";
        _textField.placeholder = @"ItemModelTypeName";
        break;
    }
    case ItemModelTypeSex: {
        _textField.tagIdentity = @"ItemModelTypeSex";
        _textField.placeholder = @"ItemModelTypeSex";
        break;
    }
    case ItemModelTypeDefault1: {
        _textField.tagIdentity = @"ItemModelTypeDefault1";
        _textField.placeholder = @"ItemModelTypeDefault1";
        _textField.enabled = NO;
        break;
    }
    case ItemModelTypeDefault2: {
        _textField.tagIdentity = @"ItemModelTypeDefault2";
        _textField.placeholder = @"ItemModelTypeDefault2";
        break;
    }
    default:
        break;
    }
}

// 刷新方法写这里，将保持之前的第一响应的文本框
[_tableView rzContinueFirstResponderAndExecuteCode:^(UIViewResponderHelper *nextResponder) {
    // 将刷新界面的方法写到这里，不用担忧这里会有block循环引用的问题
    [_tableView reloadData];
}];
```

* 如果刷新之后，需要将第一响应的光标放到其他指定的文本框中，可以在刷新方法中设置

```
// 刷新方法写这里，将寻找指定的下一个文本框
[_tableView rzContinueFirstResponderAndExecuteCode:^(UIViewResponderHelper *nextResponder) {
    // 将刷新界面的方法写到这里，不用担忧这里会有block循环引用的问题
    [_tableView reloadData];
    // 下边两个方法，二选一
    // 如果对应nextFirstResponderIndex 或者 nextFirstResponderTagIdentity 找不到，则会找刷新前的那个继续作为第一响应
    // 如果刷新前的那个也找不到了，则会按照刷新前的那个的index继续往下找，找不到的时候，以最后一个文本框作为第一响应
    // nextResponder.nextFirstResponderIndex = 3; // 指定刷新后按从上到下（从左到右）依次序排到第n个为第一响应
    nextResponder.nextFirstResponderTagIdentity = @"ItemModelTypeDefault2"; // 指定刷新后此id为第一响应
}];
```

##  如果确定是scrollview 如tableivew或者collectionview刷新，则最好直接使用[tableview rzContinueFirstResponderAndExecuteCode]来刷新，这样获取界面的可响应者时，效率速度更高
