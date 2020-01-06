//
//  HQL14_5ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL14_5ViewController.h"

@interface HQL14_5ViewController () <UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *imagePaths;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation HQL14_5ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    //set up data
    self.imagePaths =
        [[NSBundle mainBundle] pathsForResourcesOfType:@"png"
                                           inDirectory:@"Vacation Photos"];
    
    //register cell class
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.imagePaths count];
}

- (UIImage *)loadImageAtIndex:(NSUInteger)index
{
    // 创建缓存，缓存的索引就是 indexPath.item
    static NSCache *cache = nil;
    if (!cache)
    {
        cache = [[NSCache alloc] init];
    }
    
    // 如果缓存中存在，则立即返回缓存中的图片
    // 通过 objectForKey: 方法检索图片
    UIImage *image = [cache objectForKey:@(index)];
    if (image)
    {
        return [image isKindOfClass:[NSNull class]]? nil: image;
    }
    
    // 设置占位符，防止同一张图片被加载多次
    [cache setObject:[NSNull null] forKey:@(index)];
    
    // 切换到后台线程加载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        //load image
        NSString *imagePath = self.imagePaths[index];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        //redraw image using device context
        UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 切换回主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 先缓存图片
            // 通过 setObject: forKey: 方法插入图片
            [cache setObject:image forKey:@(index)];
            
            // 再显示图片
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            UIImageView *imageView = [cell.contentView.subviews lastObject];
            imageView.image = image;
        });
    });
    
    //not loaded yet
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //dequeue cell
    UICollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                  forIndexPath:indexPath];
    
    //add image view
    const NSInteger imageTag = 99;
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:imageTag];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.tag = imageTag;
        [cell.contentView addSubview:imageView];
    }
    
    //set or load image for this index
    imageView.image = [self loadImageAtIndex:indexPath.item];
    
    //preload image for previous and next index
    if (indexPath.item < [self.imagePaths count] - 1)
    {
        [self loadImageAtIndex:indexPath.item + 1];
    }
    if (indexPath.item > 0)
    {
       [self loadImageAtIndex:indexPath.item - 1];
    }
    
    return cell;
}

@end
