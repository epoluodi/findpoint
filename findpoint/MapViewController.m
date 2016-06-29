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
#import "MarkVIew.h"
#import "Common.h"
#import <Common/FileCommon.h>

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize map;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    marklist = [[NSMutableDictionary alloc] init];
    devicelist = [[NSMutableArray alloc] init];
    map.showsCompass=NO;
    map.showsUserLocation=YES;
    map.zoomLevel=17;
    map.userTrackingMode=MAUserTrackingModeFollow;
    map.delegate=self;
    map.scaleOrigin = CGPointMake(map.scaleOrigin.x, map.scaleOrigin.y+5);
    [GDLocation getInstancet].delegate=self;
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(updateGPS) userInfo:nil repeats:YES];
    isrun=NO;
//
    timer2=[NSTimer scheduledTimerWithTimeInterval:45 target:self selector:@selector(refreshUserGPSInfo) userInfo:nil repeats:YES];
    [timer2 fire];
    
    _self=self;
}

-(void)dealloc
{
    [timer1 invalidate];
    timer1=nil;
    [timer2 invalidate];
    timer2=nil;
    
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
    
  
    btnrefresh = [[UIButton alloc] init];
    btnrefresh.frame=CGRectMake(10,
                            map.frame.size.height -8 -120  -8-38, 38, 38);
    [btnrefresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [btnrefresh setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [btnrefresh setImageEdgeInsets:
     UIEdgeInsetsMake(5, 5, 5, 5)];
    btnrefresh.layer.borderWidth=1.2f;
    btnrefresh.layer.borderColor = [[UIColor colorWithRed:0.361 green:0.671 blue:0.886 alpha:1.00] CGColor];
    btnrefresh.layer.cornerRadius=6;
    btnrefresh.layer.masksToBounds=YES;
    [btnrefresh addTarget:self action:@selector(Onbtnrefresh) forControlEvents:UIControlEventTouchUpInside];
    [map addSubview:btnrefresh];

    
    
    
    
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
    [btngb addTarget:self action:@selector(showboradcastsheet) forControlEvents:UIControlEventTouchUpInside];
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


-(void)Onbtnrefresh
{
    [timer2 fire];
}

//点击选择团队
-(void)selectchannel
{
    
    if ([[GroupInfo getInstancet] getChannels]==0)
        return;
    
    
    
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
    [btnok addTarget:self action:@selector(OnSelectchannel) forControlEvents:UIControlEventTouchUpInside];
    
    btnno=[[UIButton alloc] init];
    [btnno setBackgroundImage:[UIImage imageNamed:@"btnno"] forState:UIControlStateNormal];
    btnno.frame=CGRectMake(effectview.frame.size.width / 2 -36 - 60, effectview.frame.size.height-80-60, 60, 60);
    [effectview addSubview:btnno];
    [btnno addTarget:self action:@selector(closeSelectChannelView) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.view addSubview:effectview];
    
}


//显示广播
-(void)showboradcastsheet
{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"广播信息" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"请各位上报位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self submitboradcast:@"请各位上报位置" msgtype:@"boardcast"];

    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"请各位到集合点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self submitboradcast:@"请各位到集合点" msgtype:@"answer"];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"今天活动结束" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self submitboradcast:@"今天活动结束" msgtype:nil];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"自定义消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_self showCustomMsg];
    }];
  
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [alert addAction:action5];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)showCustomMsg
{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"广播信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self submitboradcast:customtext.text msgtype:nil];
    }];
    
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        customtext = textField;
        textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        textField.placeholder=@"输入自定消息内容";
    }];
    
    [alert addAction:action1];
    [alert addAction:action5];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)submitboradcast:(NSString *)msg msgtype:(NSString *)msgtype
{
    if (!_channelid)
        return;
    NSString *strlist = [devicelist componentsJoinedByString:@","];
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
        
        WebService *web = [[WebService alloc] initUrl:sendPush];
        BOOL r=  [web sendpush:strlist msg:msg msgtype:msgtype];
        dispatch_async(mainQ, ^{
            NSString *alertmag;
            if (r)
                alertmag = @"广播已经发送";
            else
                alertmag = @"广播发送失败";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertmag delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        });
    });
    
    
    
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

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSDictionary *d = [[GroupInfo getInstancet] getGroupForindex:row];
//    return [d objectForKey:@"CHNAME"];
//}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
     NSDictionary *d = [[GroupInfo getInstancet] getGroupForindex:row];
    
    UILabel *l = [[UILabel alloc] init];
    l.textColor = [UIColor whiteColor];
    l.text=[d objectForKey:@"CHNAME"];
    l.textAlignment=NSTextAlignmentCenter;
    return l;
}

