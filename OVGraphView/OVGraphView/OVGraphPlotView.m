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
    int i=0;
    if (_plotpoints!=nil) {
        for (OVGraphViewPoint *point in _plotpoints) {
            int xpoint;
            int ypoint;
            xpoint=(spacebetweenpoints*i)+25;
            ypoint=self.frame.size.height-(([point.yvalue intValue]*yscale)+yscale);
          //  NSLog(@"x:%d",xpoint);
          //  NSLog(@"y:%d",ypoint);
           // NSLog(@"%d%d",spacebetweenpoints,yscale);
            CGContextAddEllipseInRect(context,CGRectMake(xpoint,ypoint, 10, 10));
            NSLog(@"%@",point.xlabel);
            i++;
        }
        CGContextFillPath(context);
    }
}
-(void)setPlotViewPoints:(NSArray *)points{
    NSLog(@"setpoints");
    self.plotpoints=[[points reverseObjectEnumerator]allObjects];
    spacebetweenpoints=self.frame.size.width/[points count];
    int d=0;
    for (OVGraphViewPoint *pt in points) {
        if ([pt.yvalue intValue]>d) {
            d=[pt.yvalue intValue];
        }
    }
    yscale=(self.frame.size.height-40)/d;
    [self setNeedsDisplay];
    

}


@end
