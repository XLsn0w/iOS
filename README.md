# XLsn0wAppleDeveloper
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
