//
//  OVGraphIndicatorView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 9/1/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphIndicatorView.h"
#import "OVGraphPlotView.h"
@implementation OVGraphIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.opaque=NO;
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextStrokePath(context);

    // Drawing code
}


@end
