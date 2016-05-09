//
//  GDLocation.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "GPSClass.h"





@interface GDLocation : NSObject<AMapLocationManagerDelegate>
{
    AMapLocationManager *locationmanger;
    CLLocation *_gpslocation;
    CLLocationCoordinate2D _gdlocation;
    
}


@property (weak,nonatomic)NSObject<GPSLocationDelegate> *delegate;
@property (weak,nonatomic,getter=_gpslocation)CLLocation *GetLocation;
@property (assign,getter=_gdlocation)CLLocationCoordinate2D GDCoordinate2D;
+(instancetype)getInstancet;

-(instancetype)init;
//开始连续定位
-(void)StartLocation;
//停止连续定位
-(void)StopLocation;
@end
