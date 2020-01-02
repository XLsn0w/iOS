
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagFirstResponder : NSObject

@property (nonatomic, copy) NSString *nextFirstResponderTagIdentity;// 指定下一个响应的tagIdentity
@property (nonatomic, assign) NSInteger nextFirstResponderIndex;// 指定下一个响应的index  如果设置了nextFirstResponderTagIdentity 则优先设置到nextFirstResponderTagIdentity

@end

NS_ASSUME_NONNULL_END
