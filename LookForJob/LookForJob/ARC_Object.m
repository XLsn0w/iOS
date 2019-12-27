//
//  ARC_Object.m
//  LookForJob
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 XLsn0w. All rights reserved.
//

#import "ARC_Object.h"
#import "ModelObject.h"

//ARC只能管理Foundation框架的变量，如果程序中把Foundation中的变量强制换成Core Foundation中的变量需要交换管理权；
//
//在非ARC工程中采用ARC去编译某些类：-fobjc-arc。
//
//在ARC下的工程采用非ARC去编译某些类：-fno-fobjc-arc。

//如何声明一个delegate属性，为什么？
//
//声明属性时要，在ARC下使用weak，在MRC下使用assign。比如：
//
//@property (nonatomic, weak) id<HYBTestDelegate> delegate;
//
//在MRC下，使用assign是因为没有weak关键字，只能使用assign来防止循环引用。在ARC下，使用weak来防止循环引用。

@implementation ARC_Object

- (void)test {
    for (int i = 0; i < 10000000; ++i) {
           @autoreleasepool {
            ModelObject *model = [[ModelObject alloc] init];
                  // 临时处理
                  // ...
               } // 出了这里，就会去遍历该自动释放池了
    }
}

@end


autorelease的对象何时被释放
参考答案：

如果了解一点点Run Loop的知道，应该了解到：Run Loop在每个事件循环结束后会去自动释放池将所有自动释放对象的引用计数减一，若引用计数变成了0，则会将对象真正销毁掉，回收内存。

所以，autorelease的对象是在每个事件循环结束后，自动释放池才会对所有自动释放的对象的引用计数减一，若引用计数变成了0，则释放对象，回收内存。因此，若想要早一点释放掉auto release对象，那么我们可以在对象外加一个自动释放池。比如，在循环处理数据时，临时变量要快速释放，就应该采用这种方式：

