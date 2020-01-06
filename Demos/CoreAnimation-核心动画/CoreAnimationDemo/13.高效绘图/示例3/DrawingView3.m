//
//  DrawingView3.m
//
//  Created by Nick Lockwood on 27/02/2013.
//  Copyright (c) 2013 Charcoal Design. All rights reserved.
//

#import "DrawingView3.h"
#import <QuartzCore/QuartzCore.h>

#define BRUSH_SIZE 32

@interface DrawingView3 ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation DrawingView3

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 创建数组
    self.strokes = [NSMutableArray array];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point
{
    // 向数组中添加点坐标，每个点都是一张图片
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
    //needs redraw
    // ⚠️ 直接重绘整个视图，性能开销很大
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //redraw strokes
    for (NSValue *value in self.strokes)
    {
        //get point
        CGPoint point = [value CGPointValue];
        
        //get brush rect
        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2,
                                      point.y - BRUSH_SIZE/2,
                                      BRUSH_SIZE, BRUSH_SIZE);
        
        //draw brush stroke
        [[UIImage imageNamed:@"Chalk"] drawInRect:brushRect];
    }
}

@end

/*
 存在的问题！
 
 这个实现在模拟器上表现还不错，但是在真实设备上就没那么好了。
 问题在于每次手指移动的时候我们就会重绘之前的线刷，即使场景的大部分并没有改变。我们绘制地越多，就会越慢。随着时间的增加每次重绘需要更多的时间，帧数也会下降，如何提高性能呢？
 
 */
