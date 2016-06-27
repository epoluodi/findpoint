//
//  MainTabBar.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/22.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "MainTabBar.h"
#import "GDLocation.h"

@interface MainTabBar ()

@end

@implementation MainTabBar


- (void)viewDidLoad {
    [super viewDidLoad];
    //接受按钮
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"acceptAction";
    acceptAction.title = @"上报位置";
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    //拒绝按钮
    UIMutableUserNotificationAction *rejectAction = [[UIMutableUserNotificationAction alloc] init];
    rejectAction.identifier = @"rejectAction";
    rejectAction.title = @"拒绝";
    rejectAction.activationMode = UIUserNotificationActivationModeBackground;
    rejectAction.authenticationRequired = NO;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//    rejectAction.destructive = YES;

    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"boardcast";
    NSArray *actions = @[acceptAction,rejectAction];
    [categorys setActions:actions forContext:UIUserNotificationActionContextMinimal];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                         settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                         categories:[NSSet setWithObjects:categorys, nil]]];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
