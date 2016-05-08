//
//  info.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "info.h"

@implementation info
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

-(instancetype)init
{
    userinfo = [NSUserDefaults standardUserDefaults];
    BOOL isfirstrun = [userinfo boolForKey:@"isfirstrun"];
//    if (!isfirstrun)
//    {
//        [self createuserinfo];
        //连接服务器获得一个用户id
        
//        web = [[WebService alloc] initUserinfo:reguserid];
//        int r = [web NewUserGetUserID:deviveid];
//        if (r > 0)
//        {
//            _info.loginerid=[NSString stringWithFormat:@"%d",r];
//            _info.loginer=[NSString stringWithFormat:@"点名号%d",r];
//            NSLog(@"用户 ID %@",_info.loginerid);
//            
//            [userinfo setObject:_info.loginerid forKey:@"userid"];//用户ID
//            [userinfo setBool:NO forKey:@"isregister"];//是否注册
//            ;
//            
//            
//        }
//        
//        
//        
//    }

    
    
    return [super init];
}



//创建app 用户信息
-(void)createuserinfo
{
    [userinfo setBool:NO forKey:@"isregister"];//是否注册
    [userinfo setObject:nil forKey:@"userid"];//用户ID
    [userinfo setObject:nil forKey:@"now_channelid"];//当前加入的频道号
    [userinfo setObject:nil forKey:@"nickimage"];//当前头像

}
@end
