//
//  OVGraphViewPoint.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphViewPoint.h"

@implementation OVGraphViewPoint
-(id)initWithXLabel:(NSString *)x YValue:(NSNumber *)y{
    if (self=[super init]) {
        self.xlabel=x;
        self.yvalue=y;
    }
    return self;
}

@end
