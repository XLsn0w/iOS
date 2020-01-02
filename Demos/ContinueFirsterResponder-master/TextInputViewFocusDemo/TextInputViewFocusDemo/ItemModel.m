//
//  ItemModel.m
//  TextInputViewFocusDemo
//
//  Created by rztime on 2017/11/10.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "ItemModel.h"

@interface ItemModel ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ItemModel

- (NSArray *)dataSourcce {
    if (!_array) {
        _array = [NSMutableArray new];
        [_array addObject:@(ItemModelTypeDefault)];
        [_array addObject:@(ItemModelTypeDefault1)];
        [_array addObject:@(ItemModelTypeDefault2)];
        [_array addObject:@(ItemModelTypeDefault3)];
        [_array addObject:@(ItemModelTypeDefault4)];
    }
    return _array.copy;
}
- (void)addName {
    [_array insertObject:@(ItemModelTypeName) atIndex:1];
}

- (void)addsex {
    [_array insertObject:@(ItemModelTypeSex) atIndex:2];
}

- (void)removeName {
    [_array removeObject:@(ItemModelTypeName)];
}

- (void)removeSex {
    [_array removeObject:@(ItemModelTypeSex)];
}

@end
