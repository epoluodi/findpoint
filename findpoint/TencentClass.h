//
//  TencentClass.h
//  泽臻小店
//
//  Created by xiaoguang yang on 15/5/2.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "TencentOpenAPI/QQApiInterface.h"


@protocol QQDelegate

@optional
-(void)loginFail;
-(void)loginSuccess:(NSString *)QQnick qqimg:(NSString *)qqimg;

@end


@interface TencentClass : NSObject<TencentSessionDelegate>
{
    NSArray* permissions;
}
@property (nonatomic, retain)TencentOAuth *oauth;
@property (nonatomic, weak)NSString *openid;
@property (weak,nonatomic) NSObject<QQDelegate> *delegate;

+(instancetype)getInstance;
-(instancetype)init:(NSString *)QQappid;
-(void)sendtxtmsg:(NSString *)msg;
- (void) sendNewMsg:(NSString *)strurl pngname:(NSData *)imgdata title:(NSString*)title desc:(NSString *)desc;
-(BOOL)loginreset;

-(void)sendQQWPA:(NSString *)qqid;
-(void)addQQfriend;
-(void)LoginQQ;


+(BOOL)checkQQ;
+(BOOL)CheckSSOlogin;


@end
