//
//  GDLocation.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "GDLocation.h"

@implementation GDLocation
@synthesize delegate;
static GDLocation *location;

//静态函数获取当前实例
+(instancetype)getInstancet
{
    if (!location)
    {
        location = [[GDLocation alloc] init];
    }
    return location;
}

-(instancetype)init
{
    self = [super init];
    locationmanger = [[AMapLocationManager alloc] init];
    
    [locationmanger setDelegate:self];
    
    [locationmanger setPausesLocationUpdatesAutomatically:NO];
    
    [locationmanger setAllowsBackgroundLocationUpdates:YES];
    
    
    return self;
}


-(void)StartLocation
{
    if (![CLLocationManager locationServicesEnabled])
    {
        if (delegate)
            [delegate NoOpenLocation];
        return;
    }
    [locationmanger startUpdatingLocation];
}

-(void)StopLocation
{
    [locationmanger stopUpdatingLocation];
}




#pragma mark 定位代理

-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"定位信息 %@",location);
    _gpslocation = location;
    _gdlocation = AMapLocationCoordinateConvert(location.coordinate, AMapLocationCoordinateTypeGPS);
    if (delegate)
        [delegate UpdateLocationInfo:_gpslocation];
}

-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //忽略
}
#pragma mark -





@end
