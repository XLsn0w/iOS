//
//  HQL8_5ViewController.m
//  CoreAnimationDemo
//
//  Created by Qilin Hu on 2019/9/23.
//  Copyright © 2019 Tonintech. All rights reserved.
//

#import "HQL8_5ViewController.h"

@interface HQL8_5ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy, nonatomic) NSArray *images;

@end

@implementation HQL8_5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建图片
    self.images = @[[UIImage imageNamed:@"Anchor"],
                    [UIImage imageNamed:@"Cone"],
                    [UIImage imageNamed:@"Igloo"],
                    [UIImage imageNamed:@"Ship"]];
}

// 1.无动画切换图片
- (IBAction)switchImageWithoutAnimation:(id)sender {
    // 循环切换下一张图片
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
}

// 2.有动画切换图片：淡入淡出效果（kCATransitionFade）
- (IBAction)switchImage:(id)sender {
    
    // 创建一个淡入淡出的过渡动画
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    
    // 将过渡动画添加到图片图层
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    // 循环切换下一张图片
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
}

// 3.自定义动画：使用 UIKit 提供的方法来做过渡动画
- (IBAction)switchImageWithCustomAnimation:(id)sender {
    
    [UIView transitionWithView:self.imageView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
        // 循环切换下一张图片
        UIImage *currentImage = self.imageView.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1) % [self.images count];
        self.imageView.image = self.images[index];
    }
                    completion:nil];
    
}


@end
