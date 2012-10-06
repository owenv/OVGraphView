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
      //  UIImageView *indicatorimg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graphindicator2"]];
        
       // [indicatorimg setFrame:frame];

     //   [self addSubview:indicatorimg];
       self.backgroundColor=[UIColor clearColor];
        self.opaque=NO;
        _valuelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/8)];
        [_valuelabel setFont:[UIFont fontWithName:@"Futura" size:24]];
        [_valuelabel setTextAlignment:UITextAlignmentCenter];
        [_valuelabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_valuelabel];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 0.79 green: 0.79 blue: 0.79 alpha: 1];
    UIColor* lmrBlue = [UIColor colorWithRed: 0.31 green: 0.73 blue: 0.78 alpha: 1];
    
    //// Gradient Declarations
    NSArray* indicatorgradientColors = [NSArray arrayWithObjects:
                                        (id)gradientColor.CGColor,
                                        (id)[UIColor colorWithRed: 0.9 green: 0.9 blue: 0.9 alpha: 1].CGColor,
                                        (id)[UIColor whiteColor].CGColor, nil];
    CGFloat indicatorgradientLocations[] = {0, 0.88, 1};
    CGGradientRef indicatorgradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)indicatorgradientColors, indicatorgradientLocations);
    
    //// Shadow Declarations
    UIColor* subtleshadow = [UIColor lightGrayColor];
    CGSize subtleshadowOffset = CGSizeMake(1, 1);
    CGFloat subtleshadowBlurRadius = 1;
    
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 5, 40, 25) cornerRadius: 4];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, subtleshadowOffset, subtleshadowBlurRadius, subtleshadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, indicatorgradient, CGPointMake(20, 5), CGPointMake(20, 30), 0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(19, 31, 2, 250)];
    [lmrBlue setFill];
    [rectanglePath fill];
    
    
    //// Cleanup
    CGGradientRelease(indicatorgradient);
    CGColorSpaceRelease(colorSpace);}


@end
