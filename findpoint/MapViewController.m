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
#import "MBProgressHUD.h"

@interface MapViewController ()
{
    MBProgressHUD *hub;
}
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
    Measure = NO;
    timer1 = [NSTimer scheduledTimerWithTimeInterval:45 target:self selector:@selector(updateGPS) userInfo:nil repeats:YES];
    isrun=NO;
    //
    timer2=[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshUserGPSInfo) userInfo:nil repeats:YES];
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
    if (meetingAnnotaton)
    {
        [meetingAnnotaton.markview startAnimiation];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (meetingAnnotaton)
    {
        [meetingAnnotaton.markview stopAnimation];
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
    [btnmeet addTarget:self action:@selector(showmeetingmark) forControlEvents:UIControlEventTouchUpInside];
    [controlview addSubview:btnmeet];
    
    btnlen = [[UIButton alloc] init];
    btnlen.frame=CGRectMake(10, btnmeet.frame.origin.y + 60 +10, 40, 60);
    [btnlen setImage:[UIImage imageNamed:@"len"] forState:UIControlStateNormal];
    [btnlen addTarget:self action:@selector(Openmeasure) forControlEvents:UIControlEventTouchUpInside];
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



//开启测量
-(void)Openmeasure
{
    if (Measure){
        Measure =NO;
           [btnlen setImage:[UIImage imageNamed:@"len"] forState:UIControlStateNormal];
        [map removeOverlays:overlays];
        [overlays removeAllObjects];
        overlays=nil;
    }
    else
    {
        Measure = YES;
        overlays = [[NSMutableArray alloc] init];
        [btnlen setImage:[UIImage imageNamed:@"len2"] forState:UIControlStateNormal];
        for (NSString *s in [marklist allKeys]) {
            CustomerPointAnnotaton *ca = [marklist objectForKey:s];
            CLLocationCoordinate2D coord2d [2];
            coord2d[0] = ca.coordinate;
            coord2d[1] = map.userLocation.coordinate;
            MAMultiPolyline *multiTexturePolyline = [MAMultiPolyline polylineWithCoordinates:coord2d count:2 drawStyleIndexes:@[@0,@1]];
            [overlays addObject:multiTexturePolyline];
            [map addOverlay:multiTexturePolyline];
        }

    }
    
}

//集合
-(void)showmeetingmark
{
    
    
    if (!meetingAnnotaton)
    {
        meetingAnnotaton = [[CustomerPointAnnotaton alloc] init];
        meetingAnnotaton.coordinate = map.centerCoordinate;
        meetingAnnotaton.title=@"集合点";
        meetingAnnotaton.identity = @"meeting";
        meetingAnnotaton.creater = [info getInstancent].uid;
        [map addAnnotation:meetingAnnotaton];
        [map selectAnnotation:meetingAnnotaton animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"已经有一个结合点，如果要创建新的结合点，请先删除当前集合点" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [map setCenterCoordinate:meetingAnnotaton.coordinate animated:YES];
    }
}

//显示广播
-(void)showboradcastsheet
{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"广播信息" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"请各位上报位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self submitboradcast:@"请各位上报位置" msgtype:@"boardcast"];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"请各位到集合点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (!meetingAnnotaton)
        {
            UIAlertView *_alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先设置集合点" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [_alert show];
            return ;
        }
        
        NSString *json;
        NSDictionary *_djson = [[NSDictionary alloc] initWithObjectsAndKeys:
        [info getInstancent].uid,@"userid",
        @(meetingAnnotaton.coordinate.latitude),@"lat",
        @(meetingAnnotaton.coordinate.longitude),@"lng",
        _channelid,@"chid",nil];
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:_djson options:NSJSONWritingPrettyPrinted error:nil];
        json = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        NSLog(@"json %@",json);
        [self submitboradcast:@"请各位到集合点" json:json msgtype:@"answer"];
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
    [devicelist removeObject:[info getInstancent].uid ];
    NSString *strlist = [devicelist componentsJoinedByString:@","];
    
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
        
        WebService *web = [[WebService alloc] initUrl:sendPush];
        BOOL r=  [web sendpush:strlist msg:msg msgtype:msgtype];
        dispatch_async(mainQ, ^{
            NSString *alertmag;
            if (r)
                alertmag = @"已经发送";
            else
                alertmag = @"发送失败";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertmag delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        });
    });
    
    
    
}



