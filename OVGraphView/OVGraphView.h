//
//  OVGraphView.h
//  OVGraphView
//
//  Created by Owen Voorhees on 2/2/13.
//  Copyright (c) 2013 Owen Voorhees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVPlotScrollView.h"
@interface OVGraphView : UIView
-(id)initWithFrame:(CGRect)frame ContentSize:(CGSize)size;
-(void)setPoints:(NSArray *)points;

@property(nonatomic)OVPlotScrollView *plotContainer;
@property()BOOL reverse;
@property(nonatomic)UIColor *graphcolor;
@end