#pragma mark -


//选择一个团队
-(void)OnSelectchannel
{
    int row= [pickview selectedRowInComponent:0];
    NSDictionary *d = [[GroupInfo getInstancet] getGroupForindex:row];
    [self setChannelid:[d objectForKey:@"CHID"]];
    [self closeSelectChannelView];
}

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
    if (!_channelid)
    {
        [marklist removeAllObjects];

        [map removeAnnotation:map.annotations];
        [channelname removeFromSuperview];
        channelname=nil;
        [timer2 invalidate];
        return;
    }
    groupinfo = [[GroupInfo getInstancet] getGroupForGroupid:_channelid];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!channelname){
        
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
    [timer2 fire];
}


-(void)refreshUserGPSInfo
{
    NSLog(@"定时器开始运行！");
    if ([_channelid isEqualToString:@""])
        return;
    
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    dispatch_async(globalQ, ^{
        if (!_channelid)
            return ;
        WebService *web = [[WebService alloc] initUrl:getChannelForGPS];
        NSArray * gpslist = [web getChannelGPS:_channelid];
        if (!gpslist)
            return ;
        dispatch_async(mainQ, ^{
            NSMutableArray *key = [[NSMutableArray alloc] initWithArray:[marklist allKeys]];
       
            CustomerPointAnnotaton *mapmark;
            [devicelist removeAllObjects];
            for (NSDictionary *d in gpslist) {
                [devicelist addObject:[d objectForKey:@"deviceid"]];
                if ([key containsObject:[d objectForKey:@"deviceid"]])
                {
                    [key removeObject:[d objectForKey:@"deviceid"]];
                    mapmark = [marklist objectForKey:[d objectForKey:@"deviceid"]];
                }
                else
                    mapmark = [[CustomerPointAnnotaton alloc] init];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = ((NSString *)[d  objectForKey:@"lat"]).doubleValue;
                coordinate.longitude = ((NSString *)[d  objectForKey:@"lng"]).doubleValue;
                mapmark.coordinate =coordinate;
                mapmark.data=d;
                mapmark.title=[d objectForKey:@"name"];
                mapmark.uid = [d objectForKey:@"deviceid"];
                [marklist setObject:mapmark forKey:[d objectForKey:@"deviceid"]];
         
            }
            for (NSString *s  in key) {
                [marklist removeObjectForKey:s];
            }
       
    
            [map addAnnotations:[marklist allValues]];

        
        });
    });
}




#pragma mark 地图委托
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    NSLog(@"callout view :%@", view);
}


-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([[annotation title] isEqualToString:@"当前位置"])
        return nil;
    
    CustomerPointAnnotaton *cann = (CustomerPointAnnotaton *)annotation;
    
    MarkVIew *mark = [[MarkVIew alloc ] initWithAnnotation:annotation reuseIdentifier:@"mark"];
    NSDictionary *d = cann.data;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [FileCommon getCacheDirectory];
    NSString* _filename = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[d objectForKey:@"openid"]]];
    NSData *pngdata;
    if ([fm fileExistsAtPath:_filename])
    {
        pngdata = [NSData dataWithContentsOfFile:_filename];

    }
    else
    {
        NSURL *url = [NSURL URLWithString:[d objectForKey:@"photo"]];
        pngdata = [NSData dataWithContentsOfURL:url];
        if (pngdata)
        {
            [fm createFileAtPath:_filename contents:pngdata attributes:nil];
        }
    }
    
    if (pngdata)
        mark.nickimg.image=[UIImage imageWithData:pngdata];
    
    return mark;


}

#pragma mark -
//点击定位
-(void)Clickbtnloc
{
    [map setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
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
