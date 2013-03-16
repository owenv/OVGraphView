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
        _yValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 1, 40, 18)];
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    CGFloat fillColorHSBA[4];
    [fillColor getHue: &fillColorHSBA[0] saturation: &fillColorHSBA[1] brightness: &fillColorHSBA[2] alpha: &fillColorHSBA[3]];
    
    UIColor* verylightgray = [UIColor colorWithHue: fillColorHSBA[0] saturation: fillColorHSBA[1] brightness: 0.97 alpha: fillColorHSBA[3]];
    UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Shadow Declarations
    UIColor* shadow2 = strokeColor;
    CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
    CGFloat shadow2BlurRadius = 1.5;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(40, 4)];
    [bezierPath addLineToPoint: CGPointMake(40, 14)];
    [bezierPath addCurveToPoint: CGPointMake(36, 18) controlPoint1: CGPointMake(40, 16.21) controlPoint2: CGPointMake(38.21, 18)];
    [bezierPath addLineToPoint: CGPointMake(24.8, 18)];
    [bezierPath addLineToPoint: CGPointMake(20, 27)];
    [bezierPath addLineToPoint: CGPointMake(15.2, 18)];
    [bezierPath addLineToPoint: CGPointMake(4, 18)];
    [bezierPath addCurveToPoint: CGPointMake(0, 14) controlPoint1: CGPointMake(1.79, 18) controlPoint2: CGPointMake(-0, 16.21)];
    [bezierPath addLineToPoint: CGPointMake(0, 4)];
    [bezierPath addCurveToPoint: CGPointMake(4, 0) controlPoint1: CGPointMake(0, 1.79) controlPoint2: CGPointMake(1.79, 0)];
    [bezierPath addLineToPoint: CGPointMake(36, 0)];
    [bezierPath addCurveToPoint: CGPointMake(40, 4) controlPoint1: CGPointMake(38.21, 0) controlPoint2: CGPointMake(40, 1.79)];
    [bezierPath closePath];
    [verylightgray setFill];
    [bezierPath fill];
    
    ////// Bezier Inner Shadow
    CGRect bezierBorderRect = CGRectInset([bezierPath bounds], -shadow2BlurRadius, -shadow2BlurRadius);
    bezierBorderRect = CGRectOffset(bezierBorderRect, -shadow2Offset.width, -shadow2Offset.height);
    bezierBorderRect = CGRectInset(CGRectUnion(bezierBorderRect, [bezierPath bounds]), -1, -1);
    
    UIBezierPath* bezierNegativePath = [UIBezierPath bezierPathWithRect: bezierBorderRect];
    [bezierNegativePath appendPath: bezierPath];
    bezierNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadow2Offset.width + round(bezierBorderRect.size.width);
        CGFloat yOffset = shadow2Offset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadow2BlurRadius,
                                    shadow2.CGColor);
        
        [bezierPath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(bezierBorderRect.size.width), 0);
        [bezierNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [bezierNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    

    

}


@end
