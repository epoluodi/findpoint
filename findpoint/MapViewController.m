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
    NSLog(@"1 %f",map.frame.size.height );
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
    
  
    
    
    controlview = [[UIView alloc] init];
    controlview.frame=CGRectMake(map.frame.size.width-60-10, 30, 60, 220);
    controlview.layer.borderWidth=1.2f;
    controlview.layer.borderColor = [[UIColor colorWithRed:0.361 green:0.671 blue:0.886 alpha:1.00] CGColor];
    controlview.layer.cornerRadius=6;
    controlview.layer.masksToBounds=YES;
    [controlview setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [map addSubview:controlview];
 
    btngb = [[UIButton alloc] init];
    btngb.frame=CGRectMake(10, 10, 40, 60);
    [btngb setImage:[UIImage imageNamed:@"boradcast"] forState:UIControlStateNormal];
    [controlview addSubview:btngb];
    
    btnmeet = [[UIButton alloc] init];
    btnmeet.frame=CGRectMake(10, btngb.frame.origin.y + 60 +10, 40, 60);
    [btnmeet setImage:[UIImage imageNamed:@"meetpoint"] forState:UIControlStateNormal];
    [controlview addSubview:btnmeet];
    
    btnlen = [[UIButton alloc] init];
    btnlen.frame=CGRectMake(10, btnmeet.frame.origin.y + 60 +10, 40, 60);
    [btnlen setImage:[UIImage imageNamed:@"len"] forState:UIControlStateNormal];
    [controlview addSubview:btnlen];
    
    
    btnchannel = [[UIButton alloc] init];
     btnchannel.frame=CGRectMake(map.frame.size.width-60-10, controlview.frame.origin.y + 220 +10, 60, 70);
     [btnchannel setImage:[UIImage imageNamed:@"channel"] forState:UIControlStateNormal];
    [btnchannel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    btnchannel.layer.borderWidth=0.9f;
    btnchannel.layer.borderColor = [[UIColor colorWithRed:0.917f green:0.5f blue:0.062f alpha:1.00] CGColor];
    btnchannel.layer.cornerRadius=6;
    btnchannel.layer.masksToBounds=YES;
    [btnchannel addTarget:self action:@selector(selectchannel) forControlEvents:UIControlEventTouchUpInside];
    [map addSubview:btnchannel];
    
}


//点击选择团队
-(void)selectchannel
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.alpha=0.8f;
    
    effectview.frame =self.tabBarController.view.frame;
    
    pickview =[[UIPickerView alloc] init];
    [pickview setBackgroundColor: [UIColor clearColor]];
    pickview.dataSource=self;
    pickview.delegate=self;
    pickview.frame=CGRectMake(16, effectview.frame.size.height /2 -80, effectview.frame.size.width-32, 190);
    [effectview addSubview:pickview];
    
    btnok=[[UIButton alloc] init];
    [btnok setBackgroundImage:[UIImage imageNamed:@"btnok"] forState:UIControlStateNormal];
    btnok.frame=CGRectMake(effectview.frame.size.width / 2 +36, effectview.frame.size.height-80-60, 60, 60);
    [effectview addSubview:btnok];
    
    
    btnno=[[UIButton alloc] init];
    [btnno setBackgroundImage:[UIImage imageNamed:@"btnno"] forState:UIControlStateNormal];
    btnno.frame=CGRectMake(effectview.frame.size.width / 2 -36 - 60, effectview.frame.size.height-80-60, 60, 60);
    [effectview addSubview:btnno];
    [btnno addTarget:self action:@selector(closeSelectChannelView) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.view addSubview:effectview];
    
}




#pragma mark pickview delegate

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return [[GroupInfo getInstancet] getChannels] ;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *d = [[GroupInfo getInstancet] getGroupForindex:row];
    return [d objectForKey:@"CHNAME"];
}



#pragma mark -


-(void)closeSelectChannelView
{
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.3 animations:^{
        effectview.alpha = 0;
    } completion:^(BOOL finished) {
        [pickview removeFromSuperview];
        pickview=nil;
        [effectview removeFromSuperview];
        effectview=nil;
    }];
    
    [UIView commitAnimations];

}


//设置团队信息
-(void)setChannelid:(NSString *)channelid
{
    _channelid=channelid;
    groupinfo = [[GroupInfo getInstancet] getGroupForGroupid:_channelid];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!channelname){
            NSLog(@"2 %f",map.frame.size.height );
            channelname = [[UIButton alloc] init];
            channelname.frame=CGRectMake(0, map.frame.size.height -25, map.frame.size.width, 24);
            [channelname setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
            [channelname setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
            channelname.layer.borderWidth=0.9f;
            channelname.layer.borderColor = [[UIColor colorWithRed:0.917f green:0.5f blue:0.062f alpha:1.00] CGColor];
            channelname.layer.cornerRadius=6;
            channelname.layer.masksToBounds=YES;
            [map addSubview:channelname];
        }
        [channelname setTitle:[groupinfo objectForKey:@"CHNAME"] forState:UIControlStateNormal];

    });
    NSLog(@"%@",groupinfo);
    
}
//点击定位
-(void)Clickbtnloc
{
    
    [map setCenterCoordinate:_location.coordinate animated:YES];
//    map.userTrackingMode=MAUserTrackingModeFollow;
}


//更新GPS
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


//更新GPS
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
