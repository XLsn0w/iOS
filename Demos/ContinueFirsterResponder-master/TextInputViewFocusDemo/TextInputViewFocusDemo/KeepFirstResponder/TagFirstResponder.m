
#import "TagFirstResponder.h"

@implementation TagFirstResponder

- (instancetype)init {
    if (self = [super init]) {
        _nextFirstResponderTagIdentity = @"";
        _nextFirstResponderIndex = -1;
    }
    return self;
}

@end
