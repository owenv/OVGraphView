//
//  OVGraphYIndicatorView.m
//  OVGraphView
//
//  Created by Owen Voorhees on 2/2/13.
//  Copyright (c) 2013 Owen Voorhees. All rights reserved.
//

#import "OVGraphYIndicatorView.h"

@implementation OVGraphYIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        _yValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 18)];
        _yValueLabel.font=[UIFont fontWithName:@"Futura" size:12];
        _yValueLabel.textAlignment=UITextAlignmentCenter;
        _yValueLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_yValueLabel];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
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
    [bezierPath moveToPoint: CGPointMake(0, -0)];
    [bezierPath addLineToPoint: CGPointMake(0, 17)];
    [bezierPath addLineToPoint: CGPointMake(12, 17)];
    [bezierPath addLineToPoint: CGPointMake(20, 28)];
    [bezierPath addLineToPoint: CGPointMake(28, 17)];
    [bezierPath addLineToPoint: CGPointMake(40, 17)];
    [bezierPath addLineToPoint: CGPointMake(40, -0)];
    [bezierPath addLineToPoint: CGPointMake(0, -0)];
    [bezierPath closePath];
    bezierPath.miterLimit = 0;
    
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    CGContextSaveGState(context);
    [bezierPath addClip];
    CGContextDrawLinearGradient(context, gradient2, CGPointMake(20, -0), CGPointMake(20, 28), 0);
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


@end
