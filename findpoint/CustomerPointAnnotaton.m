//
//  CustomerPointAnnotaton.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/20.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "CustomerPointAnnotaton.h"

@implementation CustomerPointAnnotaton

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

#pragma mark - life cycle

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
        
    }
    return self;
}

-(NSString *)title
{
    return @"111";
}
-(NSString *)subtitle
{
    return @"123213123";
}
@end
