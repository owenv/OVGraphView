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
    
    UIColor* lmrBlue = [UIColor colorWithRed: 0.31 green: 0.73 blue: 0.78 alpha: 1];

    //// Color Declarations
    UIColor* graphIndicator = [UIColor colorWithRed: 0.873 green: 0.146 blue: 0.08 alpha: 1];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(19, 37, 8, 227)];
    [graphIndicator setFill];
    [rectanglePath fill];
    
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(9.5, 4.5, 27, 27)];
    [graphIndicator setFill];
    [ovalPath fill];
    
    
    //// Polygon Drawing
    UIBezierPath* polygonPath = [UIBezierPath bezierPath];
    [polygonPath moveToPoint: CGPointMake(23, 44.5)];
    [polygonPath addLineToPoint: CGPointMake(11.31, 24.25)];
    [polygonPath addLineToPoint: CGPointMake(34.69, 24.25)];
    [polygonPath closePath];
    [graphIndicator setFill];
    [polygonPath fill];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(9.5, 266.5, 27, 27)];
    [graphIndicator setFill];
    [oval2Path fill];
    
    
    //// Polygon 2 Drawing
    UIBezierPath* polygon2Path = [UIBezierPath bezierPath];
    [polygon2Path moveToPoint: CGPointMake(23, 252.5)];
    [polygon2Path addLineToPoint: CGPointMake(11.31, 272.75)];
    [polygon2Path addLineToPoint: CGPointMake(34.69, 272.75)];
    [polygon2Path closePath];
    [graphIndicator setFill];
    [polygon2Path fill];
    
    

    
    
}

@end
