//
//  WeChatClass.m
//  泽臻小店
//
//  Created by xiaoguang yang on 15-3-11.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import "WeChatClass.h"
#import "AppDelegate.h"
@implementation WeChatClass


static WeChatClass *_WebChatClass;

+(instancetype)getInstance
{
    if (!_WebChatClass)
    {
        _WebChatClass = [[WeChatClass alloc] init];
        
    }
    
    return _WebChatClass;
}

+(BOOL)WxHandleOpenUrl:(WeChatClass *)wxclass url:(NSURL *)url
{
    BOOL ret =[WXApi handleOpenURL:url delegate:wxclass];
    NSLog(@"微信打开 HandleOpenUrl : %d",ret);
    return ret;
    
}


-(instancetype)init
{
    self = [super init];
    [WXApi registerApp:WXKEY];
    
    return self;
}


-(void) onReq:(BaseReq*)req
{
    return;
}


-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        NSLog(@"%@-%@",strTitle,strMsg);
        

    }
}


-(void) sendImageContent:(UIImage *)img WXScene:(enum WXScene)_scene filepath:(NSString *)filepath title:(NSString *)title
                    desc:(NSString *)desc

{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:img];
    
    WXImageObject *ext = [WXImageObject object];

    ext.imageData = [NSData dataWithContentsOfFile:filepath];
    
    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    //    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    //    ext.imageData = UIImagePNGRepresentation(image);
    message.title = title;
     message.description = desc;
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}
///发送文字消息
- (void) sendTextContent:(NSString *)strText WXScene:(enum WXScene)_scene
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = strText;
    req.bText = YES;
    req.scene = _scene;
    [WXApi sendReq:req];
}

///发送图文链接消息
- (void) sendLinkContent:(NSString *)strtitle Desc:(NSString *)strdesc URL:(NSString *)strurl Image:(UIImage *)img WXScene:(enum WXScene)_scene
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = strtitle;
    message.description = strdesc;
    [message setThumbImage:img];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = strurl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}


@end
