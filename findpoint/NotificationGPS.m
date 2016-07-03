//
//  NotificationGPS.m
//  findpoint
//
//  Created by 程嘉雯 on 16/7/3.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "NotificationGPS.h"
#import "info.h"

@implementation NotificationGPS


-(void)sendpush:(NSString *)deviceid
{


    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQ, ^{
        WebService *web = [[WebService alloc] initUrl:sendPush];
        NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
        NSString*nickname = [userinfo stringForKey:@"nickname"];
        if (nickname && ![nickname isEqualToString:@""])
            [web sendpush:deviceid msg:[NSString stringWithFormat:@"%@:已经收到，尽快到达集合点",nickname] msgtype:@""];
      
    });

}

//更新GPS
-(void)updateGPS:(CLLocation *)loc
{
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSDictionary *d =[[NSDictionary alloc] initWithObjectsAndKeys:
                      [info getInstancent].uid,@"deviceid",
                      @(loc.coordinate.latitude),@"lat",
                      @(loc.coordinate.longitude),@"lng",
                      @(loc.speed),@"speed",
                      @(loc.altitude),@"altitude",
                      @"",@"addr",
                      @"",@"city",
                      @"",@"province",nil];
    dispatch_async(globalQ, ^{
        WebService *web = [[WebService alloc] initUrl:SubmitGPS];
        
        [web SubmitGPSInfo:d];
        
    });
    
    
}


//更新GPS
-(void)updateGPS:(CLLocation*)_location geocode:(AMapLocationReGeocode *)_geocode
{
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSDictionary *d =[[NSDictionary alloc] initWithObjectsAndKeys:
                      [info getInstancent].uid,@"deviceid",
                      @(_location.coordinate.latitude),@"lat",
                      @(_location.coordinate.longitude),@"lng",
                      @(_location.speed),@"speed",
                      @(_location.altitude),@"altitude",
                      [NSString stringWithFormat:@"%@%@%@",
                       _geocode.district,
                       _geocode.street,
                       _geocode.number],@"addr",
                      _geocode.city,@"city",
                      _geocode.province,@"province",nil];
    dispatch_async(globalQ, ^{
        WebService *web = [[WebService alloc] initUrl:SubmitGPS];
        
        [web SubmitGPSInfo:d];
        
    });
}





@end
