# XLsn0w iOS Developer

## 降级cocoapods老版本 安装pod
0. sudo gem install -n /usr/local/bin cocoapods -v 1.6.1
1. git clone https://gitee.com/mirrors/CocoaPods-Specs.git ~/.cocoapods/repos/master
2. pod _1.6.1_ install

# WebView
## 1.说一下 JS 和 OC 互相调用的几种方式？ 
- js调用oc的三种方式:
    
    根据网页重定向截取字符串通过url scheme判断
    
    替换方法.context[@"copyText"]
    
    注入对象:遵守协议JSExport,设置context[@
- oc调用js代码两种方式

    通过webVIew调用 webView stringByEvaluatingJavaScriptFromString: 调用
    
    通过JSContext调用[context evaluateScript:];

## 2.在使用 WKWedView 时遇到过哪些问题？

白屏问题，Cookie 问题，在WKWebView上直接使用NSURLProtocol无法拦截请求，在WKWebView 上通过loadRequ发起的post请求body数据被丢失，截屏问题等


# UIKit
## 1.UIView 和 CALayer 是什么关系？ 

- UIView 继承 UIResponder，而 UIResponder 是响应者对象，可以对iOS 中的事件响应及传递，CALayer 没有继承自 UIResponder，所以 CALayer 不具备响应处理事件的能力。CALayer 是 QuartzCore 中的类，是一个比较底层的用来绘制内容的类，用来绘制UI

- UIView 对 CALayer 封装属性，对 UIView 设置 frame、center、bounds 等位置信息时，其实都是UIView 对 CALayer 进一层封装，使得我们可以很方便地设置控件的位置；例如圆角、阴影等属性， UIView 就没有进一步封装，所以我们还是需要去设置 Layer 的属性来实现功能。

- UIView 是 CALayer 的代理，UIView 持有一个 CALayer 的属性，并且是该属性的代理，用来提供一些 CALayer 行的数据，例如动画和绘制。

## 2.Bounds 和 Frame 的区别?

- Bounds：一般是相对于自身来说的，是控件的内部尺寸。如果你修改了 Bounds，那么子控件的相对位置也会发生改变。

- Frame ：是相对于父控件来说的，是控件的外部尺寸。

## 3.setNeedsDisplay 和 layoutIfNeeded 两者是什么关系？

UIView的setNeedsDisplay和setNeedsLayout两个方法都是异步执行的。而setNeedsDisplay会自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext进行绘制；而setNeedsLayout会默认调用layoutSubViews，给当前的视图做了标记；layoutIfNeeded 查找是否有标记，如果有标记及立刻刷新。

只有setNeedsLayout和layoutIfNeeded这二者合起来使用，才会起到立刻刷新的效果。

## 4.谈谈对UIResponder的理解

UIResponder类是专门用来响应用户的操作处理各种事件的，包括触摸事件(Touch Events)、运动事件(Motion Events)、远程控制事件(Remote Control Events)。我们知道UIApplication、UIView、UIViewController这几个类是直接继承自UIResponder，所以这些类都可以响应事件。当然我们自定义的继承自UIView的View以及自定义的继承自UIViewController的控制器都可以响应事件。

## 5.loadView的作用？

loadView方法会在每次访问UIViewController的view(比如controller.view、self.view)而且view为nil时会被调用，此方法主要用来负责创建UIViewController的view(重写loadView方法，并且不需要调用[super loadView])

这里要提一下 [super loadView]，[super loadView]做了下面几件事。

- 它会先去查找与UIViewController相关联的xib文件，通过加载xib文件来创建UIViewController的view，如果在初始化UIViewController指定了xib文件名，就会根据传入的xib文件名加载对应的xib文件，如果没有明显地传xib文件名，就会加载跟UIViewController同名的xib文件

- 如果没有找到相关联的xib文件，就会创建一个空白的UIView，然后赋值给UIViewController的view属性

综上，在需要自定义UIViewController的view时，可以通过重写loadView方法且不需要调用[super loadView]方法。

## 6.使用 drawRect有什么影响？

drawRect 方法依赖 Core Graphics 框架来进行自定义的绘制
缺点：它处理 touch 事件时每次按钮被点击后，都会用 setNeddsDisplay 进行强制重绘；而且不止一次，每次单点事件触发两次执行。这样的话从性能的角度来说，对 CPU 和内存来说都是欠佳的。特别是如果在我们的界面上有多个这样的UIButton 实例，那就会很糟糕了。这个方法的调用机制也是非常特别. 当你调用 setNeedsDisplay 方法时, UIKit 将会把当前图层标记为 dirty,但还是会显示原来的内容,直到下一次的视图渲染周期,才会将标记为 dirty 的图层重新建立 Core Graphics 上下文,然后将内存中的数据恢复出来, 再使用 CGContextRef 进行绘制

## 7.keyWindow 和 delegate的window有何区别

- delegate.window 程序启动时设置的window对象。

- keyWindow 这个属性保存了[windows]数组中的[UIWindow]对象，该对象最近被发送了[makeKeyAndVisible]消息

一般情况下 delegate.window 和 keyWindow 是同一个对象，但不能保证keyWindow就是delegate.window，因为keyWindow会因为makeKeyAndVisible而变化，例如，程序中添加了一个悬浮窗口，这个时候keywindow就会变化。


# Runtime
## 1.Category 的实现原理？
- Category 实际上是 Category_t的结构体，在运行时，新添加的方法，都被以倒序插入到原有方法列表的最前面，所以不同的Category，添加了同一个方法，执行的实际上是最后一个。

- Category 在刚刚编译完的时候，和原来的类是分开的，只有在程序运行起来后，通过 Runtime ，Category 和原来的类才会合并到一起。

## 2.isa指针的理解，对象的isa指针指向哪里？isa指针有哪两种类型？

- isa 等价于 is kind of

    实例对象的 isa 指向类对象

    类对象的 isa 指向元类对象
    
    元类对象的 isa 指向元类的基类

- isa 有两种类型

    纯指针，指向内存地址
    
    NON_POINTER_ISA，除了内存地址，还存有一些其他信息

## 3.Objective-C 如何实现多重继承？

Object-c的类没有多继承,只支持单继承,如果要实现多继承的话，可使用如下几种方式间接实现

- 通过组合实现

    A和B组合，作为C类的组件

- 通过协议实现
    
    C类实现A和B类的协议方法

- 消息转发实现
    
    forwardInvocation:方法

## 4.runtime 如何实现 weak 属性？

weak 此特质表明该属性定义了一种「非拥有关系」(nonowning relationship)。为这种属性设置新值时，设置方法既不持有新值（新指向的对象），也不释放旧值（原来指向的对象）。

runtime 对注册的类，会进行内存布局，从一个粗粒度的概念上来讲，这时候会有一个 hash 表，这是一个全局表，表中是用 weak 指向的对象内存地址作为 key，用所有指向该对象的 weak 指针表作为 value。当此对象的引用计数为 0 的时候会 dealloc，假如该对象内存地址是 a，那么就会以 a 为 key，在这个 weak 表中搜索，找到所有以 a 为键的 weak 对象，从而设置为 nil。

runtime 如何实现 weak 属性具体流程大致分为 3 步：

- 1、初始化时：runtime 会调用 objc_initWeak 函数，初始化一个新的 weak 指针指向对象的地址。

- 2、添加引用时：objc_initWeak 函数会调用 objc_storeWeak() 函数，objc_storeWeak() 的作用是更新指针指向（指针可能原来指向着其他对象，这时候需要将该 weak 指针与旧对象解除绑定，会调用到 weak_unregister_no_lock），如果指针指向的新对象非空，则创建对应的弱引用表，将 weak 指针与新对象进行绑定，会调用到 weak_register_no_lock。在这个过程中，为了防止多线程中竞争冲突，会有一些锁的操作。

- 3、释放时：调用 clearDeallocating 函数，clearDeallocating 函数首先根据对象地址获取所有 weak 指针地址的数组，然后遍历这个数组把其中的数据设为 nil，最后把这个 entry 从 weak 表中删除，最后清理对象的记录。

## 5.讲一下 OC 的消息机制

- OC中的方法调用其实都是转成了objc_msgSend函数的调用，给receiver（方法调用者）发送了一条消息（selector方法名）

- objc_msgSend底层有3大阶段，消息发送（当前类、父类中查找）、动态方法解析、消息转发

## 6.runtime具体应用

- 利用关联对象（AssociatedObject）给分类添加属性

- 遍历类的所有成员变量（修改textfield的占位文字颜色、字典转模型、自动归档解档）

- 交换方法实现（交换系统的方法）

- 利用消息转发机制解决方法找不到的异常问题

- KVC 字典转模型

## 7.runtime如何通过selector找到对应的IMP地址？

每一个类对象中都一个对象方法列表（对象方法缓存）

- 类方法列表是存放在类对象中isa指针指向的元类对象中（类方法缓存）。

- 方法列表中每个方法结构体中记录着方法的名称,方法实现,以及参数类型，其实selector本质就是方法名称,通过这个方法名称就可以在方法列表中找到对应的方法实现。

- 当我们发送一个消息给一个NSObject对象时，这条消息会在对象的类对象方法列表里查找。

- 当我们发送一个消息给一个类时，这条消息会在类的Meta Class对象的方法列表里查找。

## 8.简述下Objective-C中调用方法的过程

Objective-C是动态语言，每个方法在运行时会被动态转为消息发送，即：objc_msgSend(receiver, selector)，整个过程介绍如下：

- objc在向一个对象发送消息时，runtime库会根据对象的isa指针找到该对象实际所属的类

- 然后在该类中的方法列表以及其父类方法列表中寻找方法运行

- 如果，在最顶层的父类（一般也就NSObject）中依然找不到相应的方法时，程序在运行时会挂掉并抛出异常unrecognized selector sent to XXX

- 但是在这之前，objc的运行时会给出三次拯救程序崩溃的机会，这三次拯救程序奔溃的说明见问题《什么时候会报unrecognized selector的异常》中的说明。

## 9.load和initialize的区别

两者都会自动调用父类的，不需要super操作，且仅会调用一次（不包括外部显示调用).

- load和initialize方法都会在实例化对象之前调用，以main函数为分水岭，前者在main函数之前调用，后者在之后调用。这两个方法会被自动调用，不能手动调用它们。

- load和initialize方法都不用显示的调用父类的方法而是自动调用，即使子类没有initialize方法也会调用父类的方法，而load方法则不会调用父类。

- load方法通常用来进行Method Swizzle，initialize方法一般用于初始化全局变量或静态变量。

- load和initialize方法内部使用了锁，因此它们是线程安全的。实现时要尽可能保持简单，避免阻塞线程，不要再使用锁。

## 10.怎么理解Objective-C是动态运行时语言。

- 主要是将数据类型的确定由编译时,推迟到了运行时。这个问题其实浅涉及到两个概念,运行时和多态。

- 简单来说, 运行时机制使我们直到运行时才去决定一个对象的类别,以及调用该类别对象指定方法。

- 多态:不同对象以自己的方式响应相同的消息的能力叫做多态。

- 意思就是假设生物类(life)都拥有一个相同的方法-eat;那人类属于生物,猪也属于生物,都继承了life后,实现各自的eat,但是调用是我们只需调用各自的eat方法。也就是不同的对象以自己的方式响应了相同的消 息(响应了eat这个选择器)。因此也可以说,运行时机制是多态的基础.






# Runloop
## 1.Runloop 和线程的关系？
- 一个线程对应一个 Runloop。

- 主线程的默认就有了 Runloop。

- 子线程的 Runloop 以懒加载的形式创建。

- Runloop 存储在一个全局的可变字典里，线程是 key ，Runloop 是 value。

## 2.RunLoop的运行模式

- RunLoop的运行模式共有5种，RunLoop只会运行在一个模式下，要切换模式，就要暂停当前模式，重写启动一个运行模式

    ``` c
    - kCFRunLoopDefaultMode, App的默认运行模式，通常主线程是在这个运行模式下运行
    - UITrackingRunLoopMode, 跟踪用户交互事件（用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他Mode影响）
    - kCFRunLoopCommonModes, 伪模式，不是一种真正的运行模式
    - UIInitializationRunLoopMode：在刚启动App时第进入的第一个Mode，启动完成后就不再使用
    - GSEventReceiveRunLoopMode：接受系统内部事件，通常用不到
    ```

## 3.runloop内部逻辑？

