//
//  OVGraphView.h
//  OVGraphView
//
//  Created by Owen Voorhees on 8/8/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVGraphViewPoint.h"
@interface OVGraphPlotView : UIView{
    int yscale;
    int spacebetweenpoints;
}
-(void)setPlotViewPoints:(NSArray *)points;
@property(nonatomic)NSArray *plotpoints;
@end
