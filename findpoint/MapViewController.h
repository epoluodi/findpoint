//
//  MapViewController.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/9.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "GDLocation.h"
#import "GroupInfo.h"

@interface MapViewController : UIViewController<GPSLocationDelegate>
{
    CLLocation *_location;
    NSTimer *timer1;//上传GPS
    AMapReGeocode *_geocode;
    BOOL isrun;
    
    //UI
    UIButton *btnloc ;
    UIButton *channelname;
    NSDictionary *groupinfo;
    
    
}

@property (weak, nonatomic) IBOutlet MAMapView *map;
@property (weak,nonatomic)NSString *channelid;


@end
