//
//  DrawingView.m
//
//  Created by Nick Lockwood on 27/02/2013.
//  Copyright (c) 2013 Charcoal Design. All rights reserved.
//

#import "DrawingView4.h"
#import <QuartzCore/QuartzCore.h>

#define BRUSH_SIZE 32

@interface DrawingView4 ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation DrawingView4

- (void)awakeFromNib
{
    [super awakeFromNib];
    //create array
    self.strokes = [NSMutableArray array];
    
    self.layer.drawsAsynchronously = YES;
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
    //add brush stroke to array
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
    // ⚠️ 用 -setNeedsDisplayInRect: 来减少不必要的绘制
    //set dirty rect
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}

// 计算需要重绘的区域，而不是直接重绘整个视图
- (CGRect)brushRectForPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE/2,
                      point.y - BRUSH_SIZE/2,
                      BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect
{
    //redraw strokes
    for (NSValue *value in self.strokes)
    {
        //get point
        CGPoint point = [value CGPointValue];
        
        //get brush rect
        CGRect brushRect = [self brushRectForPoint:point];
        
        //only draw brush stroke if it intersects dirty rect
        if (CGRectIntersectsRect(rect, brushRect))
        {
            //draw brush stroke
            [[UIImage imageNamed:@"Chalk"] drawInRect:brushRect];
        }
    }
}

@end
