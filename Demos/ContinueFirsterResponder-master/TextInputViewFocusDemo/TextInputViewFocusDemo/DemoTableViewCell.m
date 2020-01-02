//
//  DemoTableViewCell.m
//  TextInputViewFocusDemo
//
//  Created by rztime on 2017/11/10.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "DemoTableViewCell.h"
#import "UIView+RZContinueFirstResponder.h"
#import "TestField.h"

@interface DemoTableViewCell ()

@property (nonatomic, strong) TestField *textField;

@end

@implementation DemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textField = [[TestField alloc]initWithFrame:CGRectMake(20, 10, 300, 30)];
        [self.contentView addSubview:_textField];
    }
    return self;
}

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
        case ItemModelTypeDefault3: {
            _textField.tagIdentity = @"ItemModelTypeDefault3";
            _textField.placeholder = @"ItemModelTypeDefault3";
            break;
        }
        case ItemModelTypeDefault4: {
            _textField.tagIdentity = @"ItemModelTypeDefault4";
            _textField.placeholder = @"ItemModelTypeDefault4";
            break;
        }
        case ItemModelTypeDefault5: {
            _textField.tagIdentity = @"ItemModelTypeDefault5";
            _textField.placeholder = @"ItemModelTypeDefault5";
            break;
        }
        case ItemModelTypeDefault6: {
            _textField.tagIdentity = @"ItemModelTypeDefault6";
            _textField.placeholder = @"ItemModelTypeDefault6";
            break;
        }
        default:
            break;
    }
}

@end
