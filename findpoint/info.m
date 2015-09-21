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
    return [super init];
}



@end