- 实际上 RunLoop 就是这样一个函数，其内部是一个 do-while 循环。当你调用 CFRunLoopRun() 时，线程就会一直停留在这个循环里；直到超时或被手动停止，该函数才会返回。

    ![RunLoop](https://qn.nobady.cn/iOS/runloop.png)
    
- 内部逻辑：
    
    1. 通知 Observer 已经进入了 RunLoop
    
    2. 通知 Observer 即将处理 Timer
    
    3. 通知 Observer 即将处理非基于端口的输入源（即将处理 Source0）
    
    4. 处理那些准备好的非基于端口的输入源（处理 Source0）
    
    5. 如果基于端口的输入源准备就绪并等待处理，请立刻处理该事件。转到第 9 步（处理 Source1）
    6. 通知 Observer 线程即将休眠
    
    7. 将线程置于休眠状态，直到发生以下事件之一

        - 事件到达基于端口的输入源（port-based input sources）(也就是 Source0)
        
        - Timer 到时间执行
        
        - 外部手动唤醒
        
        - 为 RunLoop 设定的时间超时

    8. 通知 Observer 线程刚被唤醒（还没处理事件）
    
    9. 处理待处理事件

        - 如果是 Timer 事件，处理 Timer 并重新启动循环，跳到第 2 步
        
        - 如果输入源被触发，处理该事件（文档上是 deliver the event）
        
        - 如果 RunLoop 被手动唤醒但尚未超时，重新启动循环，跳到第 2 步

## 4.autoreleasePool 在何时被释放？

- App启动后，苹果在主线程 RunLoop 里注册了两个 Observer，其回调都是 _wrapRunLoopWithAutoreleasePoolHandler()。

- 第一个 Observer 监视的事件是 Entry(即将进入Loop)，其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池。其 order 是 -2147483647，优先级最高，保证创建释放池发生在其他所有回调之前。

- 第二个 Observer 监视了两个事件： BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。这个 Observer 的 order 是 2147483647，优先级最低，保证其释放池子发生在其他所有回调之后。

- 在主线程执行的代码，通常是写在诸如事件回调、Timer回调内的。这些回调会被 RunLoop 创建好的 AutoreleasePool 环绕着，所以不会出现内存泄漏，开发者也不必显示创建 Pool 了。

## 5.GCD 在Runloop中的使用？

- GCD由 子线程 返回到 主线程,只有在这种情况下才会触发 RunLoop。会触发 RunLoop 的 Source 1 事件。

## 6.AFNetworking 中如何运用 Runloop?

- AFURLConnectionOperation 这个类是基于 NSURLConnection 构建的，其希望能在后台线程接收 Delegate 回调。为此 AFNetworking 单独创建了一个线程，并在这个线程中启动了一个 RunLoop：
    
    ``` c
    + (void)networkRequestThreadEntryPoint:(id)__unused object {
        @autoreleasepool {
            [[NSThread currentThread] setName:@"AFNetworking"];
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
            [runLoop run];
        }
    }

    + (NSThread *)networkRequestThread {
        static NSThread *_networkRequestThread = nil;
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
            [_networkRequestThread start];
        });
        return _networkRequestThread;
    }
    ```

- RunLoop 启动前内部必须要有至少一个 Timer/Observer/Source，所以 AFNetworking 在 [runLoop run] 之前先创建了一个新的 NSMachPort 添加进去了。通常情况下，调用者需要持有这个 NSMachPort (mach_port) 并在外部线程通过这个 port 发送消息到 loop 内；但此处添加 port 只是为了让 RunLoop 不至于退出，并没有用于实际的发送消息。

    ``` c
    - (void)start {
        [self.lock lock];
        if ([self isCancelled]) {
            [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        } else if ([self isReady]) {
            self.state = AFOperationExecutingState;
            [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        }
        [self.lock unlock];
    }
    ```

- 当需要这个后台线程执行任务时，AFNetworking 通过调用 [NSObject performSelector:onThread:..] 将这个任务扔到了后台线程的 RunLoop 中。

## 7.PerformSelector 的实现原理？

- 当调用 NSObject 的 performSelecter:afterDelay: 后，实际上其内部会创建一个 Timer 并添加到当前线程的 RunLoop 中。所以如果当前线程没有 RunLoop，则这个方法会失效。

- 当调用 performSelector:onThread: 时，实际上其会创建一个 Timer 加到对应的线程去，同样的，如果对应线程没有 RunLoop 该方法也会失效。

## 8.PerformSelector:afterDelay:这个方法在子线程中是否起作用？

- 不起作用，子线程默认没有 Runloop，也就没有 Timer。可以使用 GCD的dispatch_after来实现

## 9.事件响应的过程？

- 苹果注册了一个 Source1 (基于 mach port 的) 用来接收系统事件，其回调函数为 __IOHIDEventSystemClientQueueCallback()。

- 当一个硬件事件(触摸/锁屏/摇晃等)发生后，首先由 IOKit.framework 生成一个 IOHIDEvent 事件并由 SpringBoard 接收。这个过程的详细情况可以参考这里。SpringBoard 只接收按键(锁屏/静音等)，触摸，加速，接近传感器等几种 Event，随后用 mach port 转发给需要的 App 进程。随后苹果注册的那个 Source1 就会触发回调，并调用 _UIApplicationHandleEventQueue() 进行应用内部的分发。

- _UIApplicationHandleEventQueue() 会把 IOHIDEvent 处理并包装成 UIEvent 进行处理或分发，其中包括识别 UIGesture/处理屏幕旋转/发送给 UIWindow 等。通常事件比如 UIButton 点击、touchesBegin/Move/End/Cancel 事件都是在这个回调中完成的。

## 10.手势识别的过程？

- 当 _UIApplicationHandleEventQueue() 识别了一个手势时，其首先会调用 Cancel 将当前的 touchesBegin/Move/End 系列回调打断。随后系统将对应的 UIGestureRecognizer 标记为待处理。

- 苹果注册了一个 Observer 监测 BeforeWaiting (Loop即将进入休眠) 事件，这个 Observer 的回调函数是 _UIGestureRecognizerUpdateObserver()，其内部会获取所有刚被标记为待处理的 GestureRecognizer，并执行GestureRecognizer 的回调。

- 当有 UIGestureRecognizer 的变化(创建/销毁/状态改变)时，这个回调都会进行相应处理。

## 11.CADispalyTimer和Timer哪个更精确

CADisplayLink 更精确

- iOS设备的屏幕刷新频率是固定的，CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高。

- NSTimer的精确度就显得低了点，比如NSTimer的触发时间到的时候，runloop如果在阻塞状态，触发时间就会推迟到下一个runloop周期。并且 NSTimer新增了tolerance属性，让用户可以设置可以容忍的触发的时间的延迟范围。

- CADisplayLink使用场合相对专一，适合做UI的不停重绘，比如自定义动画引擎或者视频播放的渲染。NSTimer的使用范围要广泛的多，各种需要单次或者循环定时处理的任务都可以使用。在UI相关的动画或者显示内容使用 CADisplayLink比起用NSTimer的好处就是我们不需要在格外关心屏幕的刷新频率了，因为它本身就是跟屏幕刷新同步的。




# 项目架构
## 1.MVC、MVP、MVVM模式

### MVC（Model、View、Controller）

MVC是比较直观的架构模式，最核心的就是通过Controller层来进行调控，首先看一下官方提供的MVC示意图：

![mvc](https://qn.nobady.cn/iOS/mvc.png)

- Model和View永远不能相互通信，只能通过Controller传递

- Controller可以直接与Model对话（读写调用Model），Model通过NOtification和KVO机制与Controller间接通信

Controller可以直接与View对话，通过IBoutlet直接操作View，IBoutlet直接对应View的控件（例如创建一个Button：需声明一个  IBOutlet UIButton * btn），View通过action向Controller报告时间的发生(用户点击了按钮)。Controller是View的直接数据源

- 优点：对于混乱的项目组织方式，有了一个明确的组织方式。通过Controller来掌控全局，同时将View展示和Model的变化分开

- 缺点：愈发笨重的Controller，随着业务逻辑的增加，大量的代码放进Controller，导致Controller越来越臃肿，堆积成千上万行代码，后期维护起来费时费力

### MVP（Model、View、Presenter）
MVP模式是MVC模式的一个演化版本，其中Model与MVC模式中Model层没有太大区别，主要提供数据存储功能，一般都是用来封装网络获取的json数据；View与MVC中的View层有一些差别，MVP中的View层可以是viewController、view等控件；Presenter层则是作为Model和View的中介，从Model层获取数据之后传给View。

![mvp](https://qn.nobady.cn/iOS/mvp.png)

从上图可以看出，从MVC模式中增加了Presenter层，将UIViewController中复杂的业务逻辑、网络请求等剥离出来。

- 优点 模型和视图完全分离，可以做到修改视图而不影响模型；更高效的使用模型，View不依赖Model，可以说VIew能做到对业务逻辑完全分离

- 缺点 Presenter中除了处理业务逻辑以外，还要处理View-Model两层的协调，也会导致Presenter层的臃肿

### MVVM（Model、Controller/View、ViewModel）

在MVVM中，view和ViewCOntroller联系在一起，我们把它们视为一个组件，view和ViewController都不能直接引用model，而是引用是视图模型即ViewModel。
viewModel是一个用来放置用户输入验证逻辑、视图显示逻辑、网络请求等业务逻辑的地方，这样的设计模式，会轻微增加代码量，但是会减少代码的复杂性

- 优点 VIew可以独立于Model的变化和修改，一个ViewModel可以绑定到不同的View上，降低耦合，增加重用

- 缺点 过于简单的项目不适用、大型的项目视图状态较多时构建和维护成本太大

合理的运用架构模式有利于项目、团队开发工作，但是到底选择哪个设计模式，哪种设计模式更好，就像本文开头所说，不同的设计模式，只是让不同的场景有了更多的选择方案。根据项目场景和开发需求，选择最合适的解决方案。


## 2.关于RAC你有怎样运用到解决不同API依赖关系

- 信号的依赖：使用场景是当信号A执行完才会执行信号B,和请求的依赖很类似,例如请求A请求完毕才执行请求B,我们需要注意信号A必须要执行发送完成信号,否则信号B无法执行

    ``` c
    //这相当于网络请求中的依赖,必须先执行完信号A才会执行信号B
    //经常用作一个请求执行完毕后,才会执行另一个请求
    //注意信号A必须要执行发送完成信号,否则信号B无法执行
    RACSignal * concatSignal = [self.signalA concat:self.signalB]
    //这里我们是对这个拼接信号进行订阅
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    ```
## 3.@weakify和我们宏定义的WeakSelf有什么区别？

@weakify 可以多参数使用

## 4.微服务架构设想。

微服务架构具有以下优势：

- 1.灵活和独立的可扩展性
 
    灵活扩展是微服务架构的主要优势之一。与单片架构不同，每个模块都可以水平扩展并独立于其他模块。因此，微服务架构非常适合大型项目。 

- 2.独立技术堆栈
 
    在微服务架构中，软件工程师有机会使用各种工具和技术构建APP。代码可以用不同的编程语言编写，这为APP开发过程增加了更多的灵活性。

- 3.更好的故障隔离 
    
    如果一个服务失败，它不会影响其他服务的功能。与其他体系结构样式相比，在微服务中，系统继续工作，单片模式下的问题会影响整个APP。

- 4.易于部署和集成

    虽然即使是小代码更改的情况下，开发人员也必须再次部署APP，但在微服务架构中，部署变得更快更轻松。

    由于所有服务都是围绕单一业务流程构建的，因此程序员不必修改和重新部署整个APP，只需要您需要的区域。因此，改进产品也比较简单。

    微服务可以通过全自动部署机制独立部署。此外，通过使用开源持续集成工具，开发人员大大简化了与第三方服务的集成。

- 5.容易理解
 
    微服务体系结构的另一个优点是很容易理解系统是如何工作的以及它是如何开发的。当一个新的团队成员来到这个项目并且必须快速钻研它时，这特别有用。

那么在iOS中如何借鉴这种思想去构建我们的App呢？是需要我们开发者自己去不断探索的


# 性能优化
## 1.造成tableView卡顿的原因有哪些？

- 1.最常用的就是cell的重用， 注册重用标识符

    如果不重用cell时，每当一个cell显示到屏幕上时，就会重新创建一个新的cell

    如果有很多数据的时候，就会堆积很多cell。

    如果重用cell，为cell创建一个ID，每当需要显示cell 的时候，都会先去缓冲池中寻找可循环利用的cell，如果没有再重新创建cell

- 2.避免cell的重新布局

    cell的布局填充等操作 比较耗时，一般创建时就布局好

    如可以将cell单独放到一个自定义类，初始化时就布局好

- 3.提前计算并缓存cell的属性及内容

    当我们创建cell的数据源方法时，编译器并不是先创建cell 再定cell的高度

    而是先根据内容一次确定每一个cell的高度，高度确定后，再创建要显示的cell，滚动时，每当cell进入凭虚都会计算高度，提前估算高度告诉编译器，编译器知道高度后，紧接着就会创建cell，这时再调用高度的具体计算方法，这样可以方式浪费时间去计算显示以外的cell

- 4.减少cell中控件的数量

    尽量使cell得布局大致相同，不同风格的cell可以使用不用的重用标识符，初始化时添加控件，

    不适用的可以先隐藏

- 5.不要使用ClearColor，无背景色，透明度也不要设置为0

    渲染耗时比较长

- 6.使用局部更新

    如果只是更新某组的话，使用reloadSection进行局部更

- 7.加载网络数据，下载图片，使用异步加载，并缓存

- 8.少使用addView 给cell动态添加view

- 9.按需加载cell，cell滚动很快时，只加载范围内的cell

- 10.不要实现无用的代理方法，tableView只遵守两个协议

- 11.缓存行高：estimatedHeightForRow不能和HeightForRow里面的layoutIfNeed同时存在，这两者同时存在才会出现“窜动”的bug。所以我的建议是：只要是固定行高就写预估行高来减少行高调用次数提升性能。如果是动态行高就不要写预估方法了，用一个行高的缓存字典来减少代码的调用次数即可

- 12.不要做多余的绘制工作。在实现drawRect:的时候，它的rect参数就是需要绘制的区域，这个区域之外的不需要进行绘制。例如上例中，就可以用CGRectIntersectsRect、CGRectIntersection或CGRectContainsRect判断是否需要绘制image和text，然后再调用绘制方法。

- 13.预渲染图像。当新的图像出现时，仍然会有短暂的停顿现象。解决的办法就是在bitmap context里先将其画一遍，导出成UIImage对象，然后再绘制到屏幕；

- 14.使用正确的数据结构来存储数据。

## 2.如何提升 tableview 的流畅度？ 
- 本质上是降低 CPU、GPU 的工作，从这两个大的方面去提升性能。

    CPU：对象的创建和销毁、对象属性的调整、布局计算、文本的计算和排版、图片的格式转换和解码、图像的绘制
    
    GPU：纹理的渲染
- 卡顿优化在 CPU 层面
    
    尽量用轻量级的对象，比如用不到事件处理的地方，可以考虑使用 CALayer 取代 UIView
    
    不要频繁地调用 UIView 的相关属性，比如 frame、bounds、transform 等属性，尽量减少不必要的修改
    
    尽量提前计算好布局，在有需要时一次性调整对应的属性，不要多次修改属性
    
    Autolayout 会比直接设置 frame 消耗更多的 CPU 资源
    
    图片的 size 最好刚好跟 UIImageView 的 size 保持一致
    
    控制一下线程的最大并发数量
    
    尽量把耗时的操作放到子线程
    
    文本处理（尺寸计算、绘制）
    
    图片处理（解码、绘制）

- 卡顿优化在 GPU层面

    尽量避免短时间内大量图片的显示，尽可能将多张图片合成一张进行显示

    GPU能处理的最大纹理尺寸是 4096x4096，一旦超过这个尺寸，就会占用 CPU 资源进行处理，所以纹理尽量不要超过这个尺寸
    
    尽量减少视图数量和层次
    
    减少透明的视图（alpha<1），不透明的就设置 opaque 为 YES
    
    尽量避免出现离屏渲染

- iOS 保持界面流畅的技巧

    1.预排版，提前计算
    
    在接收到服务端返回的数据后，尽量将 CoreText 排版的结果、单个控件的高度、cell 整体的高度提前计算好，将其存储在模型的属性中。需要使用时，直接从模型中往外取，避免了计算的过程。

    尽量少用 UILabel，可以使用 CALayer 。避免使用 AutoLayout 的自动布局技术，采取纯代码的方式

    2.预渲染，提前绘制
    
    例如圆形的图标可以提前在，在接收到网络返回数据时，在后台线程进行处理，直接存储在模型数据里，回到主线程后直接调用就可以了

    避免使用 CALayer 的 Border、corner、shadow、mask 等技术，这些都会触发离屏渲染。

    3.异步绘制
    
    4.全局并发线程
    
    5.高效的图片异步加载

## 3.APP启动时间应从哪些方面优化？
    
App启动时间可以通过xcode提供的工具来度量，在Xcode的Product->Scheme-->Edit Scheme->Run->Auguments中，将环境变量DYLD_PRINT_STATISTICS设为YES，优化需以下方面入手

- dylib loading time

    核心思想是减少dylibs的引用
    
    合并现有的dylibs（最好是6个以内）
    
    使用静态库

- rebase/binding time

    核心思想是减少DATA块内的指针
    
    减少Object C元数据量，减少Objc类数量，减少实例变量和函数（与面向对象设计思想冲突）
    
    减少c++虚函数
    
    多使用Swift结构体（推荐使用swift）

- ObjC setup time
    
    核心思想同上，这部分内容基本上在上一阶段优化过后就不会太过耗时
    
    initializer time

- 使用initialize替代load方法
    
    减少使用c/c++的attribute((constructor))；推荐使用dispatch_once() pthread_once() std:once()等方法
    
    推荐使用swift
    
    不要在初始化中调用dlopen()方法，因为加载过程是单线程，无锁，如果调用dlopen则会变成多线程，会开启锁的消耗，同时有可能死锁
    
    不要在初始化中创建线程

## 4.如何降低APP包的大小

降低包大小需要从两方面着手

- 可执行文件

    编译器优化：Strip Linked Product、Make Strings Read-Only、Symbols Hidden by Default 设置为 YES，去掉异常支持，Enable C++ Exceptions、Enable Objective-C Exceptions 设置为 NO， Other C Flags 添加 -fno-exceptions
利用 AppCode 检测未使用的代码：菜单栏 -> Code -> Inspect Code

    编写LLVM插件检测出重复代码、未被调用的代码

- 资源（图片、音频、视频 等）

    优化的方式可以对资源进行无损的压缩
    
    去除没有用到的资源： https://github.com/tinymind/LSUnusedResources

## 5.如何检测离屏渲染与优化

- 检测，通过勾选Xcode的Debug->View Debugging-->Rendering->Run->Color Offscreen-Rendered Yellow项。

- 优化，如阴影，在绘制时添加阴影的路径

## 6.怎么检测图层混合

1、模拟器debug中color blended layers红色区域表示图层发生了混合

2、Instrument-选中Core Animation-勾选Color Blended Layers

避免图层混合：

- 确保控件的opaque属性设置为true，确保backgroundColor和父视图颜色一致且不透明

- 如无特殊需要，不要设置低于1的alpha值

- 确保UIImage没有alpha通道

UILabel图层混合解决方法：

iOS8以后设置背景色为非透明色并且设置label.layer.masksToBounds=YES让label只会渲染她的实际size区域，就能解决UILabel的图层混合问题

iOS8 之前只要设置背景色为非透明的就行

为什么设置了背景色但是在iOS8上仍然出现了图层混合呢？

UILabel在iOS8前后的变化，在iOS8以前，UILabel使用的是CALayer作为底图层，而在iOS8开始，UILabel的底图层变成了_UILabelLayer，绘制文本也有所改变。在背景色的四周多了一圈透明的边，而这一圈透明的边明显超出了图层的矩形区域，设置图层的masksToBounds为YES时，图层将会沿着Bounds进行裁剪 图层混合问题解决了

## 7.日常如何检查内存泄露？

- 目前我知道的方式有以下几种

    Memory Leaks
    
    Alloctions
    
    Analyse
    
    Debug Memory Graph
    
    MLeaksFinder

- 泄露的内存主要有以下两种：

    Laek Memory 这种是忘记 Release 操作所泄露的内存。
    
    Abandon Memory 这种是循环引用，无法释放掉的内存。





# 网络
## 1.网络七层协议
- 应用层：

    1.用户接口、应用程序；

    2.Application典型设备：网关；

    3.典型协议、标准和应用：TELNET、FTP、HTTP

- 表示层：
    
    1.数据表示、压缩和加密presentation

    2.典型设备：网关

    3.典型协议、标准和应用：ASCLL、PICT、TIFF、JPEG|MPEG

    4.表示层相当于一个东西的表示，表示的一些协议，比如图片、声音和视频MPEG。

- 会话层：

    1.会话的建立和结束；

    2.典型设备：网关；

    3.典型协议、标准和应用：RPC、SQL、NFS、X WINDOWS、ASP

- 传输层：

    1.主要功能：端到端控制Transport；

    2.典型设备：网关；

    3.典型协议、标准和应用：TCP、UDP、SPX

- 网络层：

    1.主要功能：路由、寻址Network；

    2.典型设备：路由器；

    3.典型协议、标准和应用：IP、IPX、APPLETALK、ICMP；

- 数据链路层：

    1.主要功能：保证无差错的疏忽链路的data link；

    2.典型设备：交换机、网桥、网卡；

    3.典型协议、标准和应用：802.2、802.3ATM、HDLC、FRAME RELAY；

- 物理层：

    1.主要功能：传输比特流Physical；

    2.典型设备：集线器、中继器

    3.典型协议、标准和应用：V.35、EIA/TIA-232.

## 2.Http 和 Https 的区别？Https为什么更加安全？
- 区别
    
    1.HTTPS 需要向机构申请 CA 证书，极少免费。

    2.HTTP 属于明文传输，HTTPS基于 SSL 进行加密传输。

    3.HTTP 端口号为 80，HTTPS 端口号为 443 。

    4.HTTPS 是加密传输，有身份验证的环节，更加安全。
- 安全

    SSL(安全套接层) TLS(传输层安全)

    以上两者在传输层之上，对网络连接进行加密处理，保障数据的完整性，更加的安全。

## 3.HTTPS的连接建立流程

HTTPS为了兼顾安全与效率，同时使用了对称加密和非对称加密。在传输的过程中会涉及到三个密钥：

- 服务器端的公钥和私钥，用来进行非对称加密

- 客户端生成的随机密钥，用来进行对称加密
    
    ![https](https://qn.nobady.cn/iOS/https.png)

如上图，HTTPS连接过程大致可分为八步:

- 1、客户端访问HTTPS连接。
    
    客户端会把安全协议版本号、客户端支持的加密算法列表、随机数C发给服务端。

- 2、服务端发送证书给客户端

    服务端接收密钥算法配件后，会和自己支持的加密算法列表进行比对，如果不符合，则断开连接。否则，服务端会在该算法列表中，选择一种对称算法（如AES）、一种公钥算法（如具有特定秘钥长度的RSA）和一种MAC算法发给客户端。
    
    服务器端有一个密钥对，即公钥和私钥，是用来进行非对称加密使用的，服务器端保存着私钥，不能将其泄露，公钥可以发送给任何人。
    
    在发送加密算法的同时还会把数字证书和随机数S发送给客户端

- 3、客户端验证server证书

    会对server公钥进行检查，验证其合法性，如果发现发现公钥有问题，那么HTTPS传输就无法继续。

- 4、客户端组装会话秘钥
    
    如果公钥合格，那么客户端会用服务器公钥来生成一个前主秘钥(Pre-Master Secret，PMS)，并通过该前主秘钥和随机数C、S来组装成会话秘钥

- 5、客户端将前主秘钥加密发送给服务端

    是通过服务端的公钥来对前主秘钥进行非对称加密，发送给服务端

- 6、服务端通过私钥解密得到前主秘钥

    服务端接收到加密信息后，用私钥解密得到主秘钥。

- 7、服务端组装会话秘钥

    服务端通过前主秘钥和随机数C、S来组装会话秘钥。

    至此，服务端和客户端都已经知道了用于此次会话的主秘钥。

- 8、数据传输

    客户端收到服务器发送来的密文，用客户端密钥对其进行对称解密，得到服务器发送的数据。
    
    同理，服务端收到客户端发送来的密文，用服务端密钥对其进行对称解密，得到客户端发送的数据。

## 4.解释一下 三次握手 和 四次挥手

- 三次握手
    
    1.由客户端向服务端发送 SYN 同步报文。

    2.当服务端收到 SYN 同步报文之后，会返回给客户端 SYN 同步报文和 ACK 确认报文。

    3.客户端会向服务端发送 ACK 确认报文，此时客户端和服务端的连接正式建立。

- 建立连接
    
    1.这个时候客户端就可以通过 Http 请求报文，向服务端发送请求

    2.服务端接收到客户端的请求之后，向客户端回复 Http 响应报文。

- 四次挥手

    当客户端和服务端的连接想要断开的时候，要经历四次挥手的过程，步骤如下：

    1.先由客户端向服务端发送 FIN 结束报文。

    2.服务端会返回给客户端 ACK 确认报文 。此时，由客户端发起的断开连接已经完成。

    3.服务端会发送给客户端 FIN 结束报文 和 ACK 确认报文。

    4.客户端会返回 ACK 确认报文到服务端，至此，由服务端方向的断开连接已经完成。

## 5.TCP 和 UDP的区别

- TCP：面向连接、传输可靠(保证数据正确性,保证数据顺序)、用于传输大量数据(流模式)、速度慢，建立连接需要开销较多(时间，系统资源)。

- UDP：面向非连接、传输不可靠、用于传输少量数据(数据包模式)、速度快。

## 6.Cookie和Session

cookie
    
- 1.用户与服务器的交互

    cookie主要是用来记录用户状态，区分用户，状态保存在客户端。cookie功能需要浏览器的支持。如果浏览器不支持cookie（如大部分手机中的浏览器）或者把cookie禁用了，cookie功能就会失效。
    ![cookie](https://qn.nobady.cn/iOS/cookie.png)

    a).首次访问amazon时，客户端发送一个HTTP请求到服务器端 。服务器端发送一个HTTP响应到客户端，其中包含Set-Cookie头部

    b).客户端发送一个HTTP请求到服务器端，其中包含Cookie头部。服务器端发送一个HTTP响应到客户端

    c).隔段时间再去访问时，客户端会直接发包含Cookie头部的HTTP请求。服务器端发送一个HTTP响应到客户端

- 2.cookie的修改和删除
    
    在修改cookie的时候，只需要新cookie覆盖旧cookie即可，在覆盖的时候，由于Cookie具有不可跨域名性，注意name、path、domain需与原cookie一致
    
    删除cookie也一样，设置cookie的过期时间expires为过去的一个时间点，或者maxAge = 0(Cookie的有效期,单位为秒)即可

- 3、cookie的安全

    事实上，cookie的使用存在争议，因为它被认为是对用户隐私的一种侵害，而且cookie并不安全
    
    HTTP协议不仅是无状态的，而且是不安全的。使用HTTP协议的数据不经过任何加密就直接在网络上传播，有被截获的可能。使用HTTP协议传输很机密的内容是一种隐患。

    
    a).如果不希望Cookie在HTTP等非安全协议中传输，可以设置Cookie的secure属性为true。浏览器只会在HTTPS和SSL等安全协议中传输此类Cookie。

    b).此外，secure属性并不能对Cookie内容加密，因而不能保证绝对的安全性。如果需要高安全性，需要在程序中对Cookie内容加密、解密，以防泄密。

    c).也可以设置cookie为HttpOnly，如果在cookie中设置了HttpOnly属性，那么通过js脚本将无法读取到cookie信息，这样能有效的防止XSS（跨站脚本攻击）攻击

