//
//  OVGraphView.h
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVGraphPlotView.h"
@interface OVPlotScrollView : UIScrollView {
    OVGraphPlotView *plotview;
}

-(id)initWithFrame:(CGRect)frame ContentSize:(CGSize)size;
-(void)setPoints:(NSArray *)points;
-(BOOL)shouldreverse;
-(UIColor *)plotViewColor;
@property(nonatomic)BOOL reverse;
@property(nonatomic)UIColor *graphcolor;
@end
