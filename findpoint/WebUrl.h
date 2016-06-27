//
//  WebUrl.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/22.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//


#pragma 通道调用地址

#define ServerUrl @"http://epoluodi.vicp.cc:8081/"

#define checkchannelurl @"http://epoluodi.vicp.cc:8081/channel.asmx/checkchannel"
#define addchannelurl @"http://epoluodi.vicp.cc:8081/channel.asmx/createchannel"
#define qurychannelurl @"http://epoluodi.vicp.cc:8081/channel.asmx/querychannel"
#define getselfchannelurl @"http://epoluodi.vicp.cc:8081/channel.asmx/getselfchannel"
#define addchanneluser @"http://epoluodi.vicp.cc:8081/channel.asmx/addchanneluser"
#define getchanneluserinfo @"http://epoluodi.vicp.cc:8081/channel.asmx/getChanneluserinfo"
#define delChanneluserinfo @"http://epoluodi.vicp.cc:8081/channel.asmx/delChanneluserinfo"
#define getChannelForGPS @"http://epoluodi.vicp.cc:8081/channel.asmx/getChannelForGPS"

#define downloadjpg @"http://epoluodi.vicp.cc:8081/PublicCommon.asmx/Download"

#pragma 推送
#define pushsubmit [NSString stringWithFormat:@"%@%@",ServerUrl,@"push.asmx/submitToken"]
#pragma 用户信息调用地址
#define UserCreate [NSString stringWithFormat:@"%@%@",ServerUrl,@"userinfo.asmx/UserCreate"]


#pragma gps
#define SubmitGPS @"http://epoluodi.vicp.cc:8081/GPS.asmx/userForGPS"
