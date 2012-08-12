//
//  OVGraphView.h
//  OVGraphView
//
//  Created by Owen Voorhees on 8/8/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVGraphPlotView : UIView
-(void)setPlotViewPoints:(NSArray *)points;
@property(nonatomic)NSArray *plotpoints;
@end
