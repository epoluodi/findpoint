//
//  GDLocation.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPSClass.h"






@interface GDLocation : NSObject<AMapLocationManagerDelegate,AMapSearchDelegate>
{
    AMapLocationManager *locationmanger;
    AMapSearchAPI *search;
    
}

@property (assign) BOOL IsLocation;
@property (weak,nonatomic)NSObject<GPSLocationDelegate> *delegate;
@property (copy,nonatomic)CLLocation *GetLocation;
//@property (assign,getter=_gdlocation)CLLocationCoordinate2D GDCoordinate2D;
+(instancetype)getInstancet;

-(instancetype)init;
//开始连续定位
-(void)StartLocation;
//停止连续定位
-(void)StopLocation;
//获得地址搜索信息
-(void)getLocationGeoInfo:(CLLocation *)location;
//单词定位
-(void)SingleLocation;
@end