Session

- Session是服务器端使用的一种记录客户端状态的机制，使用上比Cookie简单一些，相应的也增加了服务器的存储压力。

- Session是另一种记录客户状态的机制，不同的是Cookie保存在客户端浏览器中，而Session保存在服务器上。
客户端浏览器访问服务器的时候，服务器把客户端信息以某种形式记录在服务器上。这就是Session。客户端浏览器再次访问时只需要从该Session中查找该客户的状态就可以了。

    ![session](https://qn.nobady.cn/iOS/session.png)

- 如图：

    当程序需要为某个客户端的请求创建一个session时，服务器首先检查这个客户端的请求里是否已包含了一个session标识（称为SessionId）

    如果已包含则说明以前已经为此客户端创建过session，服务器就按照SessionId把这个session检索出来，使用（检索不到，会新建一个）

    如果客户端请求不包含SessionId，则为此客户端创建一个session并且生成一个与此session相关联的SessionId，SessionId的值应该是一个既不会重复，又不容易被找到规律以仿造的字符串，这个SessionId将被在本次响应中返回给客户端保存。

    保存这个SessionId的方式可以采用cookie，这样在交互过程中浏览器可以自动的按照规则把这个标识发送给服务器。但cookie可以被人为的禁止，则必须有其他机制以便在cookie被禁止时仍然能够把SessionId传递回服务器。

Cookie 和Session 的区别：

- 1、cookie数据存放在客户的浏览器上，session数据放在服务器上。

- 2、cookie相比session不是很安全，别人可以分析存放在本地的cookie并进行cookie欺骗,考虑到安全应当使用session。

- 3、session会在一定时间内保存在服务器上。当访问增多，会比较占用你服务器的性能,考虑到减轻服务器性能方面，应当使用cookie。

- 4、单个cookie保存的数据不能超过4K，很多浏览器都限制一个站点最多保存20个cookie。而session存储在服务端，可以无限量存储

- 5、所以：将登录信息等重要信息存放为session;其他信息如果需要保留，可以放在cookie中

## 7.DNS是什么

因特网上的主机，可以使用多种方式标识，比如主机名或IP地址。一种标识方法就是用它的主机名（hostname），比如·www.baidu.com、www.google.com、gaia.cs.umass.edu等。这方式方便人们记忆和接受，但是这种长度不一、没有规律的字符串路由器并不方便处理。还有一种方式，就是直接使用定长的、有着清晰层次结构的IP地址，路由器比较热衷于这种方式。为了折衷这两种方式，我们需要一种能进行主机名到IP地址转换的目录服务。这就是域名系统（Domain Name System，DNS）的主要任务。

- DNS是：
    
    1、一个由分层的DNS服务器实现的分布式数据库

    2、一个使得主机能够查询分布式数据库的应用层协议


- DNS服务器通常是运行BIND软件的UNIX机器，DNS协议运行在UDP上，使用53号端口

- DNS通常是由其他应用层协议所使用的，包括HTTP、SMTP等。其作用则是：将用户提供的主机名解析为IP地址

- DNS的一种简单设计就是在因特网上只使用一个DNS服务器，该服务器包含所有的映射。很明显这种设计是有很大的问题的：

    单点故障：如果该DNS服务器崩溃，全世界的网络随之瘫痪

    通信容量：单个DNS服务器必须处理所有DNS查询

    远距离的集中式数据库：单个DNS服务器必须面对所有用户，距离过远会有严重的时延。

    维护：该数据库过于庞大，还需要对新添加的主机频繁更新。

所以，DNS被设计成了一个分布式、层次数据库

## 8.DNS解析过程

以www.163.com为例:

- 客户端打开浏览器，输入一个域名。比如输入www.163.com，这时，客户端会发出一个DNS请求到本地DNS服务器。本地DNS服务器一般都是你的网络接入服务器商提供，比如中国电信，中国移动。

- 查询www.163.com的DNS请求到达本地DNS服务器之后，本地DNS服务器会首先查询它的缓存记录，如果缓存中有此条记录，就可以直接返回结果。如果没有，本地DNS服务器还要向DNS根服务器进行查询。

- 根DNS服务器没有记录具体的域名和IP地址的对应关系，而是告诉本地DNS服务器，你可以到域服务器上去继续查询，并给出域服务器的地址。

- 本地DNS服务器继续向域服务器发出请求，在这个例子中，请求的对象是.com域服务器。.com域服务器收到请求之后，也不会直接返回域名和IP地址的对应关系，而是告诉本地DNS服务器，你的域名的解析服务器的地址。

- 最后，本地DNS服务器向域名的解析服务器发出请求，这时就能收到一个域名和IP地址对应关系，本地DNS服务器不仅要把IP地址返回给用户电脑，还要把这个对应关系保存在缓存中，以备下次别的用户查询时，可以直接返回结果，加快网络访问。






    


# 多线程
## 1.进程与线程

- 进程：

    1.进程是一个具有一定独立功能的程序关于某次数据集合的一次运行活动，它是操作系统分配资源的基本单元.

    2.进程是指在系统中正在运行的一个应用程序，就是一段程序的执行过程,我们可以理解为手机上的一个app.

    3.每个进程之间是独立的，每个进程均运行在其专用且受保护的内存空间内，拥有独立运行所需的全部资源

- 线程

    1.程序执行流的最小单元，线程是进程中的一个实体.
    
    2.一个进程要想执行任务,必须至少有一条线程.应用程序启动的时候，系统会默认开启一条线程,也就是主线程

-  进程和线程的关系
    
    1.线程是进程的执行单元，进程的所有任务都在线程中执行
    
    2.线程是 CPU 分配资源和调度的最小单位
    
    3.一个程序可以对应多个进程(多进程),一个进程中可有多个线程,但至少要有一条线程
    
    4.同一个进程内的线程共享进程资源

## 2.什么是多线程？

- 多线程的实现原理：事实上，同一时间内单核的CPU只能执行一个线程，多线程是CPU快速的在多个线程之间进行切换（调度），造成了多个线程同时执行的假象。

- 如果是多核CPU就真的可以同时处理多个线程了。

- 多线程的目的是为了同步完成多项任务，通过提高系统的资源利用率来提高系统的效率。

## 3.多线程的优点和缺点

- 优点:
 
     能适当提高程序的执行效率
    
    能适当提高资源利用率（CPU、内存利用率）

- 缺点:
    
    开启线程需要占用一定的内存空间（默认情况下，主线程占用1M，子线程占用512KB），如果开启大量的线程，会占用大量的内存空间，降低程序的性能
    
    线程越多，CPU在调度线程上的开销就越大
    
    程序设计更加复杂：比如线程之间的通信、多线程的数据共享

## 4.多线程的 并行 和 并发 有什么区别？

- 并行：充分利用计算机的多核，在多个线程上同步进行 

- 并发：在一条线程上通过快速切换，让人感觉在同步进行

## 5.iOS中实现多线程的几种方案，各自有什么特点？

- NSThread 面向对象的，需要程序员手动创建线程，但不需要手动销毁。子线程间通信很难。

- GCD c语言，充分利用了设备的多核，自动管理线程生命周期。比NSOperation效率更高。

- NSOperation 基于gcd封装，更加面向对象，比gcd多了一些功能。

## 6.多个网络请求完成后执行下一步

- 使用GCD的dispatch_group_t

    创建一个dispatch_group_t

    每次网络请求前先dispatch_group_enter,请求回调后再dispatch_group_leave，enter和leave必须配合使用，有几次enter就要有几次leave，否则group会一直存在。

    当所有enter的block都leave后，会执行dispatch_group_notify的block。

    ``` c 
    NSString *str = @"http://xxxx.com/";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    for (int i=0; i<10; i++) {
        dispatch_group_enter(downloadGroup);
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d---%d",i,i);
            dispatch_group_leave(downloadGroup);
        }];
        [task resume];
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    ```

- 使用GCD的信号量dispatch_semaphore_t

    dispatch_semaphore信号量为基于计数器的一种多线程同步机制。如果semaphore计数大于等于1，计数-1，返回，程序继续运行。如果计数为0，则等待。dispatch_semaphore_signal(semaphore)为计数+1操作,dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER)为设置等待时间，这里设置的等待时间是一直等待。

    创建semaphore为0，等待，等10个网络请求都完成了，dispatch_semaphore_signal(semaphore)为计数+1，然后计数-1返回

    ``` c 
    NSString *str = @"http://xxxx.com/";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (int i=0; i<10; i++) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d---%d",i,i);
            count++;
            if (count==10) {
                dispatch_semaphore_signal(sem);
                count = 0;
            }
        }];
        [task resume];
    }
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    ```

