//
//  HQL6_8ViewController.h
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/19.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQL6_8ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END


/*
 # CATiledLayer
 
 CATiledLayer 为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。
 
 
 
 
 */


// 一个简单的 Mac OS 命令行程序，它用 CATiledLayer 将一个图片裁剪成小图并存储到不同的文件中。
// 将 2048*2048 分辨率的雪人图案裁剪成了 64 个不同的 256*256 的小图
/*
#import <AppKit/AppKit.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //handle incorrect arguments
        if (argc < 2)
        {
            NSLog(@"TileCutter arguments: inputfile");
            return 0;
        }
        
        // 输入文件
        NSString *inputFile = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        
        // 设置裁剪后的图片大小，默认 256*256
        CGFloat tileSize = 256;
        
        // 输出路径
        NSString *outputPath = [inputFile stringByDeletingPathExtension];
        
        // 加载图片
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputFile];
        NSSize size = [image size];
        NSArray *representations = [image representations];
        if ([representations count])
        {
            NSBitmapImageRep *representation = representations[0];
            size.width = [representation pixelsWide];
            size.height = [representation pixelsHigh];
        }
        NSRect rect = NSMakeRect(0.0, 0.0, size.width, size.height);
        CGImageRef imageRef = [image CGImageForProposedRect:&rect context:NULL hints:nil];
        
        // 计算行、列
        NSInteger rows = ceil(size.height / tileSize);
        NSInteger cols = ceil(size.width / tileSize);
        
        // generate tiles 生成瓷砖块
        for (int y = 0; y < rows; ++y)
        {
            for (int x = 0; x < cols; ++x)
            {
                // extract tile image 提取瓷砖图片
                CGRect tileRect = CGRectMake(x*tileSize, y*tileSize, tileSize, tileSize);
                CGImageRef tileImage = CGImageCreateWithImageInRect(imageRef, tileRect);
                
                // convert to jpeg data 转换为 JPEG 格式
                NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithCGImage:tileImage];
                NSData *data = [imageRep representationUsingType:NSJPEGFileType properties:nil];
                CGImageRelease(tileImage);
                
                // save file 保存文件
                NSString *path = [outputPath stringByAppendingFormat:@"_%02i_%02i.jpg", x, y];
                [data writeToFile:path atomically:NO];
            }
        }
    }
    return 0;
}
*/
