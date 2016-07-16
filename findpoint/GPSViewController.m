//
//  GPSViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/13.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "GPSViewController.h"
#import <Common/PublicCommon.h>
#import "WeChatClass.h"

@interface GPSViewController ()
{
    NSTimer *timer;
    CLLocation *loc;
    SheetUI *shareview;
    UIAlertController *sharealert;
}
@end

@implementation GPSViewController
@synthesize map,gpsjd,gpshight,gpsspeed,gpslocation;
@synthesize txtcity,txtsheng,txtaddress;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    map.showsLabels = YES;
    map.zoomEnabled=NO;
    map.scrollEnabled=NO;
    map.rotateEnabled=NO;
    map.showsCompass=NO;
    map.showsScale=NO;
    map.showsUserLocation=YES;
    
    txtcity.text = @"--";
    txtsheng.text=@"--";
    txtaddress.text=@"地址:-";
    gpsjd.text = @"定位精度:-";
    gpshight.text = @"海拔:-";
    gpsspeed.text=@"速度:-";
    gpslocation.text=@"--";

    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(refreshlocation) userInfo:nil repeats:NO];
    [timer fire];
}


-(void)refreshlocation
{
    loc =[GDLocation getInstancet].GetLocation;
    [GDLocation getInstancet].delegate=self;
    [map setCenterCoordinate:loc.coordinate];
    [map setZoomLevel:17];
    [[GDLocation getInstancet] getLocationGeoInfo:loc];
    gpslocation.text = [NSString stringWithFormat:@"经度:%f  纬度:%f",loc.coordinate.latitude,loc.coordinate.longitude];
    [timer invalidate];
    timer=nil;
}

-(void)updateReGeoInfo:(AMapReGeocode *)GeoCodeInfo
{
    NSLog(@"%@",GeoCodeInfo.addressComponent);
    txtsheng.text=GeoCodeInfo.addressComponent.province;
    txtcity.text = GeoCodeInfo.addressComponent.city;
    txtaddress.text = [NSString stringWithFormat:@"地址:%@%@%@",
                       GeoCodeInfo.addressComponent.district,
                       GeoCodeInfo.addressComponent.streetNumber.street,
                       GeoCodeInfo.addressComponent.streetNumber.number];
    gpsjd.text = [NSString stringWithFormat:@"定位精度:(水平)%.1f米-(垂直)%.1f米",loc.horizontalAccuracy,
                 loc.verticalAccuracy ];
    gpsspeed.text = [NSString stringWithFormat:@"速度:%.1f米/每秒",loc.speed];
    gpshight.text = [NSString stringWithFormat:@"海拔:%.1f米",loc.altitude];
 
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

- (IBAction)clickreturn:(id)sender {
    [timer invalidate];
    timer = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickshare:(id)sender {
    shareview = [[SheetUI alloc] initclass:self];
    shareview.ISWEiBO=NO;
    shareview.IsQQ=NO;
    sharealert =  [shareview SHowSheet:nil];
    [self presentViewController:sharealert animated:YES completion:nil];
    
    
}




#pragma mark 分享委托
-(void)setupshow
{
    
}
-(void)SetqueryParams:(int)type
{
    [sharealert dismissViewControllerAnimated:YES completion:nil];
    sharealert=nil;

    UIImage *img =[map takeSnapshotInRect:CGRectMake(0, 0, map.frame.size.width, map.frame.size.height)];
    UIImage *ThumbImage = [PublicCommon scaleToSize:img size:map.frame.size];
    NSData *jpgdata = UIImageJPEGRepresentation(img, 80);
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingString:@"/temp.jpg"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:filePath contents:jpgdata attributes:nil];

    
    switch (type) {
        case 1:
        [[WeChatClass getInstance] sendImageContent:ThumbImage WXScene:WXSceneSession filepath:filePath title:@"我的位置" desc:@"我的位置"];
        break;
        case 2:
          [[WeChatClass getInstance] sendImageContent:ThumbImage WXScene:WXSceneTimeline filepath:filePath title:@"我的位置" desc:@"我的位置"];
        break;
   
    }
}
-(void)cancelquery
{
    
}




@end
