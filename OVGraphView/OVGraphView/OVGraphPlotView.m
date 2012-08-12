//
//  OVGraphView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/8/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphPlotView.h"
#import "OVGraphView.h"
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

   // CGContextMoveToPoint(context, self.bounds.origin.x+20, self.bounds.size.height-20);
   // CGContextAddLineToPoint(context, 20, 20);
  //  CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.origin.x, self.bounds.size.height-20);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height-20);
    CGContextStrokePath(context);
    int prevxpoint=0;
    int prevypoint=0;
    int i=0;
    if (_plotpoints!=nil) {
        for (OVGraphViewPoint *point in _plotpoints) {
            int xpoint;
            int ypoint;
            xpoint=(spacebetweenpoints*i);
            ypoint=self.frame.size.height-(([point.yvalue intValue]*yscale)+yscale);
          //  NSLog(@"x:%d",xpoint);
          //  NSLog(@"y:%d",ypoint);
           // NSLog(@"%d%d",spacebetweenpoints,yscale);
            CGContextAddEllipseInRect(context,CGRectMake(xpoint,ypoint, 10, 10));
            CGContextFillPath(context);

            
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, xpoint+5, ypoint);
            CGContextAddLineToPoint(context, xpoint+5, self.frame.size.height-20);
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.0 alpha:0.2].CGColor);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
            
            [point.xlabel drawAtPoint:CGPointMake(xpoint, self.frame.size.height-20) withFont:[UIFont fontWithName:@"Futura" size:12]];
            
            if (i!=0) {
                CGContextMoveToPoint(context, prevxpoint+5, prevypoint+5);
                CGContextAddLineToPoint(context, xpoint+5, ypoint+5);
                CGContextStrokePath(context);

            }
            prevxpoint=xpoint;
            prevypoint=ypoint;
            i++;
        }
        
        CGContextSaveGState(context);
        OVGraphViewPoint *first=[_plotpoints objectAtIndex:0];
        CGContextMoveToPoint(context, 0,self.frame.size.height-(([first.yvalue intValue]*yscale)+yscale)+5 );
        CGContextAddLineToPoint(context, 0, self.frame.size.height-(([first.yvalue intValue]*yscale)+yscale)+5);
        int f=0;
        for (OVGraphViewPoint *thepoint in _plotpoints) {
            if (f!=0) {
                CGContextAddLineToPoint(context, (spacebetweenpoints*f)+5, self.frame.size.height-(([thepoint.yvalue intValue]*yscale)+yscale)+5);
                if (f==[_plotpoints count]-1) {
                    CGContextAddLineToPoint(context,(spacebetweenpoints*f)+5 , self.frame.size.height-20);
                    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height-20);
                }
                
            }
            f++;
        }
        
        
        CGContextAddLineToPoint(context, self.frame.size.width, 0);
        CGContextAddLineToPoint(context, 0, 0);

        CGContextClosePath(context);
        CGContextAddRect(context, CGContextGetClipBoundingBox(context));
        CGContextEOClip(context);
        CGContextAddRect(context, CGContextGetClipBoundingBox(context));
        CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.0 alpha:0.1].CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
}
-(void)setPlotViewPoints:(NSArray *)points{
    if ([_delegate shouldreverse]) {
        self.plotpoints=[[points reverseObjectEnumerator]allObjects];
    }else{
        self.plotpoints=points;
    }
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
