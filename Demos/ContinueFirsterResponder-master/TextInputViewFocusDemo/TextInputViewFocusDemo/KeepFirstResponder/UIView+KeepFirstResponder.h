
#import <UIKit/UIKit.h>

@class TagFirstResponder;
NS_ASSUME_NONNULL_BEGIN

#pragma mark - 让UIView中的第一响应者在刷新界面过后依然保持第一响应
@interface UIView (KeepFirstResponder)

/**
 扩展的身份标志，唯一
 如果需要精准的在刷新界面之后，还原到之前的第一响应，或者指定下一个响应，则需要设置此id
 如果未设置，则默认按照刷新前在view中的排位index，刷新之后依然按照此index还原第一响应
 如果新增了或者删除了，要精确还原到原第一响应，则需要设置此id，除非是加在当前第一响应者的下边
 */
@property (nonatomic, copy) NSString *tagIdentity;

/**
 刷新界面的扩展方法 将刷新界面的code写在这个code的block中，
 
 放心使用，没有循环引用的问题
 
 如果确定是scrollview 如tableivew或者collectionview，则最好直接使用[tableview rzContinueFirstResponderAndExecuteCode]来刷新，这样获取界面的可响应者时，效率更高
 @param reloadDataAction nextResponder指定下一个需要响应的方法
 */
- (void)keepFirstResponder_reloadData:(void (^)(TagFirstResponder *nextResponder))reloadDataAction;

@end

NS_ASSUME_NONNULL_END
