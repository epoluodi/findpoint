//
//  AppDelegate.m
//  findpoint
//
//  Created by 程嘉雯 on 15/5/31.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "AppDelegate.h"
#import "GroupInfo.h"
#import "GPSClass.h"
#import "WebService.h"
#import "NotificationGPS.h"
#import "MainTabBar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    // Override point for customization after application launch.
    [MAMapServices sharedServices].apiKey = MAPKEY;
    [AMapLocationServices sharedServices].apiKey=MAPKEY;
    [AMapSearchServices sharedServices].apiKey =MAPKEY;
    
    
    
    [TencentClass getInstance];//初始化 QQ
    [WeChatClass getInstance];
    
    deviveid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [info getInstancent];//初始化info
    [info getInstancent].uid =deviveid;//deviveid;
    [[info getInstancent] LoginUserForServer];
    
    [GroupInfo getInstancet];
    
    
    
    
    return YES;
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   
    
    MainTabBar *main = (MainTabBar *)_window.rootViewController;
    [main NoiticaionForremot:userInfo];
}



-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    pushToken = [[[[deviceToken description]
                   stringByReplacingOccurrencesOfString:@"<" withString:@""]
                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"推送toekn %@",pushToken);
    
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQ, ^{
        WebService *web = [[WebService alloc] initUrl:pushsubmit];
        [web submittoken:pushToken];
    });
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
        [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertTitle message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    return;
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    NSLog(@"%@",identifier);
    if ([identifier isEqualToString:@"accept"]){
        CLLocation *loc;
        NotificationGPS *ngps;
        [GDLocation getInstancet].delegate=self;
        if ([GDLocation getInstancet].IsLocation){
            loc= [GDLocation getInstancet].GetLocation;
            ngps = [[NotificationGPS alloc] init];
            [ngps updateGPS:loc];
        }
        else{
            [MAMapServices sharedServices].apiKey = MAPKEY;
            [AMapLocationServices sharedServices].apiKey=MAPKEY;
            [AMapSearchServices sharedServices].apiKey =MAPKEY;
            [GDLocation getInstancet];
            sleep(1);
            [[GDLocation getInstancet] SingleLocation];
        }
    }
    
    if ([identifier isEqualToString:@"recive"]){
        NotificationGPS *ngps;
        ngps = [[NotificationGPS alloc] init];
        NSString *str =[userInfo objectForKey:@"json"] ;
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        [ngps sendpush:[d objectForKey:@"userid"]];
    }
    
    completionHandler();
}







#pragma mark 定位
-(void)updateSingleLocInfo:(CLLocation *)loc GeoCode:(AMapLocationReGeocode *)getoinfo
{
    NotificationGPS *ngps = [[NotificationGPS alloc] init];
    [ngps updateGPS:loc];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSLog(@"openURL %@",options);
    [WeChatClass WxHandleOpenUrl:[WeChatClass getInstance] url:url];
    return [TencentOAuth HandleOpenURL:url];
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [TencentOAuth HandleOpenURL:url];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [TencentOAuth HandleOpenURL:url];
//}
@end
