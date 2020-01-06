//
//  HQL14_8ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL14_8ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 # JPEG 2000
 
 除了 JPEG 和 PNG 之外，iOS 还支持别的一些格式，例如 TIFF 和 GIF，但是由于他们质量压缩得更厉害，性能比 JPEG 和 PNG 糟糕的多，所以大多数情况并不用考虑。

 但是 iOS 之后，苹果低调添加了对 JPEG 2000 图片格式的支持，所以大多数人并不知道。它甚至并不被 Xcode 很好的支持 - JPEG 2000 图片都没在 Interface Builder 中显示。
 
 但是 JPEG 2000 图片在（设备和模拟器）运行时会有效，而且比 JPEG 质量更好，同样也对透明通道有很好的支持。但是 JPEG 2000 图片在加载和显示图片方面明显要比 PNG 和 JPEG 慢得多，所以对图片大小比运行效率更敏感的时候，使用它是一个不错的选择。
 
 但仍然要对 JPEG 2000 保持关注，因为在后续 iOS 版本说不定就对它的性能做提升，但是在现阶段，混合图片对更小尺寸和质量的文件性能会更好。
 
 # PVRTC
 
 当前市场的每个 iOS 设备都使用了 Imagination Technologies PowerVR 图像芯片作为 GPU。PowerVR 芯片支持一种叫做 PVRTC（PowerVR Texture Compression）的标准图片压缩。
 
 和 iOS 上可用的大多数图片格式不同，PVRTC 不用提前解压就可以被直接绘制到屏幕上。这意味着在加载图片之后不需要有解压操作，所以内存中的图片比其他图片格式大大减少了（这取决于压缩设置，大概只有 1/60 那么大）。
 
 但是 PVRTC 仍然有一些弊端：

 * 尽管加载的时候消耗了更少的 RAM，PVRTC 文件比 JPEG 要大，有时候甚至比 PNG 还要大（这取决于具体内容），因为压缩算法是针对于性能，而不是文件尺寸。
 * PVRTC 必须要是二维正方形，如果源图片不满足这些要求，那必须要在转换成 PVRTC 的时候强制拉伸或者填充空白空间。
 * 质量并不是很好，尤其是透明图片。通常看起来更像严重压缩的 JPEG 文件。
 * PVRTC 不能用 Core Graphics 绘制，也不能在普通的 UIImageView 显示，也不能直接用作图层的内容。你必须要用作 OpenGL 纹理加载 PVRTC 图片，然后映射到一对三角板来在 CAEAGLLayer 或者 GLKView 中显示。
 * 创建一个 OpenGL 纹理来绘制 PVRTC 图片的开销相当昂贵。除非你想把所有图片绘制到一个相同的上下文，不然这完全不能发挥 PVRTC 的优势。
 * PVRTC 使用了一个不对称的压缩算法。尽管它几乎立即解压，但是压缩过程相当漫长。在一个现代快速的桌面 Mac 电脑上，它甚至要消耗一分钟甚至更多来生成一个 PVRTC 大图。因此在 iOS 设备上最好不要实时生成。
 
 如果你愿意使用 OpehGL，而且即使提前生成图片也能忍受得了，那么 PVRTC 将会提供相对于别的可用格式来说非常高效的加载性能。比如，可以在主线程 1/60 秒之内加载并显示一张 2048×2048 的 PVRTC 图片（这已经足够大来填充一个视网膜屏幕的 iPad 了），这就避免了很多使用线程或者缓存等等复杂的技术难度。
 Xcode 包含了一些命令行工具例如 texturetool 来生成 PVRTC 图片，但是用起来很不方便（它存在于 Xcode 应用程序束中），而且很受限制。一个更好的方案就是使用 Imagination Technologies PVRTexTool，可以从 http://www.imgtec.com/powervr/insider/sdkdownloads 免费获得。
 安装了 PVRTexTool 之后，就可以使用如下命令在终端中把一个合适大小的 PNG 图片转换成 PVRTC 文件：
 
 ```
 /Applications/Imagination/PowerVR/GraphicsSDK/PVRTexTool/CL/OSX_x86/PVRTexToolCL -i {input_file_name}.png -o {output_file_name}.pvr -legacypvr -p -f PVRTC1_4 -q pvrtcbest
 ```
 
 如果你对在常规应用中使用 PVRTC 图片很感兴趣的话（例如基于 OpenGL 的游戏），可以参考一下 GLView 的库（https://github.com/nicklockwood/GLView）[⚠️ DEPRECATED]，它提供了一个简单的 GLImageView 类，重新实现了 UIImageView 的各种功能，但同时提供了 PVRTC 图片，而不需要你写任何 OpenGL 代码。
 
 
 */
