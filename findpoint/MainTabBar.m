//
//  MainTabBar.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/22.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "MainTabBar.h"
#import "GDLocation.h"
#import "NotificationGPS.h"

@interface MainTabBar ()

@end

@implementation MainTabBar


- (void)viewDidLoad {
    [super viewDidLoad];
    //接受按钮
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"accept";
    acceptAction.title = @"上报位置";
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptAction.authenticationRequired = NO;//需要解锁才能处理，如果
    
    UIMutableUserNotificationAction *acceptAction2 = [[UIMutableUserNotificationAction alloc] init];
    acceptAction2.identifier = @"recive";
    acceptAction2.title = @"收到";
    acceptAction2.activationMode = UIUserNotificationActivationModeBackground;
    acceptAction2.authenticationRequired = NO;//需要解锁才能处理，如果
    
    
//    //拒绝按钮
//    UIMutableUserNotificationAction *rejectAction = [[UIMutableUserNotificationAction alloc] init];
//    rejectAction.identifier = @"rejectAction";
//    rejectAction.title = @"拒绝";
//    rejectAction.activationMode = UIUserNotificationActivationModeBackground;
//    rejectAction.authenticationRequired = NO;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//    rejectAction.destructive = YES;

    UIMutableUserNotificationCategory *categorys1 = [[UIMutableUserNotificationCategory alloc] init];
    categorys1.identifier = @"boardcast";
    NSArray *actions = @[acceptAction];
    [categorys1 setActions:actions forContext:UIUserNotificationActionContextMinimal];
    
    UIMutableUserNotificationCategory *categorys2 = [[UIMutableUserNotificationCategory alloc] init];
    categorys2.identifier = @"answer";
    NSArray *actions2 = @[acceptAction2];
    [categorys2 setActions:actions2 forContext:UIUserNotificationActionContextMinimal];
    
    
    
    
    
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                         settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                         categories:[NSSet setWithObjects:categorys1,categorys2, nil]]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入
    //开启连续定位
    [[GDLocation getInstancet] StartLocation];
    
    

    self.tabBar.tintColor=[UIColor greenColor];

    self.tabBar.barStyle=UIBarStyleBlack;
//    self.tabBar.backgroundImage =[UIImage imageNamed:@"settingbackimg"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)NoiticaionForremot:(NSDictionary *)json
{
    //    {
    //        aps =     {
    //            alert = "\U8bf7\U5404\U4f4d\U5230\U96c6\U5408\U70b9";
    //            badge = 1;
    //            category = answer;
    //            sound = "sound.caf";
    //        };
    //        json = "";
    //    }
    UIAlertController  *alert;
    
    NSString * category = [[json objectForKey:@"aps"] objectForKey:@"category"];
    NSString *remotedeviceid =[json objectForKey:@"json"];
    if ([category isEqualToString:@"boardcast"])
    {
        CLLocation*loc =   [GDLocation getInstancet].GetLocation;
        alert = [UIAlertController alertControllerWithTitle:@"通知提示" message:[[json objectForKey:@"aps"] objectForKey:@"alert"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"上报位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NotificationGPS *ngps = [[NotificationGPS  alloc] init];
            [ngps updateGPS:loc];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([category isEqualToString:@"answer"])
    {
        alert = [UIAlertController alertControllerWithTitle:@"通知提示" message:[[json objectForKey:@"aps"] objectForKey:@"alert"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"收到" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NotificationGPS *ngps = [[NotificationGPS  alloc] init];
            [ngps sendpush:[json objectForKey:@"json"]];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
