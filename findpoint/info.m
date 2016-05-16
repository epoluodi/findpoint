//
//  info.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "info.h"

@implementation info
@synthesize uid;

@synthesize channelimage;
@synthesize channelid;
@synthesize channelname;
@synthesize channelpwd;
@synthesize channelcounts;
@synthesize channelcreatedt;
@synthesize channeldesc;
@synthesize loginer;
@synthesize loginerid;

@synthesize _Gchannelid;


static info *_info;
+(instancetype)getInstancent
{
    if (!_info)
    {
        _info = [[info alloc] init];
    }
    return  _info;
}


-(instancetype)init
{
    userinfo = [NSUserDefaults standardUserDefaults];
    BOOL isfirstrun = [userinfo boolForKey:@"isfirstrun"];
    if (!isfirstrun)
    {
        [self createuserinfo];
        [userinfo setBool:YES forKey:@"isfirstrun"];
    }
    return [super init];
}



//创建app 用户信息
-(void)createuserinfo
{
    [userinfo setBool:NO forKey:@"isregister"];//是否注册
    [userinfo setObject:nil forKey:@"now_channelid"];//当前加入的频道号
    [userinfo setObject:nil forKey:@"nickimage"];//当前头像
    [userinfo setObject:@"-" forKey:@"nickname"];//当前 名称
    
}
@end
