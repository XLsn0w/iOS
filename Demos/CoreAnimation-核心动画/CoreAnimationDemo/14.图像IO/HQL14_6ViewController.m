//
//  HQL14_6ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/27.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL14_6ViewController.h"

// 测试完发现：JPG 图片的“加载速度”全部比 PNG 快。（这边还有个“解压速度”）
//static NSString *const ImageFolder = @"Coast Photos"; // 海岸照片
static NSString *const ImageFolder = @"Gradient Images"; // 渐变图像

@interface HQL14_6ViewController () <UITableViewDataSource>

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation HQL14_6ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = ImageFolder;
    
    //set up image names
    self.items = @[@"2048x1536", @"1024x768", @"512x384",
                   @"256x192", @"128x96", @"64x48", @"32x24"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dequeue cell
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"Cell"];
    }
    
    //set up cell
    NSString *imageName = self.items[indexPath.row];
    cell.textLabel.text = imageName;
    cell.detailTextLabel.text = @"Loading...";
    
    //load image
    [self loadImageAtIndex:indexPath.row];

    return cell;
}

- (void)loadImageAtIndex:(NSUInteger)index
{
    //load on background thread so as not to
    //prevent the UI from updating between runs
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        //setup
        NSString *fileName = self.items[index];
        NSString *pngPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png" inDirectory:ImageFolder];
        NSString *jpgPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"jpg" inDirectory:ImageFolder];

        //load
        NSInteger pngTime = [self loadImageForOneSec:pngPath] * 1000;
        NSInteger jpgTime = [self loadImageForOneSec:jpgPath] * 1000;
        
        //updated UI on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //find table cell and update
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"PNG: %03lims  JPG: %03lims",
                                         (long)pngTime, (long)jpgTime];
        });
    });
}

- (CFTimeInterval)loadImageForOneSec:(NSString *)path
{
    //create drawing context to use for decompression
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    
    //start timing
    NSInteger imagesLoaded = 0;
    CFTimeInterval endTime = 0;
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    while (endTime - startTime < 1)
    {
        //load image
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        //decompress image by drawing it
        [image drawAtPoint:CGPointZero];
        
        //update totals
        imagesLoaded ++;
        endTime = CFAbsoluteTimeGetCurrent();
    }
    
    //close context
    UIGraphicsEndImageContext();
    
    //calculate time per image
    return (endTime - startTime) / imagesLoaded;
}

@end
