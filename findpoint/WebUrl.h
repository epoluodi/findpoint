//
//  WebUrl.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/22.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//


#pragma 通道调用地址

#define ServerUrl @"http://epoluodi.vicp.cc:8081/"

#define checkchannelurl @"http://192.168.1.10:8081/channel.asmx/checkchannel"
#define addchannelurl @"http://192.168.1.10:8081/channel.asmx/createchannel"

#pragma 用户信息调用地址
#define UserCreate [NSString stringWithFormat:@"%@%@",ServerUrl,@"userinfo.asmx/UserCreate"]