-(void)submitboradcast:(NSString *)msg json:(NSString *)json msgtype:(NSString *)msgtype
{
    
    
    
    if (!_channelid)
        return;
    [devicelist removeObject:[info getInstancent].uid];
    NSString *strlist = [devicelist componentsJoinedByString:@","];
    if (!strlist|| [strlist isEqualToString:@""])
        return;
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
        
        WebService *web = [[WebService alloc] initUrl:sendPush];
        BOOL r=  [web sendpush:strlist msg:msg json:json msgtype:msgtype];
        dispatch_async(mainQ, ^{
            NSString *alertmag;
            if (r)
                alertmag = @"已经发送";
            else
                alertmag = @"发送失败";
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
    [self delmeetingmark];
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
        meetingAnnotaton = nil;
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
        NSDictionary *d =[web getChannelGPS:_channelid];
        if (!d)
            return ;
        dispatch_async(mainQ, ^{
            NSMutableArray *key = [[NSMutableArray alloc] initWithArray:[marklist allKeys]];
            
            
            NSArray * gpslist = [d objectForKey:@"gps"];
            NSDictionary *meetinfo = [d objectForKey:@"meeting"];
            if ([[meetinfo objectForKey:@"state"] isEqualToString:@"1"])
            {
                if (!meetingAnnotaton)
                {
                    meetingAnnotaton = [[CustomerPointAnnotaton alloc] init];
                    CLLocationCoordinate2D coordinate;
                    coordinate.latitude = ((NSString *)[meetinfo  objectForKey:@"lat"]).doubleValue;
                    coordinate.longitude = ((NSString *)[meetinfo  objectForKey:@"lng"]).doubleValue;
                    meetingAnnotaton.coordinate = coordinate;
                    meetingAnnotaton.title=@"集合点";
                    meetingAnnotaton.identity = @"meeting";
                    if ([[info getInstancent].uid isEqualToString:[meetinfo objectForKey:@"userid"]])
                    {
                        meetingAnnotaton.creater = [info getInstancent].uid;
                    }
                    meetingAnnotaton.img =[meetinfo objectForKey:@"img"];
                    [map addAnnotation:meetingAnnotaton];
                    [map selectAnnotation:meetingAnnotaton animated:YES];
                }
                else
                {
                    CLLocationCoordinate2D coordinate;
                    coordinate.latitude = ((NSString *)[meetinfo  objectForKey:@"lat"]).doubleValue;
                    coordinate.longitude = ((NSString *)[meetinfo  objectForKey:@"lng"]).doubleValue;
                    
                    if (meetingAnnotaton.coordinate.latitude != coordinate.latitude ||
                        meetingAnnotaton.coordinate.longitude!= coordinate.longitude)
                    {
                        meetingAnnotaton.coordinate=coordinate;
                        [map selectAnnotation:meetingAnnotaton animated:YES];
                    }
                    meetingAnnotaton.img =[meetinfo objectForKey:@"img"];
                    [meetingAnnotaton.markview setMeetingimgForuuid:[meetinfo objectForKey:@"img"]];
                 
                    
                }
                
                
            }
            else
            {
                if (meetingAnnotaton)
                {
                    [map removeAnnotation:meetingAnnotaton];
                    meetingAnnotaton = nil;
                    meetingimg = nil;
                }
            }
            CustomerPointAnnotaton *mapmark;
            [devicelist removeAllObjects];
            for (NSDictionary *d in gpslist) {
                if ([[d objectForKey:@"deviceid"]  isEqualToString:[info getInstancent].uid])
                    continue;
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
                mapmark.identity=[d objectForKey:@"deviceid"];
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


//删除集合标记
-(void)delmeetingmark
{
    
    
    if (meetingAnnotaton){
        
        if (![meetingAnnotaton.creater isEqualToString:[info getInstancent].uid])
        {
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"你不是集合点创建者，你确定要删除集合点吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
                [self delmeetingmarkAnnotation];
                
            }];
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        
        [self delmeetingmarkAnnotation];
    }
    
}

-(void)delmeetingmarkAnnotation
{
 
    
    
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
        [devicelist removeObject:[info getInstancent].uid];
        NSString *strlist = [devicelist componentsJoinedByString:@","];
        if (!strlist|| [strlist isEqualToString:@""])
            return;
        
        
        
        
        WebService *web = [[WebService alloc] initUrl:delMeetingMarkInfo];
         BOOL r= [web delChannelMeetingInfo:_channelid];
        if (r){
            web = nil;
            web = [[WebService alloc] initUrl:sendPush];
           r = [web sendpush:strlist msg:@"集合点取消！" msgtype:nil];
        }
        dispatch_async(mainQ, ^{
            
            if (!r)
            {
                [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络错误请重新尝试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return ;
            }
            
            [map removeAnnotation:meetingAnnotaton];
            meetingAnnotaton = nil;
            meetingimg=nil;
            
            
        });
    });
    

}


//添加集合照片
-(void)addmeetingImage
{
    
    
    if (meetingAnnotaton){
        
        if (![meetingAnnotaton.creater isEqualToString:[info getInstancent].uid])
        {
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"你不是集合点创建者，你确定要修改照片吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self addmeetingImageDo];
                
            }];
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        
        [self addmeetingImageDo];
    }
    
    
    
}

-(void)addmeetingImageDo
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 pickerview = [[UIImagePickerController alloc] init];//初始化
                                 pickerview.delegate = self;
                                 pickerview.allowsEditing = YES;//设置可编辑
                                 UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                                 pickerview.sourceType = sourceType;
                                 [self presentModalViewController:pickerview animated:YES];//进入照相界面
                             }];
    
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                pickerview = [[UIImagePickerController alloc] init];//初始化
                                pickerview.delegate = self;
                                pickerview.allowsEditing = YES;//设置可编辑
                                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                pickerview.sourceType = sourceType;
                                [self presentModalViewController:pickerview animated:YES];//进入照相界面
                            }];
    
    
    
    
    [alert addAction:camera];
    [alert addAction:photo];
    
    [self presentViewController:alert animated:YES completion:nil];

}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    meetingimg = [image copy];
    [meetingAnnotaton.markview setMeetingimg:meetingimg];
    
    
    NSLog(@"SMILE!");
    //    [self.capturedImages addObject:image];
    
    //    if ([self.cameraTimer isValid])
    //    {
    //        return;
    //    }
    
    
    
    NSData *jpgdata = UIImageJPEGRepresentation(image, 80);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [FileCommon getCacheDirectory];
    NSString *uuid = [[NSUUID UUID] UUIDString];
    uuid =[uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    //
    NSString *filename = [NSString stringWithFormat:@"/%@.jpg",uuid];
    [fileManager createFileAtPath:[filePath stringByAppendingString:filename] contents:jpgdata attributes:nil];
    
    
    
    
        dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
      dispatch_queue_t mainQ = dispatch_get_main_queue();
    hub = [[MBProgressHUD alloc] initWithView:map];
    [map addSubview:hub];
    [hub show:YES];
    dispatch_async(globalQ, ^{
        WebService *web = [[WebService alloc] initUrl:uploadfile];
        BOOL r =[web UploadFile:uuid DATA:jpgdata];
        NSLog(@"%d",r);
        if (r)
        {
            WebService *web = [[WebService alloc] initUrl:updatemeetingimg];
            r= [web UpdateMeetingImg:_channelid uuid:uuid];

        }
        dispatch_async(mainQ, ^{
            [hub hide:YES];
            
           if (!r)
           {
               meetingimg = nil;
               [meetingAnnotaton.markview setMeetingimg:meetingimg];
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传照片失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
               [alert show];
               return ;
           }
        });
    });
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    [self finishAndUpdate];
}




