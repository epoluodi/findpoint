//
//  WebService.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClass.h"
#import "WebUrl.h"



@interface WebService : NSObject
{
    HttpClass *service;
}

-(instancetype)initChannel:(NSString *)url;
-(instancetype)initUserinfo:(NSString *)url;





-(int)checkchannelid:(NSString *)channcelid;
-(int)createchannel:(NSString *)json;


-(int)NewUserGetUserID:(NSString *)deviceid;
@end