## 7.多个网络请求顺序执行后执行下一步

- 使用信号量semaphore

    每一次遍历，都让其dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)，这个时候线程会等待，阻塞当前线程，直到dispatch_semaphore_signal(sem)调用之后
    ``` c 
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (int i=0; i<10; i++) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"%d---%d",i,i);
            dispatch_semaphore_signal(sem);
        }];
        
        [task resume];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    ```
## 8.异步操作两组数据时, 执行完第一组之后, 才能执行第二组
    
- 这里使用dispatch_barrier_async栅栏方法即可实现

    ``` c 
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        NSLog(@"第一次任务的主线程为: %@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"第二次任务的主线程为: %@", [NSThread currentThread]);
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"第一次任务, 第二次任务执行完毕, 继续执行");
    });

    dispatch_async(queue, ^{
        NSLog(@"第三次任务的主线程为: %@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"第四次任务的主线程为: %@", [NSThread currentThread]);
    });
    ```
## 9.多线程中的死锁？

死锁是由于多个线程（进程）在执行过程中，因为争夺资源而造成的互相等待现象，你可以理解为卡主了。产生死锁的必要条件有四个：

- 互斥条件 ： 指进程对所分配到的资源进行排它性使用，即在一段时间内某资源只由一个进程占用。如果此时还有其它进程请求资源，则请求者只能等待，直至占有资源的进程用毕释放。
- 请求和保持条件 ： 指进程已经保持至少一个资源，但又提出了新的资源请求，而该资源已被其它进程占有，此时请求进程阻塞，但又对自己已获得的其它资源保持不放。
- 不可剥夺条件 ： 指进程已获得的资源，在未使用完之前，不能被剥夺，只能在使用完时由自己释放。
- 环路等待条件 ： 指在发生死锁时，必然存在一个进程——资源的环形链，即进程集合{P0，P1，P2，···，Pn}中的P0正在等待一个P1占用的资源；P1正在等待P2占用的资源，……，Pn正在等待已被P0占用的资源。

    最常见的就是 同步函数 + 主队列 的组合，本质是队列阻塞。

    ``` c 
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });

    NSLog(@"1");
    // 什么也不会打印，直接报错
    ```
## 10.GCD执行原理？

- GCD有一个底层线程池，这个池中存放的是一个个的线程。之所以称为“池”，很容易理解出这个“池”中的线程是可以重用的，当一段时间后这个线程没有被调用胡话，这个线程就会被销毁。注意：开多少条线程是由底层线程池决定的（线程建议控制再3~5条），池是系统自动来维护，不需要我们程序员来维护（看到这句话是不是很开心？）
而我们程序员需要关心的是什么呢？我们只关心的是向队列中添加任务，队列调度即可。

- 如果队列中存放的是同步任务，则任务出队后，底层线程池中会提供一条线程供这个任务执行，任务执行完毕后这条线程再回到线程池。这样队列中的任务反复调度，因为是同步的，所以当我们用currentThread打印的时候，就是同一条线程。

- 如果队列中存放的是异步的任务，（注意异步可以开线程），当任务出队后，底层线程池会提供一个线程供任务执行，因为是异步执行，队列中的任务不需等待当前任务执行完毕就可以调度下一个任务，这时底层线程池中会再次提供一个线程供第二个任务执行，执行完毕后再回到底层线程池中。

- 这样就对线程完成一个复用，而不需要每一个任务执行都开启新的线程，也就从而节约的系统的开销，提高了效率。在iOS7.0的时候，使用GCD系统通常只能开5~8条线程，iOS8.0以后，系统可以开启很多条线程，但是实在开发应用中，建议开启线程条数：3~5条最为合理。


# 消息传递的方式

## 1.KVC实现原理

- KVC，键-值编码，使用字符串直接访问对象的属性。

- 底层实现，当一个对象调用setValue方法时，方法内部会做以下操作：

    1.检查是否存在相应key的set方法，如果存在，就调用set方法

    2.如果set方法不存在，就会查找与key相同名称并且带下划线的成员属性，如果有，则直接给成员属性赋值

    3.如果没有找到_key，就会查找相同名称的属性key，如果有就直接赋值

    4.如果还没找到，则调用valueForUndefinedKey：和setValue：forUndefinedKey：方法

## 2.KVO的实现原理

![KVO](https://qn.nobady.cn/iOS/kvo.png)

KVO-键值观察机制，原理如下：

- 1.当给A类添加KVO的时候，runtime动态的生成了一个子类NSKVONotifying_A，让A类的isa指针指向NSKVONotifying_A类，重写class方法，隐藏对象真实类信息

- 2.重写监听属性的setter方法，在setter方法内部调用了Foundation 的 _NSSetObjectValueAndNotify 函数

- 3._NSSetObjectValueAndNotify函数内部
    
    a) 首先会调用 willChangeValueForKey 

    b) 然后给属性赋值 

    c) 最后调用 didChangeValueForKey 

    d) 最后调用 observer 的 observeValueForKeyPath 去告诉监听器属性值发生了改变 .

- 4.重写了dealloc做一些 KVO 内存释放 

## 3.如何手动触发KVO方法

- 手动调用willChangeValueForKey和didChangeValueForKey方法

- 键值观察通知依赖于 NSObject 的两个方法: willChangeValueForKey: 和 didChangeValueForKey。在一个被观察属性发生改变之前， willChangeValueForKey: 一定会被调用，这就 会记录旧的值。而当改变发生后， didChangeValueForKey 会被调用，继而 observeValueForKey:ofObject:change:context: 也会被调用。如果可以手动实现这些调用，就可以实现“手动触发”了
有人可能会问只调用didChangeValueForKey方法可以触发KVO方法，其实是不能的，因为willChangeValueForKey: 记录旧的值，如果不记录旧的值，那就没有改变一说了

## 4.通知和代理有什么区别

- 通知是观察者模式，适合一对多的场景

- 代理模式适合一对一的反向传值

- 通知耦合度低，代理的耦合度高

## 5.block和delegate的区别

- delegate运行成本低，block的运行成本高
    
    block出栈需要将使用的数据从栈内存拷贝到堆内存，当然对象的话就是加计数，使用完或者block置nil后才消除。delegate只是保存了一个对象指针，直接回调，没有额外消耗。就像C的函数指针，只多做了一个查表动作。

- delegate更适用于多个回调方法（3个以上），block则适用于1，2个回调时。

## 6.为什么Block用copy关键字

Block在没有使用外部变量时，内存存在全局区，然而，当Block在使用外部变量的时候，内存是存在于栈区，当Block copy之后，是存在堆区的。存在于栈区的特点是对象随时有可能被销毁，一旦销毁在调用的时候，就会造成系统的崩溃。所以Block要用copy关键字。


# 内存管理
## 1.什么情况使用weak关键字，相比assign有什么不同？
- 什么情况使用 weak 关键字？

    在 ARC 中,在有可能出现循环引用的时候,往往要通过让其中一端使用 weak 来解决,比如: delegate 代理属性

    自身已经对它进行一次强引用,没有必要再强引用一次,此时也会使用 weak,自定义 IBOutlet 控件属性一般也使用 weak；当然，也可以使用strong。在下文也有论述：《IBOutlet连出来的视图属性为什么可以被设置成weak?》

- 不同点：

    weak 此特质表明该属性定义了一种“非拥有关系” (nonowning relationship)。为这种属性设置新值时，设置方法既不保留新值，也不释放旧值。此特质同assign类似， 然而在属性所指的对象遭到摧毁时，属性值也会清空(nil out)。 而 assign 的“设置方法”只会执行针对“纯量类型” (scalar type，例如 CGFloat 或 NSlnteger 等)的简单赋值操作。

    assign 可以用非 OC 对象,而 weak 必须用于 OC 对象

## 2.如何让自己的类用copy修饰符？如何重写带copy关键字的setter？

- 若想令自己所写的对象具有拷贝功能，则需实现 NSCopying 协议。如果自定义的对象分为可变版本与不可变版本，那么就要同时实现 NSCopying 与 NSMutableCopying 协议。

    具体步骤：

    需声明该类遵从 NSCopying 协议
    
    实现 NSCopying 协议。该协议只有一个方法:
    
    ``` c 
    - (id)copyWithZone:(NSZone *)zone;
    ```

    注意：一提到让自己的类用 copy 修饰符，我们总是想覆写copy方法，其实真正需要实现的却是 “copyWithZone” 方法。

- 重写带 copy 关键字的 setter，例如：
    
    ``` c 
    - (void)setName:(NSString *)name {
        //[_name release];
        _name = [name copy];
    }
    ```

## 3.深拷贝与浅拷贝

浅拷贝只是对指针的拷贝，拷贝后两个指针指向同一个内存空间，深拷贝不但对指针进行拷贝，而且对指针指向的内容进行拷贝，经深拷贝后的指针是指向两个不同地址的指针。

当对象中存在指针成员时，除了在复制对象时需要考虑自定义拷贝构造函数，还应该考虑以下两种情形：

- 当函数的参数为对象时，实参传递给形参的实际上是实参的一个拷贝对象，系统自动通过拷贝构造函数实现；

- 当函数的返回值为一个对象时，该对象实际上是函数内对象的一个拷贝，用于返回函数调用处。


copy方法:如果是非可扩展类对象，则是浅拷贝。如果是可扩展类对象，则是深拷贝。

mutableCopy方法:无论是可扩展类对象还是不可扩展类对象，都是深拷贝。


## 4.@property的本质是什么？ivar、getter、setter是如何生成并添加到这个类中的

- @property 的本质是实例变量（ivar）+存取方法（access method ＝ getter + setter）,即 @property = ivar + getter + setter;
    
    “属性” (property)作为 Objective-C 的一项特性，主要的作用就在于封装对象中的数据。 Objective-C 对象通常会把其所需要的数据保存为各种实例变量。实例变量一般通过“存取方法”(access method)来访问。其中，“获取方法” (getter)用于读取变量值，而“设置方法” (setter)用于写入变量值。

- ivar、getter、setter 是自动合成这个类中的
    
    完成属性定义后，编译器会自动编写访问这些属性所需的方法，此过程叫做“自动合成”(autosynthesis)。需要强调的是，这个过程由编译 器在编译期执行，所以编辑器里看不到这些“合成方法”(synthesized method)的源代码。除了生成方法代码 getter、setter 之外，编译器还要自动向类中添加适当类型的实例变量，并且在属性名前面加下划线，以此作为实例变量的名字。在前例中，会生成两个实例变量，其名称分别为 _firstName 与 _lastName。也可以在类的实现代码里通过 @synthesize 语法来指定实例变量的名字.

## 5.@protocol和category中如何使用@property

- 在 protocol 中使用 property 只会生成 setter 和 getter 方法声明,我们使用属性的目的,是希望遵守我协议的对象能实现该属性

- category 使用 @property 也是只会生成 setter 和 getter 方法的声明,如果我们真的需要给 category 增加属性的实现,需要借助于运行时的两个函数：objc_setAssociatedObject和objc_getAssociatedObject

## 6.简要说一下@autoreleasePool的数据结构？？

简单说是双向链表，每张链表头尾相接，有 parent、child指针

每创建一个池子，会在首部创建一个 哨兵 对象,作为标记