#pragma mark 地图委托

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
    polylineRenderer.lineWidth = 6.f;
    polylineRenderer.strokeColors = @[[[UIColor redColor] colorWithAlphaComponent:0.7],
                                      [[UIColor yellowColor] colorWithAlphaComponent:0.7]];
    polylineRenderer.gradient = YES;
    return polylineRenderer;
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    NSLog(@"callout view :%@", view);
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"accessory view :%@", view);
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    NSLog(@"old :%ld - new :%ld", (long)oldState, (long)newState);
    
}


-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if (Measure)
    {
        CLLocationCoordinate2D coord2d = view.annotation.coordinate;
        //1.将两个经纬度点转成投影点
        MAMapPoint point1 = MAMapPointForCoordinate(coord2d);
        MAMapPoint point2 = MAMapPointForCoordinate(_location.coordinate);
        //2.计算距离
        
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        NSString *strlen;
        if (distance<1000)
            strlen = [NSString stringWithFormat:@"%.2f 米",distance];
        if (distance > 1000)
            strlen = [NSString stringWithFormat:@"%.2f 公里",distance/1000];
        
        ((CustomerPointAnnotaton *)view.annotation).subtitle =strlen;
        
    }
    else
        ((CustomerPointAnnotaton *)view.annotation).subtitle =nil;
}
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    //1.将两个经纬度点转成投影点
    
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(39.989612,116.480972));
    
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(39.990347,116.480441));
    
    
    
    //2.计算距离
    
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    
    
    if ([[annotation title] isEqualToString:@"当前位置"])
        return nil;
    
    CustomerPointAnnotaton *cann = (CustomerPointAnnotaton *)annotation;
    MarkVIew *mark;
    
    if ([cann.identity isEqualToString:@"meeting"]){
        mark = [[MarkVIew alloc ] initWithAnnotation:annotation reuseIdentifier:@"meeting"];
        mark.nickimg.image = [UIImage imageNamed:@"meeting"];
        [mark startAnimiation];
        UIImageView * img = [[UIImageView alloc] init];
        img.image=[UIImage imageNamed:@"meeting"];
        img.frame=CGRectMake(10, 10, 90, 90);
        mark.canShowCallout=NO;
        mark.IsCustomCallout=YES;
        mark.controllview=self;
        mark.calloutOffset    = CGPointMake(0, -5);
        mark.img=meetingAnnotaton.img;
        meetingAnnotaton.markview = mark;
        return mark;
    }
    
    
    mark = [[MarkVIew alloc ] initWithAnnotation:annotation reuseIdentifier:@"mark"];
    mark.draggable=NO;
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
    
    if (Measure)
    {
        [map removeOverlays:overlays];
        [overlays removeAllObjects];

        for (NSString *s in [marklist allKeys]) {
            CustomerPointAnnotaton *ca = [marklist objectForKey:s];
            CLLocationCoordinate2D coord2d [2];
            coord2d[0] = ca.coordinate;
            coord2d[1] = map.userLocation.coordinate;
            MAMultiPolyline *multiTexturePolyline = [MAMultiPolyline polylineWithCoordinates:coord2d count:2 drawStyleIndexes:@[@0,@1]];
            [overlays addObject:multiTexturePolyline];
            [map addOverlay:multiTexturePolyline];
        }
    }
    
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
