//
//  HQL14_1ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL14_1ViewController.h"

@interface HQL14_1ViewController () <UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *imagePaths;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation HQL14_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取图片数据源路径
    self.imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"png"
                                                         inDirectory:@"Vacation Photos"];
    
    // 注册 Cell 类型
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - UICollectionViewDataSource

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
    
    // 添加图片视图
    const NSInteger imageTag = 99;
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:imageTag];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.tag = imageTag;
        [cell.contentView addSubview:imageView];
    }
    
    // 设置图片
    NSString *imagePath = self.imagePaths[indexPath.row];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    return cell;
}

@end

/*
 传送器中的图片为 800x600 像素的 PNG 格式图片，对 iPhone5 来说，1/60 秒要加载大概 700KB 左右的图片。
 当传送器滚动的时候，图片也在实时加载，于是（预期中的）卡动就发生了。时间分析工具（图 14.2）显示了很多时间都消耗在了 UIImage 的 +imageWithContentsOfFile: 方法中了。很明显，图片加载造成了瓶颈。

 */
