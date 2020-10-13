//
//  Base.swift
//  LookForJob
//
//  Created by mac on 2020/1/2.
//  Copyright © 2020 XLsn0w. All rights reserved.
//

import UIKit

/*
 一、UI视图

 其中包括事件传递、视图响应、UI布局、绘制、Tableview重用机制的理解等基本技术点，也包括如离屏渲染、流式页面的性能优化、异步绘制、UI渲染机制等偏底层技术的考察。

 二、Objective-C语言

 其中包括如KVO、KVC、分类、扩展、关联对象等系统实现原理和机制，以及NSNotification、属性关键字等相关技术点的考察。

 三、Runtime

 可以说是中级以及以上工程师的必备技术要求，面试官往往会考察大家对对象、类对象、原类对象的理解、消息传递机制、消息转发流程、Method-Swizzling、ISA-swizzling、动态方法解析、动态添加方法等。

 四、内存管理

 可以说是高阶考点，也是难点，中高级及以上无法回避的问题。考察内容基本包括：weak自动置nil、ARC、MRC、自动释放池的实现原理、循环引用、引用计数管理思想等。

 五、Block

 iOS当中非常重要的OC语言特性，自然也是面试常考点。其中包括截获变量特性、__Block关键字、Block的本质、Block的内存管理和循环引用等。

 六、多线程

 面试高级考点。iOS常见的多线程技术NSOperation&NSOperationQueue 、NSThread、以及快用烂了的GCD；那么面试过程当中，往往会结合实际代码考察同学们对多线程技术的掌握深度，包括对于常见锁的考察，如NSLock、递归锁、自旋锁、条件锁等等。

 七、RunLoop

 相信很多同学知道RunLoop可以有事做事，没事休息？面试当中的考察可能要更深入些，RunLoop为什么会有事做事没事休息，系统是怎样实现的。哈哈，是不是有难度了，再比如怎样实现一个常驻线程、RunLoop和线程的关系是怎样的等等。

 八、网络

 其中包括HTTP相关的中间人攻击、HTTPS的连接建立流程、对称加密、非对称加密、DNS劫持、TCP的滑动窗口协议、可靠传输是怎样保证的，以及TCP的慢启动特点，Session/Cookie的区别等等，这些都是面试中高级岗位必考问题。

 九、设计模式

 其中包括常见的软件设计原则，责任链、适配器、桥接、命令、单例、策略模式等等，不要告诉我你只是看了几本书，面试官会让你结合实际业务场景，现场考察你对设计模式的运用和理解的。

 十、架构/框架

 其中包括常见的如怎样设计图片缓存框架、网络框架，客户端的整体架构怎样实现，常见的解耦方式有哪些，多数同学都知道OPENURL是一种解耦方案，那依赖注入这种方式可能iOS的同学会感到陌生，这也是面试官期许的答案。

 十一、算法

 其中包括BAT、TMD经常考察的有序数组归并、链表反转、字符串反转、大数相加算法思想等等，这部分变化就很多了。

 十二、第三方

 常见的AFNetworking、SDWebImageView、Reactive Cocoa、React Native等

 大厂考察的深度也是令人眼前一亮的，下面列举几个高阶难点问题：

 1. UI视图的事件传递机制是如何实现的？

 2. UI绘制原理是怎样的？

 3. 请利用TableView的重用机制实现一个字母索引条。

 4. 什么是离屏渲染？

 5. 什么是ARC? （可能有很多同学还不清楚ARC是编译器和Runtime的协作结果）

 6. AutoReleasePool的实现机制。（总结一句话：是以栈为结点构成的双向链表结构。）

 7. 循环引用相关的考察，NSTimer如果重复调用怎样解除循环引用？

 8. __block关键字是否可以解决循环引用？

 9. Block的本质是什么?

 10. Block的截获变量的特性应该怎样解释，Block是怎样产生循环引用的？

 11. 怎样利用iOS的多线程技术对共享变量实现多读单写操作呢？

 12. 怎样理解自旋锁？ 递归锁应该怎样使用？

 13. 常见的线程同步问题该怎样解决？

 14. 怎样解决DNS劫持？

 15. TCP的慢启动特点是怎样的。

 16. 你对HTTPS是怎样理解的？

 17.给你一个实际场景，让大家现场提出利用哪个设计模式解决实际问题。

 18. 怎样设计一个时长统计框架？

 19.怎样设计一个图片缓存框架？

 20.客户端的整体架构实现是怎样的，解耦方式都有哪些？

 21.UIView和CALayer之间的关系是怎样的？请从设计原则的角度回答系统为何这样设计？

 22.UI卡顿、掉帧的原理是怎样的？

 23.请解释一下你对isa指针的理解。

 24.你是怎样理解引用计数机制的？（很多人会说什么retain\release\dealloc，完全没有Get到面试官的考察意图）


 */



