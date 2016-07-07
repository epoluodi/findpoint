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
#import "CustomerPointAnnotaton.h"

@interface MapViewController : UIViewController<GPSLocationDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MAMapViewDelegate>
{
    CLLocation *_location;
    NSTimer *timer1;//上传GPS
    AMapReGeocode *_geocode;
    BOOL isrun;
    
    //UI
    UIButton *btnloc,*btnrefresh ;
    UIButton *channelname;
    NSDictionary *groupinfo;
    UIView *controlview;
    UIButton *btngb,*btnmeet,*btnlen;
    UIButton *btnchannel;
    UIVisualEffectView *effectview;
    UIPickerView *pickview;
    UITextField *customtext;
    UIButton *btnok,*btnno;
    NSTimer *timer2;
    CustomerPointAnnotaton *meetingAnnotaton;
    __block NSMutableArray<NSString *>* devicelist;
    __block id _self;
   
    __block NSMutableDictionary<NSString *,CustomerPointAnnotaton  *>*marklist;
}

@property (weak, nonatomic) IBOutlet MAMapView *map;
@property (weak,nonatomic)NSString *channelid;

-(void)delmeetingmark;

@end
