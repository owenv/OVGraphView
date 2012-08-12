//
//  OVGraphViewPoint.h
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OVGraphViewPoint : NSObject

-(id)initWithXValue:(NSNumber *)x YValue:(NSNumber *)y;
-(id)initWithXValue:(NSNumber *)x YValue:(NSNumber *)y XLabel:(NSString *)labelx YLabel:(NSString *)labely;

@property(nonatomic)NSNumber *xvalue;
@property(nonatomic)NSNumber *yvalue;
@property(nonatomic)NSString *xlabel;
@property(nonatomic)NSString *ylabel;
@end
