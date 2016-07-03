//
//  NotificationGPS.h
//  findpoint
//
//  Created by 程嘉雯 on 16/7/3.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"
#import "GDLocation.h"


@interface NotificationGPS : NSObject
-(void)updateGPS:(CLLocation *)loc;
-(void)updateGPS:(CLLocation*)_location geocode:(AMapReGeocode *)_geocode;
-(void)sendpush:(NSString *)deviceid;
@end
