//
//  OVGraphViewPoint.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphViewPoint.h"

@implementation OVGraphViewPoint
-(id)initWithXValue:(NSNumber *)x YValue:(NSNumber *)y{
    if (self=[super init]) {
        self.xvalue=x;
        self.yvalue=y;
    }
    return self;
}
-(id)initWithXValue:(NSNumber *)x YValue:(NSNumber *)y XLabel:(NSString *)labelx YLabel:(NSString *)labely{
    if (self=[super init]) {
        self.xvalue=x;
        self.yvalue=y;
        self.xlabel=labelx;
        self.ylabel=labely;
    }
    return self;
}
@end
