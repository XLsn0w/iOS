//
//  LayerLabel.h
//
//  Created by Nick Lockwood on 19/05/2013.
//  Copyright (c) 2013 Charcoal Design. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用 CATextLayer 作为宿主图层的 UILabel 子类
 */
@interface LayerLabel : UILabel

@end

/*
 
 # UILabel 的替代品
 
 把 CATextLayer 作为宿主图层的另一好处就是视图自动设置了 contentsScale 属性。
 
 */
