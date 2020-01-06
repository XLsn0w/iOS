//
//  HQL8_7ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/24.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL8_7ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 # 在动画过程中取消动画
 
 你可以用 -addAnimation:forKey: 方法中的 key 参数来在添加动画之后检索一个动画，使用如下方法：
 - (CAAnimation *)animationForKey:(NSString *)key;
 但并不支持在动画运行过程中修改动画，所以这个方法主要用来检测动画的属性，或者判断它是否被添加到当前图层中。
 
 为了终止一个指定的动画，你可以用如下方法把它从图层移除掉：
 - (void)removeAnimationForKey:(NSString *)key;
 
 或者移除所有动画：
 - (void)removeAllAnimations;
 
 动画一旦被移除，图层的外观就立刻更新到当前的模型图层的值。
 一般说来，动画在结束之后被自动移除，除非设置 removedOnCompletion 为 NO，如果你设置动画在结束之后不被自动移除，那么当它不需要的时候你要手动移除它；否则它会一直存在于内存中，直到图层被销毁。
 
 
 
 */
