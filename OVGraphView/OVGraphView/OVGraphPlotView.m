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
        dragging=NO;
        [self setBackgroundColor:[UIColor whiteColor]];
       
         }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawYIndicatorAtPointX:(int)x Y:(int)y{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Gradient Declarations
    NSArray* gradient2Colors = [NSArray arrayWithObjects:
                                (id)[UIColor lightGrayColor].CGColor,
                                (id)[UIColor colorWithRed: 0.865 green: 0.865 blue: 0.865 alpha: 1].CGColor,
                                (id)[UIColor whiteColor].CGColor, nil];
    CGFloat gradient2Locations[] = {0, 0.33, 1};
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient2Colors, gradient2Locations);
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, -0.1);
    CGFloat shadowBlurRadius = 2;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0+x, -0+y)];
    [bezierPath addLineToPoint: CGPointMake(0+x, 17+y)];
    [bezierPath addLineToPoint: CGPointMake(12+x, 17+y)];
    [bezierPath addLineToPoint: CGPointMake(20+x, 28+y)];
    [bezierPath addLineToPoint: CGPointMake(28+x, 17+y)];
    [bezierPath addLineToPoint: CGPointMake(40+x, 17+y)];
    [bezierPath addLineToPoint: CGPointMake(40+x, -0+y)];
    [bezierPath addLineToPoint: CGPointMake(0+x, -0+y)];
    [bezierPath closePath];
    bezierPath.miterLimit = 0;
    
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    CGContextSaveGState(context);
    [bezierPath addClip];
    CGContextDrawLinearGradient(context, gradient2, CGPointMake(20+x, -0+y), CGPointMake(20+x, 28+y), 0);
    CGContextRestoreGState(context);
    
    ////// Bezier Inner Shadow
    CGRect bezierBorderRect = CGRectInset([bezierPath bounds], -shadowBlurRadius, -shadowBlurRadius);
    bezierBorderRect = CGRectOffset(bezierBorderRect, -shadowOffset.width, -shadowOffset.height);
    bezierBorderRect = CGRectInset(CGRectUnion(bezierBorderRect, [bezierPath bounds]), -1, -1);
    
    UIBezierPath* bezierNegativePath = [UIBezierPath bezierPathWithRect: bezierBorderRect];
    [bezierNegativePath appendPath: bezierPath];
    bezierNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(bezierBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [bezierPath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(bezierBorderRect.size.width), 0);
        [bezierNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [bezierNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// Cleanup
    CGGradientRelease(gradient2);
    CGColorSpaceRelease(colorSpace);
    

}

- (void)drawRect:(CGRect)rect{
    opaquecolor=self.delegate.graphcolor;
    if (self.delegate.graphcolor==nil) {
        opaquecolor=[UIColor blackColor];
    }
    //calculate colors
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([opaquecolor CGColor]);
	int numComponents = CGColorGetNumberOfComponents([opaquecolor CGColor]);
	CGFloat newComponents[4];
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[0];
			newComponents[2] = oldComponents[0];
			newComponents[3] = 0.2;
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[1];
			newComponents[2] = oldComponents[2];
			newComponents[3] = 0.2;
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	lightercolor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    CGFloat *theoldComponents = (CGFloat *)CGColorGetComponents([opaquecolor CGColor]);
	int thenumComponents = CGColorGetNumberOfComponents([opaquecolor CGColor]);
	CGFloat thenewComponents[4];
    
	switch (thenumComponents)
	{
		case 2:
		{
			//grayscale
			thenewComponents[0] = theoldComponents[0];
			thenewComponents[1] = theoldComponents[0];
			thenewComponents[2] = theoldComponents[0];
			thenewComponents[3] = 0.1;
			break;
		}
		case 4:
		{
			//RGBA
			thenewComponents[0] = theoldComponents[0];
			thenewComponents[1] = theoldComponents[1];
			thenewComponents[2] = theoldComponents[2];
			thenewComponents[3] = 0.1;
			break;
		}
	}
    
	CGColorSpaceRef thecolorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef thenewColor = CGColorCreate(thecolorSpace, thenewComponents);
	CGColorSpaceRelease(thecolorSpace);
    
	lightestcolor= [UIColor colorWithCGColor:thenewColor];
	CGColorRelease(thenewColor);
    
    
    
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColor(context, CGColorGetComponents(opaquecolor.CGColor));
   // CGContextMoveToPoint(context, self.bounds.origin.x+20, self.bounds.size.height-20);
   // CGContextAddLineToPoint(context, 20, 20);
  //  CGContextStrokePath(context);
    
    //draw axis
    CGRect visibleRect;
    UIScrollView *tempsuperview=(UIScrollView *)[self superview];
    visibleRect.origin =tempsuperview.contentOffset;
    visibleRect.size = self.bounds.size;
    
   // CGContextMoveToPoint(context, visiblexcoordinate,0);
    //CGContextAddLineToPoint(context,visiblexcoordinate, self.bounds.size.height-20);
 //   CGContextStrokePath(context);
    
       

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
            CGContextSaveGState(context);
            CGContextSetFillColorWithColor(context, opaquecolor.CGColor);
            CGContextAddEllipseInRect(context,CGRectMake(xpoint,ypoint, 10, 10));
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, xpoint+5, ypoint);
            CGContextAddLineToPoint(context, xpoint+5, self.frame.size.height-20);
            CGContextSetStrokeColorWithColor(context, lightercolor.CGColor);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
            
            [point.xlabel drawAtPoint:CGPointMake(xpoint, self.frame.size.height-20) withFont:[UIFont fontWithName:@"Futura" size:12]];
            int yvalueoffset;
            yvalueoffset=0-30;
            
            
            [self drawYIndicatorAtPointX:xpoint-15 Y:ypoint-30];
            [[point.yvalue stringValue] drawAtPoint:CGPointMake(xpoint,ypoint+yvalueoffset) withFont:[UIFont fontWithName:@"Futura" size:12]];
            if (i!=0) {
                CGContextSaveGState(context);
                CGContextSetStrokeColorWithColor(context, opaquecolor.CGColor);
                CGContextMoveToPoint(context, prevxpoint+5, prevypoint+5);
                CGContextAddLineToPoint(context, xpoint+5, ypoint+5);
                CGContextStrokePath(context);
                CGContextRestoreGState(context);

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
        CGContextSetFillColorWithColor(context, lightestcolor.CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        
               
        
        
    }
}

/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay]; 
}
*/

-(void)setPlotViewPoints:(NSArray *)points Reversed:(BOOL)reversebool{
    if (reversebool) {
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
