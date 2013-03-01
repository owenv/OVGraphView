//
//  OVGraphView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 2/2/13.
//  Copyright (c) 2013 Owen Voorhees. All rights reserved.
//

#import "OVGraphView.h"

@implementation OVGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame ContentSize:(CGSize)size{
    self = [super initWithFrame:frame];
    if (self) {
        _plotContainer=[[OVPlotScrollView alloc]initWithFrame:frame ContentSize:size];
        [self addSubview:_plotContainer];
    }
    return self;

}
-(void)setPoints:(NSArray *)points{
    [_plotContainer setPoints:points];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
