//
//  GPSClass.h
//  findpoint
//
//  Created by 程嘉雯 on 15/5/31.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol  GPSLocationDelegate

@optional
//没有打开定位功能
-(void)NoOpenLocation;
//更新定位信息
-(void)UpdateLocationInfo:(CLLocation *)location;
@end


@interface GPSClass : NSObject

@end
