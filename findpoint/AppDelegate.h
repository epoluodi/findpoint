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
#import "TencentClass.h"
#import "WeChatClass.h"

#define MAPKEY @"7abad449503752055bbe35c553131a16"
#define QQKEY @"AhXtCwxURKsgEman"
#define WXKEY @"wx83f4e870ad68cc6b"



@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSUserDefaults *userinfo;
    NSString *pushToken;
    NSString *deviveid;
    WebService *web;
}
@property (strong, nonatomic) UIWindow *window;

@end

