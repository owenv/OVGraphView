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
        indicator=[[OVGraphIndicatorView alloc]initWithFrame:CGRectMake(self.bounds.size.width-240, 0, 40,self.bounds.size.height)];
        [self addSubview:indicator];
         }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *thetouch=[[touches allObjects]objectAtIndex:0];
    if (CGRectContainsPoint(indicator.frame, [thetouch locationInView:self])) {
        dragging=YES;
        visiblexcoordinate=[thetouch locationInView:self].x;

 [UIView animateWithDuration:0.5 animations:^{[indicator setFrame:CGRectMake(visiblexcoordinate-20, 0, 40, self.bounds.size.height)];}];
       // visiblexcoordinate=[thetouch locationInView:self].x;
        //[indicator setFrame:CGRectMake(visiblexcoordinate, 0, 40, self.bounds.size.height)];
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    dragging=NO;
    [continuousscrolltimer invalidate];
    continuousscrolltimer=nil;
    [oppcontinuousscrolltimer invalidate];
    oppcontinuousscrolltimer=nil;
    scrollrate=0;
    [self setNeedsDisplay];

      }
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    dragging=NO;
    [continuousscrolltimer invalidate];
    continuousscrolltimer=nil;
    [oppcontinuousscrolltimer invalidate];
    oppcontinuousscrolltimer=nil;
    scrollrate=0;
    [self setNeedsDisplay];

   }
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *thetouch=[[touches allObjects]objectAtIndex:0];
    visiblexcoordinate=[thetouch locationInView:self].x;
    if (dragging) {
        [indicator setFrame:CGRectMake(visiblexcoordinate-20, 0, 40, self.bounds.size.height)];
       
    }
    CGRect visibleRect;
    UIScrollView *tempsuperview=(UIScrollView *)[self superview];
    visibleRect.origin =tempsuperview.contentOffset;
    visibleRect.size = self.bounds.size;
    int locinsuper=[thetouch locationInView:tempsuperview].x;

    if (locinsuper-tempsuperview.contentOffset.x<tempsuperview.frame.size.width/4) {
       
        if (continuousscrolltimer==nil) {
            scrollrate=20;
        continuousscrolltimer=[NSTimer scheduledTimerWithTimeInterval:.45 target:self selector:@selector(scrollleft) userInfo:nil repeats:YES];
        }
        }else{
        [continuousscrolltimer invalidate];
        continuousscrolltimer=nil;
        }
    
    
    
    
    if (locinsuper-tempsuperview.contentOffset.x>(tempsuperview.frame.size.width/4)*3) {
       
        if (oppcontinuousscrolltimer==nil) {
            scrollrate=20;
            oppcontinuousscrolltimer=[NSTimer scheduledTimerWithTimeInterval:0.45 target:self selector:@selector(scrollright) userInfo:nil repeats:YES];
        }

    }else{
        [oppcontinuousscrolltimer invalidate];
        oppcontinuousscrolltimer=nil;

    }

    [self setNeedsDisplay];
 
}
-(void)scrollleft{
    CGRect visibleRect;
    UIScrollView *tempsuperview=(UIScrollView *)[self superview];
    if (tempsuperview.contentOffset.x<5) {
        [continuousscrolltimer invalidate];
        continuousscrolltimer=nil;
        scrollrate=0;

        return;
    }
    if (tempsuperview.contentOffset.x>tempsuperview.contentSize.width) {
        [continuousscrolltimer invalidate];
        continuousscrolltimer=nil;
        scrollrate=0;

        return;
    }
    visibleRect.origin =tempsuperview.contentOffset;
    visibleRect.size = self.bounds.size;
        
   // [tempsuperview setContentOffset:CGPointMake(tempsuperview.contentOffset.x-5, 0) animated:NO];
    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear) animations:^{    [tempsuperview setContentOffset:CGPointMake(tempsuperview.contentOffset.x-scrollrate, 0) animated:NO];
        [indicator setFrame:CGRectMake(indicator.frame.origin.x-scrollrate, 0, 40, self.bounds.size.height)];

    } completion:NULL];
    scrollrate=scrollrate+5;
    if (tempsuperview.contentOffset.x<0) {
        [tempsuperview setContentOffset:CGPointMake(0, 0)];
    }
}
-(void)scrollright{
    CGRect visibleRect;
    UIScrollView *tempsuperview=(UIScrollView *)[self superview];
    if (tempsuperview.contentOffset.x<0) {
        [oppcontinuousscrolltimer invalidate];
        oppcontinuousscrolltimer=nil;
        scrollrate=0;

        return;
    }
    if (tempsuperview.contentOffset.x>tempsuperview.contentSize.width-tempsuperview.frame.size.width) {
        [oppcontinuousscrolltimer invalidate];
        oppcontinuousscrolltimer=nil;
        scrollrate=0;

        return;
    }
    visibleRect.origin =tempsuperview.contentOffset;
    visibleRect.size = self.bounds.size;
    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear) animations:^{    [tempsuperview setContentOffset:CGPointMake(tempsuperview.contentOffset.x+scrollrate, 0) animated:NO];
        [indicator setFrame:CGRectMake(indicator.frame.origin.x+scrollrate, 0, 40, self.bounds.size.height)];

} completion:NULL];
    scrollrate=scrollrate+5;

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
            int indicatorposition=indicator.frame.origin.x+20;
            int xpoint;
            int ypoint;
            xpoint=(spacebetweenpoints*i);
            
            
            if (abs(indicatorposition-xpoint)<=0.5*spacebetweenpoints) {
                NSString *labelstring=[NSString stringWithFormat:@"%@",point.yvalue];
                indicator.valuelabel.text=labelstring;
               // [labelstring drawAtPoint:CGPointMake(indicator.frame.origin.x, 20) withFont:[UIFont fontWithName:@"Futura" size:12]];
            }
            
            
            
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