最外层池子的顶端会有一个next指针。当链表容量满了，就会在链表的顶端，并指向下一张表。

## 7.BAD_ACCESS在什么情况下出现？

访问了悬垂指针，比如对一个已经释放的对象执行了release、访问已经释放对象的成员变量或者发消息。 死循环

## 8.使用CADisplayLink、NSTimer有什么注意点？

CADisplayLink、NSTimer会造成循环引用，可以使用YYWeakProxy或者为CADisplayLink、NSTimer添加block方法解决循环引用

## 9.iOS内存分区情况

- 栈区（Stack）

    由编译器自动分配释放，存放函数的参数，局部变量的值等
    
    栈是向低地址扩展的数据结构，是一块连续的内存区域

- 堆区（Heap）

    由程序员分配释放
    
    是向高地址扩展的数据结构，是不连续的内存区域

- 全局区

    全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域，未初始化的全局变量和未初始化的静态变量在相邻的另一块区域

    程序结束后由系统释放

- 常量区

    常量字符串就是放在这里的
    
    程序结束后由系统释放

- 代码区

    存放函数体的二进制代码

- 注：

    - 在 iOS 中，堆区的内存是应用程序共享的，堆中的内存分配是系统负责的
    
    - 系统使用一个链表来维护所有已经分配的内存空间（系统仅仅记录，并不管理具体的内容）
    
    - 变量使用结束后，需要释放内存，OC 中是判断引用计数是否为 0，如果是就说明没有任何变量使用该空间，那么系统将其回收
    
    - 当一个 app 启动后，代码区、常量区、全局区大小就已经固定，因此指向这些区的指针不会产生崩溃性的错误。而堆区和栈区是时时刻刻变化的（堆的创建销毁，栈的弹入弹出），所以当使用一个指针指向这个区里面的内存时，一定要注意内存是否已经被释放，否则会产生程序崩溃（也即是野指针报错）

## 10.iOS内存管理方式

- Tagged Pointer（小对象）

    Tagged Pointer 专门用来存储小的对象，例如 NSNumber 和 NSDate
    
    Tagged Pointer 指针的值不再是地址了，而是真正的值。所以，实际上它不再是一个对象了，它只是一个披着对象皮的普通变量而已。所以，它的内存并不存储在堆中，也不需要 malloc 和 free
    
    在内存读取上有着 3 倍的效率，创建时比以前快 106 倍
    
    objc_msgSend 能识别 Tagged Pointer，比如 NSNumber 的 intValue 方法，直接从指针提取数据
    
    使用 Tagged Pointer 后，指针内存储的数据变成了 Tag + Data，也就是将数据直接存储在了指针中
    
- NONPOINTER_ISA （指针中存放与该对象内存相关的信息）
    苹果将 isa 设计成了联合体，在 isa 中存储了与该对象相关的一些内存的信息，原因也如上面所说，并不需要 64 个二进制位全部都用来存储指针。
    
    isa 的结构：
    ``` c 
    // x86_64 架构
    struct {
        uintptr_t nonpointer        : 1;  // 0:普通指针，1:优化过，使用位域存储更多信息
        uintptr_t has_assoc         : 1;  // 对象是否含有或曾经含有关联引用
        uintptr_t has_cxx_dtor      : 1;  // 表示是否有C++析构函数或OC的dealloc
        uintptr_t shiftcls          : 44; // 存放着 Class、Meta-Class 对象的内存地址信息
        uintptr_t magic             : 6;  // 用于在调试时分辨对象是否未完成初始化
        uintptr_t weakly_referenced : 1;  // 是否被弱引用指向
        uintptr_t deallocating      : 1;  // 对象是否正在释放
        uintptr_t has_sidetable_rc  : 1;  // 是否需要使用 sidetable 来存储引用计数
        uintptr_t extra_rc          : 8;  // 引用计数能够用 8 个二进制位存储时，直接存储在这里
    };
    
    // arm64 架构
    struct {
        uintptr_t nonpointer        : 1;  // 0:普通指针，1:优化过，使用位域存储更多信息
        uintptr_t has_assoc         : 1;  // 对象是否含有或曾经含有关联引用
        uintptr_t has_cxx_dtor      : 1;  // 表示是否有C++析构函数或OC的dealloc
        uintptr_t shiftcls          : 33; // 存放着 Class、Meta-Class 对象的内存地址信息
        uintptr_t magic             : 6;  // 用于在调试时分辨对象是否未完成初始化
        uintptr_t weakly_referenced : 1;  // 是否被弱引用指向
        uintptr_t deallocating      : 1;  // 对象是否正在释放
        uintptr_t has_sidetable_rc  : 1;  // 是否需要使用 sidetable 来存储引用计数
        uintptr_t extra_rc          : 19;  // 引用计数能够用 19 个二进制位存储时，直接存储在这里
    };
    ```
    这里的 has_sidetable_rc 和 extra_rc，has_sidetable_rc 表明该指针是否引用了 sidetable 散列表，之所以有这个选项，是因为少量的引用计数是不会直接存放在 SideTables 表中的，对象的引用计数会先存放在 extra_rc 中，当其被存满时，才会存入相应的 SideTables 散列表中，SideTables 中有很多张 SideTable，每个 SideTable 也都是一个散列表，而引用计数表就包含在 SideTable 之中。
    
- 散列表（引用计数表、弱引用表）
    
    引用计数要么存放在 isa 的 extra_rc 中，要么存放在引用计数表中，而引用计数表包含在一个叫 SideTable 的结构中，它是一个散列表，也就是哈希表。而 SideTable 又包含在一个全局的 StripeMap 的哈希映射表中，这个表的名字叫 SideTables。
    
    当一个对象访问 SideTables 时：
    
    - 首先会取得对象的地址，将地址进行哈希运算，与 SideTables 中 SideTable 的个数取余，最后得到的结果就是该对象所要访问的 SideTable
        
    - 在取得的 SideTable 中的 RefcountMap 表中再进行一次哈希查找，找到该对象在引用计数表中对应的位置
        
    - 如果该位置存在对应的引用计数，则对其进行操作，如果没有对应的引用计数，则创建一个对应的 size_t 对象，其实就是一个 uint 类型的无符号整型
        
    弱引用表也是一张哈希表的结构，其内部包含了每个对象对应的弱引用表 weak_entry_t，而 weak_entry_t 是一个结构体数组，其中包含的则是每一个对象弱引用的对象所对应的弱引用指针。

## 11.循环引用

循环引用的实质：多个对象相互之间有强引用，不能释放让系统回收。

如何解决循环引用？

1、避免产生循环引用，通常是将 strong 引用改为 weak 引用。 比如在修饰属性时用weak 在block内调用对象方法时，使用其弱引用，这里可以使用两个宏

#define WS(weakSelf)            __weak __typeof(&*self)weakSelf = self; // 弱引用

#define ST(strongSelf)          __strong __typeof(&*self)strongSelf = weakSelf; //使用这个要先声明weakSelf
还可以使用__block来修饰变量 在MRC下，__block不会增加其引用计数，避免了循环引用 在ARC下，__block修饰对象会被强引用，无法避免循环引用，需要手动解除。

2、在合适时机去手动断开循环引用。 通常我们使用第一种。

- 代理(delegate)循环引用属于相互循环引用

    delegate 是iOS中开发中比较常遇到的循环引用，一般在声明delegate的时候都要使用弱引用 weak,或者assign,当然怎么选择使用assign还是weak，MRC的话只能用assign，在ARC的情况下最好使用weak，因为weak修饰的变量在释放后自动指向nil，防止野指针存在

- NSTimer循环引用属于相互循环使用

    在控制器内，创建NSTimer作为其属性，由于定时器创建后也会强引用该控制器对象，那么该对象和定时器就相互循环引用了。 如何解决呢？ 这里我们可以使用手动断开循环引用： 如果是不重复定时器，在回调方法里将定时器invalidate并置为nil即可。 如果是重复定时器，在合适的位置将其invalidate并置为nil即可

3、block循环引用

一个简单的例子：

``` c
@property (copy, nonatomic) dispatch_block_t myBlock;
@property (copy, nonatomic) NSString *blockString;

- (void)testBlock {
    self.myBlock = ^() {
        NSLog(@"%@",self.blockString);
    };
}
```

由于block会对block中的对象进行持有操作,就相当于持有了其中的对象，而如果此时block中的对象又持有了该block，则会造成循环引用。 解决方案就是使用__weak修饰self即可

``` c
__weak typeof(self) weakSelf = self;

self.myBlock = ^() {
        NSLog(@"%@",weakSelf.blockString);
 };
 ```

并不是所有block都会造成循环引用。 只有被强引用了的block才会产生循环引用 而比如dispatch_async(dispatch_get_main_queue(), ^{}),[UIView animateWithDuration:1 animations:^{}]这些系统方法等 或者block并不是其属性而是临时变量,即栈block

``` c
[self testWithBlock:^{
    NSLog(@"%@",self);
}];

- (void)testWithBlock:(dispatch_block_t)block {
    block();
}
```
还有一种场景，在block执行开始时self对象还未被释放，而执行过程中，self被释放了，由于是用weak修饰的，那么weakSelf也被释放了，此时在block里访问weakSelf时，就可能会发生错误(向nil对象发消息并不会崩溃，但也没任何效果)。 对于这种场景，应该在block中对 对象使用__strong修饰，使得在block期间对 对象持有，block执行结束后，解除其持有。

``` c
__weak typeof(self) weakSelf = self;

self.myBlock = ^() {

        __strong __typeof(self) strongSelf = weakSelf;

        [strongSelf test];
 };
```


# 图像处理
## 1.图像的压缩方式
- 压缩图片质量
    
    一般情况下使用UIImageJPEGRepresentation或UIImagePNGRepresentation方法实现。

- 压缩图片尺寸
    
    一般通过指定压缩的大小对图像进行重绘

## 2.如何计算图片加载内存中所占的大小

图片内存大小的计算公式 宽度 * 高度 * bytesPerPixel/8。

bytesPerPixel : 每个像素所占的字节数。

RGBA颜色空间下 每个颜色分量由32位组成

所以一般图片的计算公式是 wxhx4 


# Foundation
## 1.nil、NIL、NSNULL 有什么区别？

- nil、NIL 可以说是等价的，都代表内存中一块空地址。

- NSNULL 代表一个指向 nil 的对象。

## 2.如何实现一个线程安全的 NSMutableArray? 

NSMutableArray是线程不安全的，当有多个线程同时对数组进行操作的时候可能导致崩溃或数据错误

- 线程锁：使用线程锁对数组读写时进行加锁

- 派发队列：在《Effective Objective-C 2.0..》书中第41条：多用派发队列，少用同步锁中指出：使用“串行同步队列”（serial synchronization queue），将读取操作及写入操作都安排在同一个队列里，即可保证数据同步。而通过并发队列，结合GCD的栅栏块（barrier）来不仅实现数据同步线程安全，还比串行同步队列方式更高效。

## 3.atomic 修饰的属性是绝对安全的吗？为什么？

不是，所谓的安全只是局限于 Setter、Getter 的访问器方法而言的，你对它做 Release 的操作是不会受影响的。这个时候就容易崩溃了。

## 4.实现 isEqual 和 hash 方法时要注意什么？

- hash
    
    对关键属性的hash值进行位或运算作为hash值

- isEqual
    
    ==运算符判断是否是同一对象, 因为同一对象必然完全相同

    判断是否是同一类型, 这样不仅可以提高判等的效率, 还可以避免隐式类型转换带来的潜在风险

    判断对象是否是nil, 做参数有效性检查

    各个属性分别使用默认判等方法进行判断

    返回所有属性判等的与结果

## 5.id 和 instanceType 有什么区别？

- 相同点
    
    instancetype 和 id 都是万能指针，指向对象。

- 不同点：

    1.id 在编译的时候不能判断对象的真实类型，instancetype 在编译的时候可以判断对象的真实类型。

    2.id 可以用来定义变量，可以作为返回值类型，可以作为形参类型；instancetype 只能作为返回值类型。


## 6.self和super的区别

- self调用自己方法，super调用父类方法

- self是类，super是预编译指令

- [self class] 和 [super class] 输出是一样的

- self和super底层实现原理

    1.当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；

    而当使用 super 时，则从父类的方法列表中开始找，然后调用父类的这个方法

    2.当使用 self 调用时，会使用 objc_msgSend 函数：

    ``` c
    id objc_msgSend(id theReceiver, SEL theSelector, ...)
    ```

    第一个参数是消息接收者，第二个参数是调用的具体类方法的 selector，后面是 selector 方法的可变参数。以 [self setName:] 为例，编译器会替换成调用 objc_msgSend 的函数调用，其中 theReceiver 是 self，theSelector 是 @selector(setName:)，这个 selector 是从当前 self 的 class 的方法列表开始找的 setName，当找到后把对应的 selector 传递过去。

    3.当使用 super 调用时，会使用 objc_msgSendSuper 函数：

    ``` c
    id objc_msgSendSuper(struct objc_super *super, SEL op, ...)
    ```

    第一个参数是个objc_super的结构体，第二个参数还是类似上面的类方法的selector

    ``` c
    struct objc_super {
          id receiver;
          Class superClass;
    };
    ```

## 7.@synthesize和@dynamic分别有什么作用？

- @property有两个对应的词，一个是 @synthesize，一个是 @dynamic。如果 @synthesize和 @dynamic都没写，那么默认的就是@syntheszie var = _var;

- @synthesize 的语义是如果你没有手动实现 setter 方法和 getter 方法，那么编译器会自动为你加上这两个方法。

- @dynamic 告诉编译器：属性的 setter 与 getter 方法由用户自己实现，不自动生成。（当然对于 readonly 的属性只需提供 getter 即可）。假如一个属性被声明为 @dynamic var，然后你没有提供 @setter方法和 @getter 方法，编译的时候没问题，但是当程序运行到 instance.var = someVar，由于缺 setter 方法会导致程序崩溃；或者当运行到 someVar = var 时，由于缺 getter 方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。

## 8.typeof 和 __typeof，__typeof__ 的区别?

- __typeof __() 和 __typeof() 是 C语言 的编译器特定扩展，因为标准 C 不包含这样的运算符。 标准 C 要求编译器用双下划线前缀语言扩展（这也是为什么你不应该为自己的函数，变量等做这些）

- typeof() 与前两者完全相同的，只不过去掉了下划线，同时现代的编译器也可以理解。

所以这三个意思是相同的，但没有一个是标准C，不同的编译器会按需选择符合标准的写法。

## 9.类族

系统框架中有许多类簇，大部分collection类都是类族。例如NSArray与其可变版本NSMutableArray。这样看来实际上有两个抽象基类，一个用于不可变数组，一个用于可变数组。尽管具备公共接口的类有两个，但任然可以合起来算一个类族。不可变的类定义了对所有数组都通用的方法，而可变类则定义了那些只适用于可变数组的方法。两个类共同属于同一个类族，这意味着二者在实现各自类型的数组时可以共用实现代码，此外还能把可变数组复制成不可变数组，反之亦然。

