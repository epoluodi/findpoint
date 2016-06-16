//
//  MapViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/9.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "MapViewController.h"
#import "WebService.h"
#import "info.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize map;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    map.showsCompass=NO;
    map.showsUserLocation=YES;
    map.zoomLevel=17;
    map.userTrackingMode=MAUserTrackingModeFollow;
    map.scaleOrigin = CGPointMake(map.scaleOrigin.x, map.scaleOrigin.y+5);
    [GDLocation getInstancet].delegate=self;
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(updateGPS) userInfo:nil repeats:YES];
    isrun=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isrun){
        [self initUI];
        isrun=YES;
    }
}

//初始化地图控制UI
-(void)initUI{
    
    //定位
    btnloc = [[UIButton alloc] init];
    btnloc.frame=CGRectMake(10,
                        map.frame.size.height -8 -120, 38, 38);
    NSLog(@"%@",NSStringFromCGRect(btnloc.frame));
    [btnloc setImage:[UIImage imageNamed:@"loc"] forState:UIControlStateNormal];
    [btnloc setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [btnloc setImageEdgeInsets:
     UIEdgeInsetsMake(5, 5, 5, 5)];
    btnloc.layer.borderWidth=1.2f;
    btnloc.layer.borderColor = [[UIColor colorWithRed:0.361 green:0.671 blue:0.886 alpha:1.00] CGColor];
    btnloc.layer.cornerRadius=6;
    btnloc.layer.masksToBounds=YES;
    [btnloc addTarget:self action:@selector(Clickbtnloc) forControlEvents:UIControlEventTouchUpInside];
    [map addSubview:btnloc];
    
    channelname = [[UIButton alloc] init];
    [channelname setTitle:@"选择团队" forState:UIControlStateNormal];
    channelname.frame=CGRectMake(16, map.frame.size.height -8 -75, map.frame.size.width-32, 24);
    [channelname setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [channelname setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [map addSubview:channelname];
    
    
    controlview = [[UIView alloc] init];
    controlview.frame=CGRectMake(0, 0, 100, 200);
    controlview.layer.borderWidth=1.2f;
    controlview.layer.borderColor = [[UIColor colorWithRed:0.361 green:0.671 blue:0.886 alpha:1.00] CGColor];
    controlview.layer.cornerRadius=6;
    controlview.layer.masksToBounds=YES;
    [controlview setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [map addSubview:controlview];
    
    
    
    
}

-(void)setChannelid:(NSString *)channelid
{
    _channelid=channelid;
    groupinfo = [[GroupInfo getInstancet] getGroupForGroupid:_channelid];
    NSLog(@"%@",groupinfo);
    
}
//点击定位
-(void)Clickbtnloc
{
    
    [map setCenterCoordinate:_location.coordinate animated:YES];
//    map.userTrackingMode=MAUserTrackingModeFollow;
}

-(void)updateGPS
{
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 
    NSDictionary *d =[[NSDictionary alloc] initWithObjectsAndKeys:
                      [info getInstancent].uid,@"deviceid",
                      @(_location.coordinate.latitude),@"lat",
                      @(_location.coordinate.longitude),@"lng",
                      @(_location.speed),@"speed",
                      @(_location.altitude),@"altitude",
                      [NSString stringWithFormat:@"%@%@%@",
                       _geocode.addressComponent.district,
                       _geocode.addressComponent.streetNumber.street,
                       _geocode.addressComponent.streetNumber.number],@"addr",
                      _geocode.addressComponent.city,@"city",
        _geocode.addressComponent.province,@"province",nil];
    dispatch_async(globalQ, ^{
        WebService *web = [[WebService alloc] initUrl:SubmitGPS];
    
        [web SubmitGPSInfo:d];
        
    });

    
}
-(void)UpdateLocationInfo:(CLLocation *)location
{
    _location= location;
    if (!_geocode)
         [[GDLocation getInstancet] getLocationGeoInfo:_location];
    
}
-(void)updateReGeoInfo:(AMapReGeocode *)GeoCodeInfo
{
    _geocode = GeoCodeInfo;
//    txtsheng.text=GeoCodeInfo.addressComponent.province;
//    txtcity.text = GeoCodeInfo.addressComponent.city;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
