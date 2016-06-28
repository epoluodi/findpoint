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
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptAction.authenticationRequired = NO;//需要解锁才能处理，如果
    
    UIMutableUserNotificationAction *acceptAction2 = [[UIMutableUserNotificationAction alloc] init];
    acceptAction2.identifier = @"acceptAction";
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
