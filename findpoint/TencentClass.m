//
//  TencentClass.m
//  泽臻小店
//
//  Created by xiaoguang yang on 15/5/2.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import "TencentClass.h"
#import "AppDelegate.h"

@implementation TencentClass
@synthesize oauth;
@synthesize openid;
@synthesize delegate;


static TencentClass *tencentclass;
+(instancetype)getInstance
{
    if (!tencentclass)
    {
        tencentclass = [[TencentClass alloc] init:@"1104722026"];
        
    }
 
    return tencentclass;
}




-(instancetype)init:(NSString *)QQappid
{
    permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                            kOPEN_PERMISSION_ADD_ALBUM,
//                            kOPEN_PERMISSION_ADD_ONE_BLOG,
//                            kOPEN_PERMISSION_ADD_SHARE,
//                            kOPEN_PERMISSION_ADD_TOPIC,
//                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
//                            kOPEN_PERMISSION_GET_INFO,
//                            kOPEN_PERMISSION_GET_OTHER_INFO,
//                            kOPEN_PERMISSION_LIST_ALBUM,
//                            kOPEN_PERMISSION_UPLOAD_PIC,
//                            kOPEN_PERMISSION_GET_VIP_INFO,
//                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    oauth=[[TencentOAuth alloc] initWithAppId:QQappid andDelegate:self];

    return [super init];
    
}

+(BOOL)checkQQ
{
    if(![TencentOAuth iphoneQQInstalled ])
        return false;
    return true;
}

+(BOOL)CheckSSOlogin
{
    return [TencentOAuth iphoneQQSupportSSOLogin];
}



-(void)LoginQQ
{
    [oauth authorize:permissions inSafari:NO];
}



-(void)sendtxtmsg:(NSString *)msg
{
    QQApiTextObject* txtObj;
    SendMessageToQQReq* req;
    txtObj = [QQApiTextObject objectWithText:msg];
    req = [SendMessageToQQReq reqWithContent:txtObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    

}
- (void) sendNewMsg:(NSString *)strurl pngname:(NSData *)imgdata title:(NSString*)title desc:(NSString *)desc
{

        if(![TencentOAuth iphoneQQInstalled ])
            return;
    
         NSURL* url = [NSURL URLWithString:strurl];
//    NSURL *imgurl = [NSURL URLWithString:@"http://imgqn.koudaitong.com/upload_files/2015/04/30/FtsiIKONm115k2eqHFRK1NDX-nuy.jpg!490x490+2x.jpg"];
    
         QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:title description:desc previewImageData:imgdata];
    
//             QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:title description:desc previewImageURL:imgurl];
    
    
         SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
         
         QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            NSLog(@"%@",self);
}







-(void)sendQQWPA:(NSString *)qqid
{
    QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin:qqid];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
}
-(void)addQQfriend
{
    QQApiAddFriendObject *addQQobject = [[QQApiAddFriendObject alloc] initWithOpenID:openid];
    addQQobject.description = @"好朋友";
    addQQobject.subID = nil;
    addQQobject.remark = @"好朋友";
    SendMessageToQQReq* req = [SendMessageToQQReq
                               reqWithContent:addQQobject];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
}


#pragma mark QQ认证回调

-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"%@",response.jsonResponse);
    
//    figureurl_qq_2,nickname
    NSDictionary *d = response.jsonResponse;
    NSString *qqimg = [d objectForKey:@"figureurl_qq_2"];
    NSString *qqname = [d objectForKey:@"nickname"];
    [delegate loginSuccess:qqname qqimg:qqimg];
}

-(void)tencentDidLogin
{
    NSLog(@"登录完成");
    NSLog(@"qqtoekn %@",oauth.accessToken);
    NSLog(@"qqopenid %@",oauth.openId);

    if (! [oauth getUserInfo])
        [delegate loginFail];
    
    
}
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录tencentDidNotLogin");
    [delegate loginFail];
}

-(void)tencentDidNotNetWork
{
    [delegate loginFail];
}


@end