## 10.struct和class的区别

- 类： 引用类型（位于栈上面的指针（引用）和位于堆上的实体对象）

- 结构：值类型（实例直接位于栈中）


# 设计模式
## 1.iOS有哪些常见的设计模式?

- 单例模式：单例保证了应用程序的生命周期内仅有一个该类的实例对象,而且易于外界访问.在ios sdk中,UIApplication, NSBundle, NSNotificationCenter, NSFileManager, NSUserDefault, NSURLCache等都是单例.

- 委托模式：委托Delegate是协议的一种,通过@protocol方式实现，常见的有tableView，textField等。

- 观察者模式：观察者模式定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。在iOS中,观察者模式的具体实现有两种: 通知机制(notification)和KVO机制(Key-value Observing)

## 2.单例会有什么弊端？

- 主要优点：

    1、提供了对唯一实例的受控访问。

    2、由于在系统内存中只存在一个对象，因此可以节约系统资源，对于一些需要频繁创建和销毁的对象单例模式无疑可以提高系统的性能。

    3、允许可变数目的实例。

- 主要缺点：

    1、由于单利模式中没有抽象层，因此单例类的扩展有很大的困难。

    2、单例类的职责过重，在一定程度上违背了“单一职责原则”。

    3、滥用单例将带来一些负面问题，如为了节省资源将数据库连接池对象设计为的单例类，可能会导致共享连接池对象的程序过多而出现连接池溢出；如果实例化的对象长时间不被利用，系统会认为是垃圾而被回收，这将导致对象状态的丢失。

## 3.编程中的六大设计原则？

- 1.单一职责原则
    
    通俗地讲就是一个类只做一件事

    CALayer：动画和视图的显示。

    UIView：只负责事件传递、事件响应。

- 2.开闭原则

    对修改关闭，对扩展开放。 要考虑到后续的扩展性，而不是在原有的基础上来回修改

- 3.接口隔离原则
    
    使用多个专门的协议、而不是一个庞大臃肿的协议，如 UITableviewDelegate + UITableViewDataSource

- 4.依赖倒置原则

    抽象不应该依赖于具体实现、具体实现可以依赖于抽象。 调用接口感觉不到内部是如何操作的

- 5.里氏替换原则
    
    父类可以被子类无缝替换，且原有的功能不受任何影响 如：KVO

- 6.迪米特法则

    一个对象应当对其他对象尽可能少的了解，实现高聚合、低耦合


# 调试技巧

## 1.LLDB常用的调试命令？

- po：print object的缩写，表示显示对象的文本描述，如果对象不存在则打印nil。

- p：可以用来打印基本数据类型。

- call：执行一段代码 如：call NSLog(@"%@", @"yang")

- expr：动态执行指定表达式

- bt：打印当前线程堆栈信息 （bt all 打印所有线程堆栈信息）

- image：常用来寻找栈地址对应代码位置 如：image lookup --address 0xxxx

## 2.断点调试

- 条件断点

    打上断点之后，对断点进行编辑，设置相应过滤条件。下面简单的介绍一下条件设置：

    Condition：返回一个布尔值，当布尔值为真触发断点，一般里面我们可以写一个表达式。

    Ignore：忽略前N次断点，到N+1次再触发断点。

    Action：断点触发事件，分为六种：

    - AppleScript：执行脚本。

    - Capture GPU Frame：用于OpenGL ES调试，捕获断点处GPU当前绘制帧。

    - Debugger Command：和控制台中输入LLDB调试命令一致。

    - Log Message：输出自定义格式信息至控制台。

    - Shell Command：接收命令文件及相应参数列表，Shell Command是异步执行的，只有勾选“Wait until done”才会等待Shell命令执行完在执行调试。

    - Sound：断点触发时播放声音。

    Options(Automatically continue after evaluating actions选项)：选中后，表示断点不会终止程序的运行。

- 异常断点

    异常断点可以快速定位不满足特定条件的异常，比如常见的数组越界，这时候很难通过异常信息定位到错误所在位置。这个时候异常断点就可以发挥作用了。

    Exception：可以选择抛出异常对象类型：OC或C++。

    Break：选择断点接收的抛出异常来源是Throw还是Catch语句。

- 符号断点

    符号断点的创建方式和异常断点一样一样的，在符号断点中可以指定要中断执行的方法：

    Symbol:[类名 方法名]可以执行到指定类的指定方法中开始断点。

## 3.iOS 常见的崩溃类型有哪些？

- unrecognized selector crash

- KVO crash

- NSNotification crash

- NSTimer crash

- Container crash

- NSString crash

- Bad Access crash （野指针）

- UI not on Main Thread Crash



# 数据结构

## 1.数据结构的存储一般常用的有几种？各有什么特点？

数据结构的存储一般常用的有两种 顺序存储结构 和 链式存储结构

- 顺序存储结构: 

    比如，数组，1-2-3-4-5-6-7-8-9-10，存储是按顺序的。再比如栈和队列等

- 链式存储结构: 

    比如，数组，1-2-3-4-5-6-7-8-9-10，链式存储就不一样了 1(地址)-2(地址)-7(地址)-4(地址)-5(地址)-9(地址)-8(地址)-3(地址)-6(地址)-10(地址)。每个数字后面跟着一个地址 而且存储形式不再是顺序 
 
## 2.集合结构 线性结构 树形结构 图形结构
- 集合结构 
    
    一个集合，就是一个圆圈中有很多个元素，元素与元素之间没有任何关系  这个很简单
- 线性结构 

    一个条线上站着很多个人。 这条线不一定是直的。也可以是弯的。也可以是值的 相当于一条线被分成了好几段的样子 （发挥你的想象力）。 线性结构是一对一的关系
- 树形结构 

    做开发的肯定或多或少的知道xml 解析  树形结构跟他非常类似。也可以想象成一个金字塔。树形结构是一对多的关系
- 图形结构 

    这个就比较复杂了。他呢 无穷。无边  无向（没有方向）图形机构 你可以理解为多对多 类似于我们人的交集关系

