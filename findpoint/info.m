//
//  info.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "info.h"
#import "WebService.h"

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
    
    
    if ([userinfo boolForKey:@"isregister"])
    {
        [TencentClass getInstance].oauth.accessToken = [userinfo stringForKey:@"accessToken"];
        [TencentClass getInstance].oauth.openId = [userinfo stringForKey:@"openId"];
        [TencentClass getInstance].oauth.expirationDate = (NSDate *)[userinfo objectForKey:@"expirationDate"];
        
        if (![[TencentClass getInstance] loginreset])
        {
            [userinfo setBool:NO forKey:@"isregister"];
            [TencentClass getInstance].delegate = self;
            [[TencentClass getInstance] LoginQQ];
        }
      
    }

    
    return [super init];
}


-(void)LoginUserForServer
{
    NSDictionary *d ;
    BOOL Islogin=[userinfo boolForKey:@"isregister"];
    if (Islogin){
        d = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"logintype",
            [userinfo stringForKey:@"nickname"],@"nickname",uid,@"deviceid",
             [userinfo stringForKey:@"nickimage"],@"nickphotopath",
             [userinfo stringForKey:@"openId"],@"qqopenid",nil];
    }
    else{
        d = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"logintype",
             @"",@"nickname",uid,@"deviceid",@"",@"nickphotopath",@"",@"qqopenid",nil];
    }
    WebService *web = [[WebService alloc] initUrl:UserCreate];
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQ, ^{
        [web UserCreateinfo:d];
    });
    
}


#pragma mark qqdelegate
-(void)loginFail
{
    [userinfo setBool:NO forKey:@"isregister"];//是否注册
}

-(void)loginSuccess:(NSString *)QQnick qqimg:(NSString *)qqimg
{
    [userinfo setBool:YES forKey:@"isregister"];//是否注册Q
    [userinfo setObject:qqimg forKey:@"nickimage"];//当前头像
    [userinfo setObject:QQnick forKey:@"nickname"];//当前 名称
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
