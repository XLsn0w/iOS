//
//  HQL14_3ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL14_3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END


/*
 # 延迟解压
 
 一旦图片文件被加载就必须要进行解码，解码过程是一个相当复杂的任务，需要消耗非常长的时间。解码后的图片将同样使用相当大的内存。

 用于加载的 CPU 时间相对于解码来说根据图片格式而不同。
 
 * 对于 PNG 图片来说，加载会比 JPEG 更长，因为文件可能更大，但是解码会相对较快，而且 Xcode 会把 PNG 图片进行解码优化之后引入工程。
 * JPEG 图片更小，加载更快，但是解压的步骤要消耗更长的时间，因为 JPEG 解压算法比基于 zip 的 PNG 算法更加复杂。
 
 当加载图片的时候，iOS 通常会延迟解压图片的时间，直到加载到内存之后。
 这就会在准备绘制图片的时候影响性能，因为需要在绘制之前进行解压（通常是消耗时间的问题所在）。
 
 1. 最简单的方法就是使用 UIImage 的 +imageNamed: 方法避免延时加载。不像 +imageWithContentsOfFile:（和其他别的 UIImage 加载方法），这个方法会在加载图片之后立刻进行解压（就和本章之前我们谈到的好处一样）。问题在于 +imageNamed: 只对从应用资源束中的图片有效，所以对用户生成的图片内容或者是下载的图片就没法使用了。
 
 2. 另一种立刻加载图片的方法就是把它设置成图层内容，或者是 UIImageView 的 image 属性。不幸的是，这又需要在主线程执行，所以不会对性能有所提升。
 
 3. 第三种方式就是绕过 UIKit，像下面这样使用 ImageIO 框架：
 
 ```objc
 NSInteger index = indexPath.row;
 NSURL *imageURL = [NSURL fileURLWithPath:self.imagePaths[index]];
 NSDictionary *options = @{(__bridge id)kCGImageSourceShouldCache: @YES};
 
 CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, NULL);
 CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0,(__bridge CFDictionaryRef)options);
 UIImage *image = [UIImage imageWithCGImage:imageRef];
 CGImageRelease(imageRef);
 CFRelease(source);
 ```
 
 这样就可以使用 kCGImageSourceShouldCache 来创建图片，强制图片立刻解压，然后在图片的生命周期保留解压后的版本。
 
 有两种方式可以为强制解压提前渲染图片：
 1.将图片的一个像素绘制成一个像素大小的 CGContext。这样仍然会解压整张图片，但是绘制本身并没有消耗任何时间。这样的好处在于加载的图片并不会在特定的设备上为绘制做优化，所以可以在任何时间点绘制出来。同样 iOS 也就可以丢弃解压后的图片来节省内存了。
 2.将整张图片绘制到 CGContext 中，丢弃原始的图片，并且用一个从上下文内容中新的图片来代替。这样比绘制单一像素那样需要更加复杂的计算，但是因此产生的图片将会为绘制做优化，而且由于原始压缩图片被抛弃了，iOS 就不能够随时丢弃任何解压后的图片来节省内存了。
     
 需要注意的是:苹果特别推荐了不要使用这些诡计来绕过标准图片解压逻辑（所以也是他们选择用默认处理方式的原因），但是如果你使用很多大图来构建应用，那如果想提升性能，就只能和系统博弈了。
 
 如果不使用 +imageNamed:，那么把整张图片绘制到 CGContext 可能是最佳的方式了。
 尽管你可能认为多余的绘制相较别的解压技术而言性能不是很高，但是新创建的图片（在特定的设备上做过优化）可能比原始图片绘制的更快。
     
 同样，如果想显示图片到比原始尺寸小的容器中，那么一次性在后台线程重新绘制到正确的尺寸会比每次显示的时候都做缩放会更有效（尽管在这个例子中我们加载的图片呈现正确的尺寸，所以不需要多余的优化）。
 如果修改了 -collectionView:cellForItemAtIndexPath: 方法来重绘图片（清单 14.3），你会发现滑动更加平滑。
 
 */