## 3.单向链表 双向链表 循环链表
- 单向链表 A->B->C->D->E->F->G->H. 这就是单向链表 H 是头 A 是尾 像一个只有一个头的火车一样 只能一个头拉着跑
    ![单向链表](https://qn.nobady.cn/iOS/03-01.png)
- 双向链表
    ![双向链表](https://qn.nobady.cn/iOS/03-02.png)
- 循环链表

    循环链表是与单向链表一样，是一种链式的存储结构，所不同的是，循环链表的最后一个结点的指针是指向该循环链表的第一个结点或者表头结点，从而构成一个环形的链。发挥想象力  A->B->C->D->E->F->G->H->A. 绕成一个圈。就像蛇吃自己的这就是循环  不需要去死记硬背哪些理论知识。
## 4.数组和链表区别
- 数组

    数组元素在内存上连续存放，可以通过下标查找元素；插入、删除需要移动大量元素，比较适用于元素很少变化的情况
- 链表

    链表中的元素在内存中不是顺序存储的，查找慢，插入、删除只需要对元素指针重新赋值，效率高

## 5.堆、栈和队列
#### 堆
- 堆是一种经过排序的树形数据结构，每个节点都有一个值，通常我们所说的堆的数据结构是指二叉树。所以堆在数据结构中通常可以被看做是一棵树的数组对象。而且堆需要满足一下两个性质：
    
    1）堆中某个节点的值总是不大于或不小于其父节点的值；

    2）堆总是一棵完全二叉树。
- 堆分为两种情况，有最大堆和最小堆。将根节点最大的堆叫做最大堆或大根堆，根节点最小的堆叫做最小堆或小根堆，在一个摆放好元素的最小堆中，父结点中的元素一定比子结点的元素要小，但对于左右结点的大小则没有规定谁大谁小。

- 堆常用来实现优先队列，堆的存取是随意的，这就如同我们在图书馆的书架上取书，虽然书的摆放是有顺序的，但是我们想取任意一本时不必像栈一样，先取出前面所有的书，书架这种机制不同于箱子，我们可以直接取出我们想要的书。

#### 栈
- 栈是限定仅在表尾进行插入和删除操作的线性表。我们把允许插入和删除的一端称为栈顶，另一端称为栈底，不含任何数据元素的栈称为空栈。栈的特殊之处在于它限制了这个线性表的插入和删除位置，它始终只在栈顶进行。

- 栈是一种具有后进先出的数据结构，又称为后进先出的线性表，简称 LIFO（Last In First Out）结构。也就是说后存放的先取，先存放的后取，这就类似于我们要在取放在箱子底部的东西（放进去比较早的物体），我们首先要移开压在它上面的物体（放进去比较晚的物体）。

- 堆栈中定义了一些操作。两个最重要的是PUSH和POP。PUSH操作在堆栈的顶部加入一个元素。POP操作相反，在堆栈顶部移去一个元素，并将堆栈的大小减一。

- 栈的应用—递归

#### 队列
- 队列是只允许在一端进行插入操作、而在另一端进行删除操作的线性表。允许插入的一端称为队尾，允许删除的一端称为队头。它是一种特殊的线性表，特殊之处在于它只允许在表的前端进行删除操作，而在表的后端进行插入操作，和栈一样，队列是一种操作受限制的线性表。

- 队列是一种先进先出的数据结构，又称为先进先出的线性表，简称 FIFO（First In First Out）结构。也就是说先放的先取，后放的后取，就如同行李过安检的时候，先放进去的行李在另一端总是先出来，后放入的行李会在最后面出来。

## 6.输入一棵二叉树的根结点，求该树的深度？
二叉树的结点定义如下：
``` c 
struct BinaryTreeNode
{
    int m_nValue ；
    BinaryTreeNode* m_pLeft;
    BinarvTreeNode* m_pRight ；
}
```

- 如果一棵树只有一个结点，它的深度为1。
- 如果根结点只有左子树而没有右子树，那么树的深度应该是其左子树的深度加1；同样如果根结点只有右子树而没有左子树，那么树的深度应该是其右子树的深度加1。
- 如果既有右子树又有左子树，那该树的深度就是其左、右子树深度的较大值再加1。

``` c 
int TreeDepth(TreeNode* pRoot)
{
    if(pRoot == nullptr)
        return 0;
    int left = TreeDepth(pRoot->left);
    int right = TreeDepth(pRoot->right);

    return (left>right) ? (left+1) : (right+1);
}
```

## 7.输入一课二叉树的根结点，判断该树是不是平衡二叉树？
- 重复遍历结点
    
    先求出根结点的左右子树的深度，然后判断它们的深度相差不超过1，如果否，则不是一棵二叉树；如果是，再用同样的方法分别判断左子树和右子树是否为平衡二叉树，如果都是，则这就是一棵平衡二叉树。
- 遍历一遍结点

    遍历结点的同时记录下该结点的深度，避免重复访问。

方法1:
``` c 
struct TreeNode{
    int val;
    TreeNode* left;
    TreeNode* right;
};
 
int TreeDepth(TreeNode* pRoot){
    if(pRoot==NULL)
        return 0;
    int left=TreeDepth(pRoot->left);
    int right=TreeDepth(pRoot->right);
    return left>right?(left+1):(right+1);
}
 
bool IsBalanced(TreeNode* pRoot){
    if(pRoot==NULL)
        return true;
    int left=TreeDepth(pRoot->left);
    int right=TreeDepth(pRoot->right);
    int diff=left-right;
    if(diff>1 || diff<-1)
        return false;
    return IsBalanced(pRoot->left) && IsBalanced(pRoot->right);
}
``` 
方法2：
``` c
bool IsBalanced_1(TreeNode* pRoot,int& depth){
    if(pRoot==NULL){
        depth=0;
        return true;
    }
    int left,right;
    int diff;
    if(IsBalanced_1(pRoot->left,left) && IsBalanced_1(pRoot->right,right)){
        diff=left-right;
        if(diff<=1 || diff>=-1){
            depth=left>right?left+1:right+1;
            return true;
        }
    }
    return false;
}
 
bool IsBalancedTree(TreeNode* pRoot){
    int depth=0;
    return IsBalanced_1(pRoot,depth);
} 
```


# 数据存储
## 1.iOS 开发中数据持久性有哪几种? 

iOS本地数据保存有多种方式,比如NSUserDefaults、归档、文件保存、数据库、CoreData、KeyChain(钥匙串)等多种方式。其中KeyChain(钥匙串)是保存到沙盒范围以外的地方，也就是与沙盒无关。

## 2.FMDB数据结构变化升级
    
- 1.使用columnExists:inTableWithName方法判断数据表中是否存在字段

- 2.如果不存在，则添加, 如：向bbb表中添加aaa字段 -> ALTER TABLE bbb ADD 'aaa' TEXT


# 数据安全及加密
## 1.对称加密和非对称加密的区别？

- 1、对称加密又称公开密钥加密，加密和解密都会用到同一个密钥，如果密钥被攻击者获得，此时加密就失去了意义。常见的对称加密算法有DES、3DES、AES、Blowfish、IDEA、RC5、RC6。

- 2、非对称加密又称共享密钥加密，使用一对非对称的密钥，一把叫做私有密钥，另一把叫做公有密钥；公钥加密只能用私钥来解密，私钥加密只能用公钥来解密。常见的公钥加密算法有：RSA、ElGamal、背包算法、Rabin（RSA的特例）、迪菲－赫尔曼密钥交换协议中的公钥加密算法、椭圆曲线加密算法）。

## 2.简述 SSL 加密的过程用了哪些加密方法，为何这么作？

SSL 加密，在过程中实际使用了 对称加密 和 非对称加密 的结合。主要的考虑是先使用 非对称加密 进行连接，这样做是为了避免中间人攻击秘钥被劫持，但是 非对称加密 的效率比较低。所以一旦建立了安全的连接之后，就可以使用轻量的 对称加密。

## 3.iOS的签名机制是怎么样的

- 签名机制：

    先将应用内容通过摘要算法，得到摘要
    
    再用私钥对摘要进行加密得到密文

    将源文本、密文、和私钥对应的公钥一并发布

- 验证流程：
    
    查看公钥是否是私钥方的
    
    然后用公钥对密文进行解密得到摘要
    
    将APP用同样的摘要算法得到摘要，两个摘要进行比对，如果相等那么一切正常
    


# 持续集成
## 1.你在项目中使用过什么持续集成方式？

- Fastlane：一套用Ruby写的自动化工具集，可用于iOS和Android的打包、发布，节省了大量时间。Fastlane配置比较简单，主要编写集成的lane，然后在命令行操作即可

- Jenkins：Jenkins比较受欢迎，插件众多，但对新手来说配置可能稍微麻烦点。

## 2.jenkins怎么备份恢复

- 只需要拷贝主home下面的 .jenkins打个包，下次要恢复就用这个覆盖，所有的东西就都一模一样了。其实就是配置的东西都在这里面，插件的话有个Plugin的文件夹下面就是所有的插件的东西。

## 3.jenkins你都用了哪些插件？

- Keychains and Provisioning Profiles Management：管理本地的keychain和iOS证书的插件

- Xcode integration：用于xcode构建

- GIT plugin/SVN：代码管理插件



# 组件化

## 1.组件化有什么好处？

- 业务分层、解耦，使代码变得可维护；

- 有效的拆分、组织日益庞大的工程代码，使工程目录变得可维护；

- 便于各业务功能拆分、抽离，实现真正的功能复用；

- 业务隔离，跨团队开发代码控制和版本风险控制的实现；

- 模块化对代码的封装性、合理性都有一定的要求，提升开发同学的设计能力；

- 在维护好各级组件的情况下，随意组合满足不同客户需求；（只需要将之前的多个业务组件模块在新的主App中进行组装即可快速迭代出下一个全新App）

## 2.你是如何组件化解耦的？

- 分层

    基础功能组件：按功能分库，不涉及产品业务需求，跟库Library类似，通过良好的接口拱上层业务组件调用；不写入产品定制逻辑，通过扩展接口完成定制；
    
    基础UI组件：各个业务模块依赖使用，但需要保持好定制扩展的设计
    
    业务组件：业务功能间相对独立，相互间没有Model共享的依赖；业务之间的页面调用只能通过UIBus进行跳转；业务之间的逻辑Action调用只能通过服务提供；

- 中间件：target-action，url-block，protocol-class

## 3.为什么CTMediator方案优于基于Router的方案？

Router的缺点：

- 在组件化的实施过程中，注册URL并不是充分必要条件。组件是不需要向组件管理器注册URL的，注册了URL之后，会造成不必要的内存常驻。注册URL的目的其实是一个服务发现的过程，在iOS领域中，服务发现的方式是不需要通过主动注册的，使用runtime就可以了。另外，注册部分的代码的维护是一个相对麻烦的事情，每一次支持新调用时，都要去维护一次注册列表。如果有调用被弃用了，是经常会忘记删项目的。runtime由于不存在注册过程，那就也不会产生维护的操作，维护成本就降低了。 由于通过runtime做到了服务的自动发现，拓展调用接口的任务就仅在于各自的模块，任何一次新接口添加，新业务添加，都不必去主工程做操作，十分透明。

- 在iOS领域里，一定是组件化的中间件为openURL提供服务，而不是openURL方式为组件化提供服务。如果在给App实施组件化方案的过程中是基于openURL的方案的话，有一个致命缺陷：非常规对象(不能被字符串化到URL中的对象，例如UIImage)无法参与本地组件间调度。
在本地调用中使用URL的方式其实是不必要的，如果业务工程师在本地间调度时需要给出URL，那么就不可避免要提供params，在调用时要提供哪些params是业务工程师很容易懵逼的地方。

- 为了支持传递非常规参数，蘑菇街的方案采用了protocol，这个会侵入业务。由于业务中的某个对象需要被调用，因此必须要符合某个可被调用的protocol，然而这个protocol又不存在于当前业务领域，于是当前业务就不得不依赖public Protocol。这对于将来的业务迁移是有非常大的影响的。

CTMediator的优点：

- 调用时，区分了本地应用调用和远程应用调用。本地应用调用为远程应用调用提供服务。

- 组件仅通过Action暴露可调用接口，模块与模块之间的接口被固化在了Target-Action这一层，避免了实施组件化的改造过程中，对Business的侵入，同时也提高了组件化接口的可维护性。

- 方便传递各种类型的参数。

## 4.基于CTMediator的组件化方案，有哪些核心组成？

- CTMediator中间件：集成就可以了

- 模块Target_%@：模块的实现及提供对外的方法调用Action_methodName，需要传参数时，都统一以NSDictionary*的形式传入。

- CTMediator+%@扩展：扩展里声明了模块业务的对外接口，参数明确，这样外部调用者可以很容易理解如何调用接口。


# 代码管理
## 1.SVN与Git优缺点比较

1．SVN优缺点

- 优点： 
    
    1、管理方便，逻辑明确，符合一般人思维习惯。 

    2、易于管理，集中式服务器更能保证安全性。 

    3、代码一致性非常高。 

    4、 适合开发人数不多的项目开发。 

- 缺点： 

    1、服务器压力太大，数据库容量暴增。 

    2、如果不能连接到服务器上，基本上不可以工作，看上面第二步，如果服务器不能连接上，就不能提交，还原，对比等等。 

    3、不适合开源开发（开发人数非常非常多，但是Google app engine就是用svn的）。但是一般集中式管理的有非常明确的权限管理机制（例如分支访问限制），可以实现分层管理，从而很好的解决开发人数众多的问题。

2．Git优缺点

- 优点： 

    1、适合分布式开发，强调个体。 

    2、公共服务器压力和数据量都不会太大。 

    3、速度快、灵活。 

    4、任意两个开发者之间可以很容易的解决冲突。 

    5、离线工作。 

- 缺点： 
    
    1、学习周期相对而言比较长。 

    2、不符合常规思维。 

    3、代码保密性差，一旦开发者把整个库克隆下来就可以完全公开所有代码和版本信息。

## 2.Git与SVN的区别

- 1、Git是分布式的，而SVN不是分布式的

- 2、Git把内容按元数据方式存储，而SVN是按文件

- 3、Git没有一个全局版本号，SVN有，目前为止这是SVN相比Git缺少的最大的一个特征

- 4、Git的内容的完整性要优于SVN: GIT的内容存储使用的是SHA-1哈希算法。这能确保代码内容的完整性，确保在遇到磁盘故障和网络问题时降低对版本库的破坏

- 5、Git下载下来后，在OffLine状态下可以看到所有的Log,SVN不可以

- 6、SVN必须先Update才能Commit,忘记了合并时就会出现一些错误，git还是比较少的出现这种情况

- 7、克隆一份全新的目录以同样拥有五个分支来说，SVN是同时复製5个版本的文件,也就是说重复五次同样的动作。而Git只是获取文件的每个版本的 元素，然后只载入主要的分支(master)在我的经验,克隆一个拥有将近一万个提交(commit),五个分支,每个分支有大约1500个文件的 SVN,耗了将近一个小时！而Git只用了区区的1分钟

- 8、版本库（repository):SVN只能有一个指定中央版本库。当这个中央版本库有问题时，所有工作成员都一起瘫痪直到版本库维修完毕或者新的版本库设立完成。而 Git可以有无限个版本库。或者，更正确的说法，每一个Git都是一个版本库，区别是它们是否拥有活跃目录（Git Working Tree）。如果主要版本库（例如：置於GitHub的版本库）发生了什麼事，工作成员仍然可以在自己的本地版本库（local repository）提交，等待主要版本库恢复即可。工作成员也可以提交到其他的版本库

- 9、分支（Branch）在SVN，分支是一个完整的目录。且这个目录拥有完整的实际文件。如果工作成员想要开啟新的分支，那将会影响“全世界”！每个人都会拥有和你一样的分支。如果你的分支是用来进行破坏工作（安检测试），那将会像传染病一样,你改一个分支，还得让其他人重新切分支重新下载，十分狗血。而 Git，每个工作成员可以任意在自己的本地版本库开啟无限个分支。举例：当我想尝试破坏自己的程序（安检测试），并且想保留这些被修改的文件供日后使用， 我可以开一个分支，做我喜欢的事。完全不需担心妨碍其他工作成员。只要我不合并及提交到主要版本库，没有一个工作成员会被影响。等到我不需要这个分支时， 我只要把它从我的本地版本库删除即可。无痛无痒。

    Git的分支名是可以使用不同名字的。例如：我的本地分支名为OK，而在主要版本库的名字其实是master。

    最值得一提，我可以在Git的任意一个提交点（commit point）开启分支！（其中一个方法是使用gitk –all 可观察整个提交记录，然后在任意点开啟分支。）

- 10、提交（Commit）在SVN，当你提交你的完成品时，它将直接记录到中央版本库。当你发现你的完成品存在严重问题时，你已经无法阻止事情的发生了。如果网路中断，你根本没办法提交！而Git的提交完全属於本地版本库的活动。而你只需“推”（git push）到主要版本库即可。Git的“推”其实是在执行“同步”（Sync）


# 动画
## 1.UIView动画与核心动画的区别? 

- 核心动画只作用在layer. 
- 核心动画修改的值都是假像.它的真实位置没有发生变化.
- 当需要与用户进行交互时用UIView动画,不需要与用户进行交互时两个都可以.

## 2.当我们要做一些基于 CALayer 的动画时，有时需要设置 layer 的锚点来配合动画，这时候我们需要注意什么？

- 需要注意的是设置锚点会引起原来 position 的变化，可能会发生不符合预期的行为，所以要做一下转化，示例代码如下：
    
    ``` c 
    // 为 layer 的动画设置不同的 anchor point，但是又不想改变 view 原来的 position，则需要做一些转换。
    - (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
        // 分别计算原来锚点和将更新的锚点对应的坐标点，这些坐标点是相对该 view 内部坐标系的。
        CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                       view.bounds.size.height * view.layer.anchorPoint.y);
        CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                       view.bounds.size.height * anchorPoint.y);
        
        // 如果当前 view 有做过 transform，这里要同步计算。
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
        
        // position 是当前 view 的 anchor point 在其父 view 的位置。
        CGPoint position = view.layer.position;
        // anchor point 的改变会造成 position 的改变，从而影响 view 在其父 view 的位置，这里把这个位移给计算回来。
        position.x = position.x + newPoint.x - oldPoint.x;
        position.y = position.y + newPoint.y - oldPoint.y;
        
        view.translatesAutoresizingMaskIntoConstraints = YES;
        view.layer.anchorPoint = anchorPoint; // 设置了新的 anchor point 会改变位置。
        view.layer.position = position; // 通过在 position 上做逆向偏移，把位置给移回来。
    }

```


# 算法

## 1.时间复杂度

- 时间频度

    一个算法执行所耗费的时间,从理论上是不能算出来的,必须上机运行测试才能知道.但我们不可能也没有必要对每个算法都上机测试,只需知道哪个算法花费的时间多,哪个算法花费的时间少就可以了.并且一个算法花费的时间与算法中语句的执行次数成正比例,哪个算法中语句执行次数多,它花费时间就多.一个算法中的语句执行次数称为语句频度或时间频度.记为T(n).

- 时间复杂度

    一般情况下,算法中基本操作重复执行的次数是问题规模n的某个函数,用T(n)表示,若有某个辅助函数f(n),使得当n趋近于无穷大时,T（n)/f(n)的极限值为不等于零的常数,则称f(n)是T(n)的同数量级函数.记作T(n)=O(f(n)),称O(f(n)) 为算法的渐进时间复杂度,简称时间复杂度.

- 在各种不同算法中,若算法中语句执行次数为一个常数,则时间复杂度为O(1),另外,在时间频度不相同时,时间复杂度有可能相同,如T(n)=n2+3n+4与T(n)=4n2+2n+1它们的频度不同,但时间复杂度相同,都为O(n2).

- 按数量级递增排列,常见的时间复杂度有：
    
    O(1)称为常量级，算法的时间复杂度是一个常数。

    O(n)称为线性级，时间复杂度是数据量n的线性函数。

    O(n²)称为平方级，与数据量n的二次多项式函数属于同一数量级。

    O(n³)称为立方级，是n的三次多项式函数。

    O(logn)称为对数级，是n的对数函数。

    O(nlogn)称为介于线性级和平方级之间的一种数量级

    O(2ⁿ)称为指数级，与数据量n的指数函数是一个数量级。

    O(n!)称为阶乘级，与数据量n的阶乘是一个数量级。

    它们之间的关系是： O(1)<O(logn)<O(n)<O(nlogn)<O(n²)<O(n³)<O(2ⁿ)<O(n!)，随着问题规模n的不断增大,上述时间复杂度不断增大,算法的执行效率越低.

 
## 2.空间复杂度

- 评估执行程序所需的存储空间。可以估算出程序对计算机内存的使用程度。不包括算法程序代码和所处理的数据本身所占空间部分。通常用所使用额外空间的字节数表示。其算法比较简单，记为S(n)=O(f(n))，其中，n表示问题规模。
    
## 3.常用的排序算法

- 选择排序、冒泡排序、插入排序三种排序算法可以总结为如下：
 
    都将数组分为已排序部分和未排序部分。

    选择排序将已排序部分定义在左端，然后选择未排序部分的最小元素和未排序部分的第一个元素交换。

    冒泡排序将已排序部分定义在右端，在遍历未排序部分的过程执行交换，将最大元素交换到最右端。

    插入排序将已排序部分定义在左端，将未排序部分元的第一个元素插入到已排序部分合适的位置。

``` c 
/** 
 *    【选择排序】：最值出现在起始端
 *    
 *    第1趟：在n个数中找到最小(大)数与第一个数交换位置
 *    第2趟：在剩下n-1个数中找到最小(大)数与第二个数交换位置
 *    重复这样的操作...依次与第三个、第四个...数交换位置
 *    第n-1趟，最终可实现数据的升序（降序）排列。
 *
 */
void selectSort(int *arr, int length) {
    for (int i = 0; i < length - 1; i++) { //趟数
        for (int j = i + 1; j < length; j++) { //比较次数
            if (arr[i] > arr[j]) {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
}
 
/** 
 *    【冒泡排序】：相邻元素两两比较，比较完一趟，最值出现在末尾
 *    第1趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第n个元素位置
 *    第2趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第n-1个元素位置
 *     ……   ……
 *    第n-1趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第2个元素位置    
 */
void bublleSort(int *arr, int length) {
    for(int i = 0; i < length - 1; i++) { //趟数
        for(int j = 0; j < length - i - 1; j++) { //比较次数
            if(arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        } 
    }
}
 
/**
 *    折半查找：优化查找时间（不用遍历全部数据）
 *
 *    折半查找的原理：
 *   1> 数组必须是有序的
 *   2> 必须已知min和max（知道范围）
 *   3> 动态计算mid的值，取出mid对应的值进行比较
 *   4> 如果mid对应的值大于要查找的值，那么max要变小为mid-1
 *   5> 如果mid对应的值小于要查找的值，那么min要变大为mid+1
 *
 */ 
 
// 已知一个有序数组, 和一个key, 要求从数组中找到key对应的索引位置 
int findKey(int *arr, int length, int key) {
    int min = 0, max = length - 1, mid;
    while (min <= max) {
        mid = (min + max) / 2; //计算中间值
        if (key > arr[mid]) {
            min = mid + 1;
        } else if (key < arr[mid]) {
            max = mid - 1;
        } else {
            return mid;
        }
    }
    return -1;
}
```
## 4.字符串反转
``` c 
void char_reverse (char *cha) {

    // 定义头部指针
    char *begin = cha;
    // 定义尾部指针
    char *end = cha + strlen(cha) -1;
    
    
    while (begin < end) {
        
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}
``` 

