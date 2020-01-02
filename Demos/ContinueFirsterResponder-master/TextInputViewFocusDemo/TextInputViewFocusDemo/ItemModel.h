//
//  ItemModel.h
//  TextInputViewFocusDemo
//
//  Created by rztime on 2017/11/10.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ItemModelType) {
    ItemModelTypeDefault = 0,
    ItemModelTypeName = 1,
    ItemModelTypeSex = 2,
    ItemModelTypeDefault1 = 3,
    ItemModelTypeDefault2 = 4,
    ItemModelTypeDefault3 = 5,
    ItemModelTypeDefault4 = 6,
    ItemModelTypeDefault5 = 7,
    ItemModelTypeDefault6 = 8,
};

@interface ItemModel : NSObject

- (NSArray *)dataSourcce;

- (void)addName;

- (void)addsex;

- (void)removeName;

- (void)removeSex;

@end
