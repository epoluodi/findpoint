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
    
    
    search = [[AMapSearchAPI alloc] init];
    search.delegate = self;
    
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
//    NSLog(@"定位信息 %@",location);
    _GetLocation = location;
//    _gdlocation = AMapLocationCoordinateConvert(location.coordinate, AMapLocationCoordinateTypeGPS);
    
    
    
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(UpdateLocationInfo:)])
            [delegate UpdateLocationInfo:location];
    }
}

-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //忽略
}
#pragma mark -

#pragma mark 搜索地址

-(void)getLocationGeoInfo:(CLLocation *)location
{
    [self searchReGeocodeWithCoordinate:location.coordinate];
}

-(void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = NO;
    
    [search AMapReGoecodeSearch:regeo];
}



-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil )
    {
        [delegate updateReGeoInfo:response.regeocode];
    }
 
}
#pragma mark -

@end
