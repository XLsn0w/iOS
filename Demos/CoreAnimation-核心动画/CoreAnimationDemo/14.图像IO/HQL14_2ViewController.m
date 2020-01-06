//
//  HQL14_2ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL14_2ViewController.h"

@interface HQL14_2ViewController () <UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *imagePaths;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation HQL14_2ViewController

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
    
    //tag imageview with index and clear current image
    // 将视图的 tag 值设置为列表索引
    imageView.tag = indexPath.row;
    imageView.image = nil;
    
    // 通过 GCD 切换到后台线程执行「加载图片步骤」，然后切换回主线程执行「显示图片步骤」
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        //load image
        NSInteger index = indexPath.row;
        NSString *imagePath = self.imagePaths[index];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        //set image on main thread, but only if index still matches up
        // 当索引相同时，切换到主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (index == imageView.tag)
            {
                imageView.image = image;
            }
        });
    });
    
    return cell;
}

@end

/*
 当运行更新后的版本，性能比之前不用线程的版本好多了，但仍然并不完美（图 14.3）。

 我们可以看到 +imageWithContentsOfFile: 方法并不在 CPU 时间轨迹的最顶部，所以我们的确修复了延迟加载的问题。
 问题在于我们假设传送器的性能瓶颈在于图片文件的加载，但实际上并不是这样。加载图片数据到内存中只是问题的第一部分。
 
 */