## 5.链表反转（头差法）
.h声明文件
``` c 
#import <Foundation/Foundation.h>

// 定义一个链表
struct Node {
    int data;
    struct Node *next;
};

@interface ReverseList : NSObject

// 链表反转
struct Node* reverseList(struct Node *head);

// 构造一个链表
struct Node* constructList(void);

// 打印链表中的数据
void printList(struct Node *head);

@end
```
.m实现文件
``` c 
#import "ReverseList.h"

@implementation ReverseList

struct Node* reverseList(struct Node *head)
{
    // 定义遍历指针，初始化为头结点
    struct Node *p = head;
    
    // 反转后的链表头部
    struct Node *newH = NULL;
    
    // 遍历链表
    while (p != NULL) {
        
        // 记录下一个结点
        struct Node *temp = p->next;
        // 当前结点的next指向新链表头部
        p->next = newH;
        // 更改新链表头部为当前结点
        newH = p;
        // 移动p指针
        p = temp;
    }
    
    // 返回反转后的链表头结点
    return newH;
}

struct Node* constructList(void)
{
    // 头结点定义
    struct Node *head = NULL;
    // 记录当前尾结点
    struct Node *cur = NULL;
    
    for (int i = 1; i < 5; i++) {
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        
        // 头结点为空，新结点即为头结点
        if (head == NULL) {
            head = node;
        }
        // 当前结点的next为新结点
        else{
            cur->next = node;
        }
        
        // 设置当前结点为新结点
        cur = node;
    }
    
    return head;
}

void printList(struct Node *head)
{
    struct Node* temp = head;
    while (temp != NULL) {
        printf("node is %d \n", temp->data);
        temp = temp->next;
    }
}

@end
```

## 6.有序数组合并

.h声明文件
``` c 
#import <Foundation/Foundation.h>

@interface MergeSortedList : NSObject
// 将有序数组a和b的值合并到一个数组result当中，且仍然保持有序
void mergeList(int a[], int aLen, int b[], int bLen, int result[]);

@end
```
.m实现文件
``` c 
#import "MergeSortedList.h"

@implementation MergeSortedList

void mergeList(int a[], int aLen, int b[], int bLen, int result[])
{
    int p = 0; // 遍历数组a的指针
    int q = 0; // 遍历数组b的指针
    int i = 0; // 记录当前存储位置
    
    // 任一数组没有到达边界则进行遍历
    while (p < aLen && q < bLen) {
        // 如果a数组对应位置的值小于b数组对应位置的值
        if (a[p] <= b[q]) {
            // 存储a数组的值
            result[i] = a[p];
            // 移动a数组的遍历指针
            p++;
        }
        else{
            // 存储b数组的值
            result[i] = b[q];
            // 移动b数组的遍历指针
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余
    while (p < aLen) {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = a[p++];
        i++;
    }
    
    // 如果b数组有剩余
    while (q < bLen) {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = b[q++];
        i++;
    }
}

@end
```

## 7.查找第一个只出现一次的字符（Hash查找）

.h声明文件

``` c 
#import <Foundation/Foundation.h>

@interface HashFind : NSObject

// 查找第一个只出现一次的字符
char findFirstChar(char* cha);

@end

```
.m实现文件

``` c 
#import "HashFind.h"

@implementation HashFind

char findFirstChar(char* cha)
{
    char result = '\0';
    
    // 定义一个数组 用来存储各个字母出现次数
    int array[256];
    
    // 对数组进行初始化操作
    for (int i=0; i<256; i++) {
        array[i] =0;
    }
    // 定义一个指针 指向当前字符串头部
    char* p = cha;
    // 遍历每个字符
    while (*p != '\0') {
        // 在字母对应存储位置 进行出现次数+1操作
        array[*(p++)]++;
    }
    
    // 将P指针重新指向字符串头部
    p = cha;
    // 遍历每个字母的出现次数
    while (*p != '\0') {
        // 遇到第一个出现次数为1的字符，打印结果
        if (array[*p] == 1)
        {
            result = *p;
            break;
        }
        // 反之继续向后遍历
        p++;
    }
    
    return result;
}

@end

```

## 8.查找两个子视图的共同父视图

.h声明文件
``` c
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonSuperFind : NSObject

// 查找两个视图的共同父视图
- (NSArray<UIView *> *)findCommonSuperView:(UIView *)view other:(UIView *)viewOther;

@end
```
.m实现文件
``` c
#import "CommonSuperFind.h"

@implementation CommonSuperFind

- (NSArray <UIView *> *)findCommonSuperView:(UIView *)viewOne other:(UIView *)viewOther
{
    NSMutableArray *result = [NSMutableArray array];
    
    // 查找第一个视图的所有父视图
    NSArray *arrayOne = [self findSuperViews:viewOne];
    // 查找第二个视图的所有父视图
    NSArray *arrayOther = [self findSuperViews:viewOther];
    
    int i = 0;
    // 越界限制条件
    while (i < MIN((int)arrayOne.count, (int)arrayOther.count)) {
        // 倒序方式获取各个视图的父视图
        UIView *superOne = [arrayOne objectAtIndex:arrayOne.count - i - 1];
        UIView *superOther = [arrayOther objectAtIndex:arrayOther.count - i - 1];
        
        // 比较如果相等 则为共同父视图
        if (superOne == superOther) {
            [result addObject:superOne];
            i++;
        }
        // 如果不相等，则结束遍历
        else{
            break;
        }
    }
    
    return result;
}

- (NSArray <UIView *> *)findSuperViews:(UIView *)view
{
    // 初始化为第一父视图
    UIView *temp = view.superview;
    // 保存结果的数组
    NSMutableArray *result = [NSMutableArray array];
    while (temp) {
        [result addObject:temp];
        // 顺着superview指针一直向上查找
        temp = temp.superview;
    }
    return result;
}

@end
```

## 9.无序数组中的中位数(快排思想)

.h声明文件

``` c
#import <Foundation/Foundation.h>

@interface MedianFind : NSObject

// 无序数组中位数查找
int findMedian(int a[], int aLen);

@end

```
``` c
.m实现文件
#import "MedianFind.h"

@implementation MedianFind

//求一个无序数组的中位数
int findMedian(int a[], int aLen)
{
    int low = 0;
    int high = aLen - 1;
    
    int mid = (aLen - 1) / 2;
    int div = PartSort(a, low, high);
    
    while (div != mid)
    {
        if (mid < div)
        {
            //左半区间找
            div = PartSort(a, low, div - 1);
        }
        else
        {
            //右半区间找
            div = PartSort(a, div + 1, high);
        }
    }
    //找到了
    return a[mid];
}

int PartSort(int a[], int start, int end)
{
    int low = start;
    int high = end;
    
    //选取关键字
    int key = a[end];
    
    while (low < high)
    {
        //左边找比key大的值
        while (low < high && a[low] <= key)
        {
            ++low;
        }
        
        //右边找比key小的值
        while (low < high && a[high] >= key)
        {
            --high;
        }
        
        if (low < high)
        {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;
}

@end

```

## 10.给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。

``` c
- (void)viewDidLoad {

    [super viewDidLoad];

    NSArray *oriArray = @[@(2),@(3),@(6),@(7),@(22),@(12)];

    BOOL isHaveNums =  [self twoNumSumWithTarget:9 Array:oriArray];

    NSLog(@"%d",isHaveNums);
}


- (BOOL)twoNumSumWithTarget:(int)target Array:(NSArray<NSNumber *> *)array {
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        for (int j = i + 1; j < array.count; j++) {
            
            if ([array[i] intValue] + [array[j] intValue] == target) {
                
                [finalArray addObject:array[i]];
                [finalArray addObject:array[j]];
                NSLog(@"%@",finalArray);
                
                return YES;
            }
        }
    }
    return NO;
}
```

## XLsn0w's Apple Developer Swift／Objective-C Skills

3.id和NSObject ,instancetype的区别？

类方法中，以alloc或new开头

实例方法中，以autorelease，init，retain或self开头会返回一个方法所在类类型的对象，这些方法就被称为是关联返回类型的方法。换句话说，这些方法的返回结果以方法所在的类为类型。

非关联返回类型 + (id)constructAnArray;  根据Cocoa的方法命名规范，得到的返回类型就和方法声明的返回类型一样，是id。

+ (instancetype)constructAnArray;  得到的返回类型和方法所在类的类型相同，是NSArray*!总结一下，instancetype的作用，就是使那些非关联返回类型的方法返回所在类的类型！

instancetype和id区别 ：

1.id在编译的时候不能判断对象的真实类型instancetype在编译的时候可以判断对象的真实类型

2.如果init方法的返回值是instancetype,那么将返回值赋值给一个其它的对象会报一个警告如果是在以前, init的返回值是id,那么将init返回的对象地址赋值给其它对象是不会报错的

3.id可以用来定义变量, 可以作为返回值, 可以作为形参instancetype只能用于作为返回值

//err,expected a type - (void)setValue:(instancetype)value { //do something } 就是错的，应该写成：- (void)setValue:(id)value { //d

注意：以后但凡自定义构造方法, 返回值尽量使用instancetype, 不要使用id

总结一下，instancetype的作用，就是使那些非关联返回类型的方法返回所在类的类型！

一、关联返回类型（related result types）根据Cocoa的命名规则，满足下述规则的方法：1、类方法中，以alloc或new开头2、实例方法中，以autorelease，init，retain或self开头会返回一个方法所在类类型的对象，这些方法就被称为是关联返回类型的方法。换句话说，这些方法的返回结果以方法所在的类为类型，说的有点绕口，请看下面的例子：

@interface NSObject

＋ (id)alloc;

－ (id)init;

@end

@interface NSArray : NSObject

@end 

当我们使用如下方式初始化NSArray时：NSArray *array = [[NSArray alloc] init];

照Cocoa的命名规则，语句[NSArray alloc] 的类型就是NSArray因为alloc的返回类型属于关联返回类型。同样，[[NSArray alloc]init] 的返回结果也是NSArray。

1.NSObject包含了一些其他的方法，需要实现NSObject协议，可以用NSObject来表示id，但是不能用id来表示NSObject

3.id可以是任何对象，包括不是NSObject的对象

4.定义id的时候不需要*，而定义NSOject的时候需要。

第一种是最常用的，id是个指针，任意类型的指针。它简单地申明了指向对象的指针，没有给编译器任何类型信息

第二种表示使用NSObject静态类型不是所有的Foundation/Cocoa对象都继承息NSObject，比如NSProxy就不从NSObject继承，所以你无法使用NSObject＊指向这个对象，即使NSProxy对象有release和retain这样的通用方法。为了解决这个问题，你需要第3种定义

第三种： id<NSObject>告诉编译器，你不关心对象是什么类型，但它必须遵守NSObject协议(protocol)，编译器就能保证所有赋值给id<NSObject>类型的对象都遵守NSObject协议(protocol)。所以你无法使用NSObject＊指向这个对象，即使NSProxy对象有release和retain这样的通用方法

总结：    1、如果你不需要任何的类型检查，使用id，它经常作为返回类型，也经常用于申明代理(delegate)类型。    2、如果真的需要编译器检查，那你就考虑使用第2种或者第3种。    3、第三种使用协议(protocol)的优点是，它能指向NSProxy对象，而更常用的情况是，你只想知道某个对象遵守了哪个协议，而不用关心它是什么类型。

4.使用kvo什么时候移除监听（dealloc不能移除的情况）？

一般KVO奔溃的原因:

被观察的对象销毁掉了(被观察的对象是一个局部变量)

观察者被释放掉了,但是没有移除监听(如模态推出,push,pop等)

注册的监听没有移除掉,又重新注册了一遍监听

触发回调方法(这儿需要注意一点,在Person.m文件中如果赋值没有通过setter方法或者是kvc,例如(_name = name)这个时候不会触发kvc的回调方法,也就是说赋值必须得通过setter方法或者KVC赋值,才会触发回调方法)

当观察者不需要监听时，可以调用removeObserver:forKeyPath:方法将KVO移除。需要注意的是，调用removeObserver需要在观察者消失之前，否则会导致Crash。

直接修改成员变量会触发KVO么？不会触发KVO因为，触发KVO是因为，执行set方法时候，调用 willChangeValueForKey didChangeValueForKey 但是直接修改成员变量不会调用set方法

5.block里面会不会存在self为空的情况（weak strong的原理）？

1.block 内部创建的强引用，block 是不会持有它的，block 只持有外部的强应用

值得注意的是，在ARC下__block会导致对象被retain，有可能导致循环引用。而在MRC下，则不会retain这个对象，也不会导致循环引用

如果是在MRC模式下，使用__block修饰self,则此时block访问被释放的self，则会导致crash。

在MRC环境下，__block根本不会对指针所指向的对象执行copy操作，而只是把指针进行的复制。而这一点往往是很多新手&老手所不知道的！

而在ARC环境下，对于声明为__block的外部对象，在block内部会进行retain，以至于在block环境内能安全的引用外部对象，所以要谨防循环引用的问题！

- (void)testBlockRetainCycle { ClassA* objA = [[ClassA alloc] init];

__weak typeof(objA) weakObjA = objA; s

elf.myBlock = ^() {

__strong typeof(weakObjA) strongWeakObjA = weakObjA;

[strongWeakObjA doSomething]; };

objA.objA = self; }

注：此方法只能保证在block执行期间对象不被释放，如果对象在block执行执行之前已经被释放了，该方法也无效。

6.什么是动态连接库？

7.NSNull和nil的区别？

nil：指向一个对象的空指针    Nil：指向一个类的空指针,   

NULL：指向其他类型（如：基本类型、C类型）的空指针, 用于对非对象指针赋空值.

NSNull：在集合对象中，表示空值的对象.

NSNull在Objective-C中是一个类 .NSNull有 + (NSNull *)null; 单例方法.多用于集合(NSArray,NSDictionary)中值为空的对象.

NSArray *array = [NSArray arrayWithObjects: [[NSObject alloc] init], [NSNull null], @"aaa", nil, [[NSObject alloc] init], [[NSObject alloc] init], nil];NSLog(@"%ld", array.count);// 输出 3，NSArray以nil结尾

8.Objective-C类能动态添加成员变量吗？

不能。

因此一并讨论。很多人在学到Category时都会有疑问，既然允许用Category给类增加方法和属性，那为什么不允许增加成员变量？

在Objective-C提供的runtime函数中，确实有一个class_addIvar()函数用于给类添加成员变量，但是文档中特别说明：This function may only be called after objc_allocateClassPair and before objc_registerClassPair. Adding an instance variable to an existing class is not supported.

意思是说，这个函数只能在“构建一个类的过程中”调用。一旦完成类定义，就不能再添加成员变量了。经过编译的类在程序启动后就被runtime加载，没有机会调用addIvar。程序在运行时动态构建的类需要在调用objc_registerClassPair之后才可以被使用，同样没有机会再添加成员变量。


显然，这样做会带来严重问题，为基类动态增加成员变量会导致所有已创建出的子类实例都无法使用。那为什么runtime允许动态添加方法和属性，而不会引发问题呢？

因为方法和属性并不“属于”类实例，而成员变量“属于”类实例。我们所说的“类实例”概念，指的是一块内存区域，包含了isa指针和所有的成员变量。所以假如允许动态修改类成员变量布局，已经创建出的类实例就不符合类定义了，变成了无效对象。但方法定义是在objc_class中管理的，不管如何增删类方法，都不影响类实例的内存布局，已经创建出的类实例仍然可正常使用。
