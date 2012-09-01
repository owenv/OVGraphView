//
//  OVGraphView.h
//  OVGraphView
//
//  Created by Owen Voorhees on 8/8/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVGraphViewPoint.h"
#import "OVGraphIndicatorView"
@class OVGraphView;
@interface OVGraphPlotView : UIView <UIScrollViewDelegate>{
    int yscale;
    int spacebetweenpoints;
    UIColor *opaquecolor;
    UIColor *lightercolor;
    UIColor *lightestcolor;
    int visiblexcoordinate;
}
-(void)setPlotViewPoints:(NSArray *)points Reversed:(BOOL)reversebool;
@property(nonatomic)NSArray *plotpoints;
@property(nonatomic)OVGraphView *delegate;

@end
