//
//  AppDelegate.h
//  findpoint
//
//  Created by 程嘉雯 on 15/5/31.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "info.h"
#import "WebService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSUserDefaults *userinfo;
    NSString *pushToken;
    NSString *deviveid;
    WebService *web;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) info * info;

@end

