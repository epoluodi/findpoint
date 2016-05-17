//
//  WebService.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "WebService.h"


@implementation WebService

//通道web
-(instancetype)initChannel:(NSString *)url
{
    service = [[HttpClass alloc] init:url];
    return [super init];
}


-(instancetype)initUrl:(NSString *)url
{
    service = [[HttpClass alloc] init:url];
    return [super init];
}


#pragma 通道

//检查频道是否存在
-(int)checkchannelid:(NSString *)channcelid
{
    [service clearArray];
    [service addParamsString:@"channelid" values:channcelid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return -1;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return -1;
    return [ret intValue];
    
    
}

//  创建 频道
-(int)createchannel:(NSString *)json
{
    [service clearArray];
    [service addParamsString:@"json" values:json];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return -1;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return -1;
    return [ret intValue];
    
    
}



#pragma 用户信息

//新用户获得用户ID
-(BOOL)NewUserGetUserID:(NSString *)deviceid
{
    [service clearArray];
    [service addParamsString:@"deviceid" values:deviceid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return NO;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return NO;
    if ([ret isEqualToString:@"1"])
        return YES;
    else
        return NO;
    
}



@end