/*
 
 app 与人进行交互,依赖各种事件

 用户点击界面按钮,需要触发一个按钮点击事件,并进行相应的处理,以给用户一个响应.

 这些事件就是在 UIResponder 类中定义的
 
 一个UIResponder类为那些需要响应并处理事件的对象定义了一组接口。
 这些事件主要分为两类：触摸事件(touch events)和运动事件(motion events)。
 UIResponder类为每两类事件都定义了一组接口，这个我们将在下面详细描述。

 在UIKit中，UIApplication、UIView、UIViewController这几个类都是直接继承自UIResponder类。另外SpriteKit中的SKNode也是继承自UIResponder类。因此UIKit中的视图、控件、视图控制器，以及我们自定义的视图及视图控制器都有响应事件的能力。这些对象通常被称为响应对象，或者是响应者(以下我们统一使用响应者)。

 本文将详细介绍一个UIResponder类提供的基本功能。

 这里需要了解 响应链以及事件传递知识点 , 查阅其他文章...

 管理响应链
 UIResponder提供了几个方法来管理响应链，包括让响应对象成为第一响应者、放弃第一响应者、检测是否是第一响应者以及传递事件到下一响应者的方法，我们分别来介绍一下。

 上面提到在响应链中负责传递事件的方法是nextResponder，其声明如下：
 - (UIResponder *)nextResponder
 UIResponder类并不自动保存或设置下一个响应者，该方法的默认实现是返回nil。
 子类的实现必须重写这个方法来设置下一响应者。UIView的实现是返回管理它的UIViewController对象(如果它有)或者其父视图。而UIViewController的实现是返回它的视图的父视图；UIWindow的实现是返回app对象；而UIApplication的实现是返回nil。所以，响应链是在构建视图层次结构时生成的。
 一个响应对象可以成为第一响应者，也可以放弃第一响应者。为此，UIResponder提供了一系列方法，我们分别来介绍一下。
 如果想判定一个响应对象是否是第一响应者，则可以使用以下方法：
 - (BOOL)isFirstResponder
 如果我们希望将一个响应对象作为第一响应者，则可以使用以下方法：
 - (BOOL)becomeFirstResponder
 如果对象成为第一响应者，则返回YES；否则返回NO。默认实现是返回YES。子类可以重写这个方法来更新状态，或者来执行一些其它的行为。
 一个响应对象只有在当前响应者能放弃第一响应者状态(canResignFirstResponder)且自身能成为第一响应者(canBecomeFirstResponder)时才会成为第一响应者。
 这个方法相信大家用得比较多，特别是在希望UITextField获取焦点时。另外需要注意的是只有当视图是视图层次结构的一部分时才调用这个方法。如果视图的window属性不为空时，视图才在一个视图层次结构中；如果该属性为nil，则视图不在任何层次结构中。
 上面提到一个响应对象成为第一响应者的一个前提是它可以成为第一响应者，我们可以使用canBecomeFirstResponder方法来检测，
 - (BOOL)canBecomeFirstResponder
 需要注意的是我们不能向一个不在视图层次结构中的视图发送这个消息，其结果是未定义的。
 与上面两个方法相对应的是响应者放弃第一响应者的方法，其定义如下：
 - (BOOL)resignFirstResponder- (BOOL)canResignFirstResponder
 resignFirstResponder默认也是返回YES。需要注意的是，如果子类要重写这个方法，则在我们的代码中必须调用super的实现。
 canResignFirstResponder默认也是返回YES。不过有些情况下可能需要返回NO，如一个输入框在输入过程中可能需要让这个方法返回NO，以确保在编辑过程中能始终保证是第一响应者。

 管理输入视图
 所谓的输入视图，是指当对象为第一响应者时，显示另外一个视图用来处理当前对象的信息输入，如UITextView和UITextField两个对象，在其成为第一响应者是，会显示一个系统键盘，用来输入信息。这个系统键盘就是输入视图。输入视图有两种，一个是inputView，另一个是inputAccessoryView。这两者如图3所示：

 与inputView相关的属性有如下两个，
 @property(nonatomic, readonly, retain) UIView *inputView
 @property(nonatomic, readonly, retain) UIInputViewController *inputViewController
 这两个属性提供一个视图(或视图控制器)用于替代为UITextField和UITextView弹出的系统键盘。我们可以在子类中将这两个属性重新定义为读写属性来设置这个属性。如果我们需要自己写一个键盘的，如为输入框定义一个用于输入身份证的键盘(只包含0-9和X)，则可以使用这两个属性来获取这个键盘。
 与inputView类似，inputAccessoryView也有两个相关的属性：
 @property(nonatomic, readonly, retain) UIView *inputAccessoryView
 @property(nonatomic, readonly, retain) UIInputViewController *inputAccessoryViewController
 设置方法与前面相同，都是在子类中重新定义为可读写属性，以设置这个属性。
 另外，UIResponder还提供了以下方法，在对象是第一响应者时更新输入和访问视图，
 - (void)reloadInputViews
 调用这个方法时，视图会立即被替换，即不会有动画之类的过渡。如果当前对象不是第一响应者，则该方法是无效的。

 响应触摸事件
 UIResponder提供了如下四个大家都非常熟悉的方法来响应触摸事件：

 // 当一个或多个手指触摸到一个视图或窗口
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 // 当与事件相关的一个或多个手指在视图或窗口上移动时
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
 // 当一个或多个手指从视图或窗口上抬起时
 - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 // 当一个系统事件取消一个触摸事件时
 - (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
 这四个方法默认都是什么都不做。不过，UIKit中UIResponder的子类，尤其是UIView，这几个方法的实现都会把消息传递到响应链上。因此，为了不阻断响应链，我们的子类在重写时需要调用父类的相应方法；而不要将消息直接发送给下一响应者。
 默认情况下，多点触摸是被禁用的。为了接受多点触摸事件，我们需要设置响应视图的multipleTouchEnabled属性为YES。

 响应移动事件
 与触摸事件类似，UIResponder也提供了几个方法来响应移动事件：

 // 移动事件开始
 - (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
 // 移动事件结束
 - (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
 // 取消移动事件
 - (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
 与触摸事件不同的是，运动事件只有开始与结束操作；它不会报告类似于晃动这样的事件。这几个方法的默认操作也是什么都不做。不过，UIKit中UIResponder的子类，尤其是UIView，这几个方法的实现都会把消息传递到响应链上。

 响应远程控制事件
 远程控制事件来源于一些外部的配件，如耳机等。用户可以通过耳机来控制视频或音频的播放。接收响应者对象需要检查事件的子类型来确定命令(如播放，子类型为UIEventSubtypeRemoteControlPlay)，然后进行相应处理。
 为了响应远程控制事件，UIResponder提供了以下方法，
 - (void)remoteControlReceivedWithEvent:(UIEvent *)event
 我们可以在子类中实现该方法，来处理远程控制事件。不过，为了允许分发远程控制事件，我们必须调用UIApplication的beginReceivingRemoteControlEvents方法；而如果要关闭远程控制事件的分发，则调用endReceivingRemoteControlEvents方法。
 获取Undo管理器
 默认情况下，程序的每一个window都有一个undo管理器，它是一个用于管理undo和redo操作的共享对象。然而，响应链上的任何对象的类都可以有自定义undo管理器。例如，UITextField的实例的自定义管理器在文件输入框放弃第一响应者状态时会被清理掉。当需要一个undo管理器时，请求会沿着响应链传递，然后UIWindow对象会返回一个可用的实例。
 UIResponder提供了一个只读方法来获取响应链中共享的undo管理器，
 @property(nonatomic, readonly) NSUndoManager *undoManager
 我们可以在自己的视图控制器中添加undo管理器来执行其对应的视图的undo和redo操作。

 验证命令
 在我们的应用中，经常会处理各种菜单命令，如文本输入框的”复制”、”粘贴”等。UIResponder为此提供了两个方法来支持此类操作。首先使用以下方法可以启动或禁用指定的命令：
 - (BOOL)canPerformAction:(SEL)action withSender:(id)sender
 该方法默认返回YES，我们的类可以通过某种途径处理这个命令，包括类本身或者其下一个响应者。子类可以重写这个方法来开启菜单命令。例如，如果我们希望菜单支持”Copy”而不支持”Paser”，则在我们的子类中实现该方法。需要注意的是，即使在子类中禁用某个命令，在响应链上的其它响应者也可能会处理这些命令。
 另外，我们可以使用以下方法来获取可以响应某一行为的接收者：
 - (id)targetForAction:(SEL)action withSender:(id)sender
 在对象需要调用一个action操作时调用该方法。默认的实现是调用canPerformAction:withSender:方法来确定对象是否可以调用action操作。如果可以，则返回对象本身，否则将请求传递到响应链上。如果我们想要重写目标的选择方式，则应该重写这个方法。下面这段代码演示了一个文本输入域禁用拷贝/粘贴操作：

 - (id)targetForAction:(SEL)action withSender:(id)sender
 {   UIMenuController *menuController = [UIMenuController sharedMenuController];
     if (action == @selector(selectAll:) || action == @selector(paste:) ||action == @selector(copy:) || action==@selector(cut:))
    {
           if (menuController)
                 {
                       [UIMenuController sharedMenuController].menuVisible = NO;
                 }
          return nil;
    }
     return [super targetForAction:action withSender:sender];
 }
 访问快捷键命令
 我们的应用可以支持外部设备，包括外部键盘。在使用外部键盘时，使用快捷键可以大大提高我们的输入效率。因此从iOS7后，UIResponder类新增了一个只读属性keyCommands，来定义一个响应者支持的快捷键，其声明如下：
 @property(nonatomic, readonly) NSArray *keyCommands
 一个支持硬件键盘命令的响应者对象可以重新定义这个方法并使用它来返回一个其所支持快捷键对象(UIKeyCommand)的数组。每一个快捷键命令表示识别的键盘序列及响应者的操作方法。
 我们用这个方法返回的快捷键命令数组被用于整个响应链。当与快捷键命令对象匹配的快捷键被按下时，UIKit会沿着响应链查找实现了响应行为方法的对象。它调用找到的第一个对象的方法并停止事件的处理。

 管理文本输入模式
 文本输入模式标识当响应者激活时的语言及显示的键盘。UIResponder为此定义了一个属性来返回响应者对象的文本输入模式：
 @property(nonatomic, readonly, retain) UITextInputMode *textInputMode
 对于响应者而言，系统通常显示一个基于用户语言设置的键盘。我们可以重新定义这个属性，并让它返回一个不同的文本输入模式，以让我们的响应者使用一个特定的键盘。用户在响应者被激活时仍然可以改变键盘，在切换到另一个响应者时，可以再恢复到指定的键盘。
 如果我们想让UIKit来跟踪这个响应者的文本输入模式，我们可以通过textInputContextIdentifier属性来设置一个标识，该属性的声明如下：
 @property(nonatomic, readonly, retain) NSString *textInputContextIdentifier
 该标识指明响应者应保留文本输入模式的信息。在跟踪模式下，任何对文本输入模式的修改都会记录下来，当响应者激活时再用于恢复处理。
 为了从程序的user default中清理输入模式信息，UIResponder定义了一个类方法，其声明如下：
 + (void)clearTextInputContextIdentifier:(NSString *)identifier
 调用这个方法可以从程序的user default中移除与指定标识相关的所有文本输入模式。移除这些信息会让响应者重新使用默认的文本输入模式。

 支持User Activities
 从iOS 8起，苹果为我们提供了一个非常棒的功能，即Handoff。使用这一功能，我们可以在一部iOS设备的某个应用上开始做一件事，然后在另一台iOS设备上继续做这件事。Handoff的基本思想是用户在一个应用里所做的任何操作都可以看作是一个Activity，一个Activity可以和一个特定iCloud用户的多台设备关联起来。在编写一个支持Handoff的应用时，会有以下三个交互事件：
 为将在另一台设备上继续做的事创建一个新的User Activity；
 当需要时，用新的数据更新已有的User Activity；
 把一个User Activity传递到另一台设备上。
 为了支持这些交互事件，在iOS 8后，UIResponder类新增了几个方法，我们在此不讨论这几个方法的实际使用，想了解更多的话，可以参考 iOS 8 Handoff 开发指南 。我们在此只是简单描述一下这几个方法。
 在UIResponder中，已经为我们提供了一个userActivity属性，它是一个NSUserActivity对象。因此我们在UIResponder的子类中不需要再去声明一个userActivity属性，直接使用它就行。其声明如下：
 @property(nonatomic, retain) NSUserActivity *userActivity
 由UIKit管理的User Activities会在适当的时间自动保存。一般情况下，我们可以重写UIResponder类的updateUserActivityState:方法来延迟添加表示User Activity的状态数据。当我们不再需要一个User Activity时，我们可以设置userActivity属性为nil。任何由UIKit管理的NSUserActivity对象，如果它没有相关的响应者，则会自动失效。
 另外，多个响应者可以共享一个NSUserActivity实例。
 上面提到的updateUserActivityState:是用于更新给定的User Activity的状态。其定义如下：
 - (void)updateUserActivityState:(NSUserActivity *)activity
 子类可以重写这个方法来按照我们的需要更新给定的User Activity。我们需要使用NSUserActivity对象的addUserInfoEntriesFromDictionary:方法来添加表示用户Activity的状态。
 在我们修改了User Activity的状态后，如果想将其恢复到某个状态，则可以使用以下方法：
 - (void)restoreUserActivityState:(NSUserActivity *)activity 子类可以重写这个方法来使用给定User Activity的恢复响应者的状态。系统会在接收到数据时，将数据传递给application:continueUserActivity:restorationHandler:以做处理。我们重写时应该使用存储在user activity的userInfo字典中的状态数据来恢复对象。当然，我们也可以直接调用这个方法。

 textInputMode 是 UIResponder 在 iOS 7 时增加的属性，作用是控制 UIResponder 的键盘类型。

 官方文档：
 The text input mode identifies the language and keyboard displayed when this responder is active.

 关于 UITextInputMode
 UIKit 会根据 UITextInputMode 的 activeInputModes 来决定键盘会有多少种类型，这个属性取自用户在 iOS 系统设置中的配置。

 在应用中 UIKit 维护一个公共的键盘次序，以决定调起键盘时显示哪一个键盘。用户在调起键盘时切换键盘也会被记录导这个次序中，默认情况下所有的 textField，textView 调起键盘都使用这个次序。

 UIResponder 的 textInputMode 属性
 textInputMode 属性能发挥的作用是指定 UIResponder 调起键盘的时候显示的键盘类型。忽略公共的键盘次序。

 具体的做法是在子类中覆盖 textInputMode 属性。代码如下：

 - (UITextInputMode *)textInputMode
 {
     static UITextInputMode *emojiMode = nil;
     if (emojiMode == nil) {
         for (UITextInputMode *mode in [UITextInputMode activeInputModes]) {
             if ([mode.primaryLanguage isEqualToString:@"emoji"]) {
                 emojiMode = mode;
                 break;
             }
         }
     }
     return emojiMode;
 }
 textInputContextIdentifier 属性
 这个属性的作用是建立一个追踪标识，UIKit 会为每个追踪标识维护独立的键盘次序。

 具体的用法也是在子类中覆盖。代码如下：

 - (NSString *)textInputContextIdentifier
 {
     return @"emojiIdentifier";
 }
 总结
 键盘次序可以看做一个队列，UIKit 有公共的键盘次序
 覆盖 textInputContextIdentifier 后 UIKit 会维护新的键盘次序队列
 textInputMode 的作用优先于键盘次序，覆盖后以此属性为准

     WWDC 2017 session 242 演示了与多人聊天时，系统会记录当前会话的键盘样式是中文还是英文。例如与A聊天，设置的键盘为英文输入，与B聊天设置为中文输入，每次进入A聊天页时，键盘默认就是英文输入，而进入B聊天页键盘默认是中文输入，不需要另外设置。

     实现此功能只需要设置textInputContextIdentifier，系统会根据textInputContextIdentifier自动识别键盘样式，每个会话的textInputContextIdentifier是唯一的。具体代码：


 - (NSString *)textInputContextIdentifier {
     return @"Id";
 }
 */
