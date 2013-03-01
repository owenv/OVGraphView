//
//  OVGraphView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVPlotScrollView.h"



@implementation OVPlotScrollView
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
        self.showsHorizontalScrollIndicator=NO;
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        plotview=[[OVGraphPlotView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        plotview.delegate=self;
        self.scrollEnabled=YES;
        self.delegate=plotview;
        [self addSubview:plotview];
        if (_reverse) {
            [self scrollRectToVisible:CGRectMake(self.contentSize.width-20, 0, 20, 20) animated:YES];

        }
    }
    return self;
}
-(BOOL)shouldreverse{
    return _reverse;
}



-(void)setPoints:(NSArray *)points{
    [plotview setPlotViewPoints:points Reversed:_reverse];
    if (_reverse) {
        [self scrollRectToVisible:CGRectMake(self.contentSize.width-20, 0, 20, 20) animated:YES];
        
    }
}
-(UIColor *)plotViewColor{
    return _graphcolor;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    
}
@end