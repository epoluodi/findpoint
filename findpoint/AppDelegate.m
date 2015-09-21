//
//  AppDelegate.m
//  findpoint
//
//  Created by 程嘉雯 on 15/5/31.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSLog(@"%f",[Common GetScreenSIze].height);
    NSLog(@"%f",[Common GetScreenSIze].width);
    
    deviveid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    userinfo  = [NSUserDefaults standardUserDefaults];
        _info = [[info alloc] init];
    
    BOOL isfirstrun = [userinfo boolForKey:@"isfirstrun"];
    if (!isfirstrun)
    {
        [self createuserinfo];
        //连接服务器获得一个用户id
        
        web = [[WebService alloc] initUserinfo:reguserid];
        int r = [web NewUserGetUserID:deviveid];
        if (r > 0)
        {
            _info.loginerid=[NSString stringWithFormat:@"%d",r];
            _info.loginer=[NSString stringWithFormat:@"点名号%d",r];
            NSLog(@"用户 ID %@",_info.loginerid);
            
            [userinfo setObject:_info.loginerid forKey:@"userid"];//用户ID
             [userinfo setBool:NO forKey:@"isregister"];//是否注册
;
            
           
        }
        
        
        
    }
    
    

    _info.loginer=@"123";

    
    
    return YES;
}


//创建app 用户信息
-(void)createuserinfo
{
    [userinfo setBool:NO forKey:@"isregister"];//是否注册
    [userinfo setObject:nil forKey:@"userid"];//用户ID
    [userinfo setObject:nil forKey:@"now_channelid"];//当前加入的频道号
    [userinfo setObject:nil forKey:@"nickimage"];//当前头像
    
    
    
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
     pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

@end
