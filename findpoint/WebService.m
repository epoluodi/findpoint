//
//  WebService.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "WebService.h"
#import "info.h"


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

-(NSArray *)queryChannel:(NSString *)key
{
    [service clearArray];
    [service addParamsString:@"key" values:key];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return nil;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return nil;
    
    NSArray * arry = [NSJSONSerialization JSONObjectWithData:[ret dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    return [arry copy];
}


-(BOOL)addChanneluser:(NSString *)chid
{
    [service clearArray];
    [service addParamsString:@"userid" values:[info getInstancent].uid];
    [service addParamsString:@"channelid" values:chid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return NO;
    return YES;
}



-(NSArray *)getMyChannel
{
    [service clearArray];
    [service addParamsString:@"userid" values:[info getInstancent].uid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return nil;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return nil;
    
    NSArray * arry = [NSJSONSerialization JSONObjectWithData:[ret dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    return [arry copy];
}


-(NSArray *)getChannelUserInfo:(NSString *)chid
{
    [service clearArray];
    [service addParamsString:@"channelid" values:chid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return nil;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return nil;
    
    NSArray * arry = [NSJSONSerialization JSONObjectWithData:[ret dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    return [arry copy];
}

-(BOOL)delChannelUserInfo:(NSString *)chid
{
    [service clearArray];
    [service addParamsString:@"channelid" values:chid];
    [service addParamsString:@"userid" values:[info getInstancent].uid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return nil;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return nil;
    if ([ret isEqualToString:@"1"])
        return YES;
    return NO;
}


-(NSArray *)getChannelGPS:(NSString *)chid
{
    [service clearArray];
    [service addParamsString:@"channelid" values:chid];
    NSData *returndata =  [service httprequest:[service getDataForArrary]];
    if (returndata == nil)
        return nil;
    
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return nil;
    
    NSArray * arry = [NSJSONSerialization JSONObjectWithData:[ret dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    return [arry copy];
}

#pragma 推送
-(void)submittoken:(NSString *)token
{
    [service clearArray];
    [service addParamsString:@"userid" values:[info getInstancent].uid];
    [service addParamsString:@"token" values:token];
    [service httprequest:[service getDataForArrary]];
}

-(BOOL)sendpush:(NSString *)devicelist msg:(NSString *)msg msgtype:(NSString *)msgtype
{
    [service clearArray];
    [service addParamsString:@"devicelist" values:devicelist];
    [service addParamsString:@"msg" values:msg];
    [service addParamsString:@"json" values:@""];
    [service addParamsString:@"msgtype" values:msgtype];
    NSData* returndata =  [service httprequest:[service getDataForArrary]];
    
    if (returndata == nil)
        return NO;
    NSString *ret = [service getXmlString:returndata];
    if (ret == nil)
        return NO;
    if ([ret isEqualToString:@"1"])
        return YES;
    return NO;
}
#pragma GPS

//提交GPS
-(void)SubmitGPSInfo:(NSDictionary *)d
{
    NSData*jsondata = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    [service clearArray];
    NSString *json = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [service addParamsString:@"json" values:json];
    [service httprequest:[service getDataForArrary]];
    
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
