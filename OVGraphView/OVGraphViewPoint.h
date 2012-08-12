//
//  OVGraphViewPoint.h
//  OVGraphView
//
//  Created by Owen Voorhees on 8/11/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OVGraphViewPoint : NSObject

-(id)initWithXLabel:(NSString *)x YValue:(NSNumber *)y;

@property(nonatomic)NSNumber *yvalue;
@property(nonatomic)NSString *xlabel;
@end
