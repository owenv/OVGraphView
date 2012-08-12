//
//  OVGraphView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphView.h"



@implementation OVGraphView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame ContentSize:(CGSize)size{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentSize:size];
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        OVGraphPlotView *plotview=[[OVGraphPlotView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [self addSubview:plotview];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
}
@end