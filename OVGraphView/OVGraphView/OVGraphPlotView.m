//
//  OVGraphView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/8/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphPlotView.h"

@implementation OVGraphPlotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
         }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);

    CGContextMoveToPoint(context, self.bounds.origin.x+20, self.bounds.size.height-20);
    CGContextAddLineToPoint(context, 20, 20);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.origin.x+20, self.bounds.size.height-20);
    CGContextAddLineToPoint(context, self.bounds.size.width-20, self.bounds.size.height-20);
    CGContextStrokePath(context);
}


@end
