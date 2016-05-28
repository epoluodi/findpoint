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


#pragma GPS

//提交GPS
-(void)SubmitGPSInfo:(NSDictionary *)d
{
    NSData*jsondata = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    [service clearArray];
    NSString *json = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [service addParamsString:@"json" values:json];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    
}

#pragma 用户信息


-(BOOL)UserCreateinfo:(NSDictionary *)dict
{
    
    NSData*jsondata = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    [service clearArray];
    NSString *json = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [service addParamsString:@"json" values:json];
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
