//
//  WeChatClass.h
//  泽臻小店
//
//  Created by xiaoguang yang on 15-3-11.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"


@interface WeChatClass : NSObject <WXApiDelegate>

+(instancetype)getInstance;
+(BOOL)WxHandleOpenUrl:(WeChatClass *)wxclass url:(NSURL *)url;
-(void) onReq:(BaseReq*)req;
-(void) onResp:(BaseResp*)resp;


- (void) sendTextContent:(NSString *)strText WXScene:(enum WXScene)_scene;
-(void)sendLinkContent:(NSString *)strtitle Desc:(NSString *)strdesc URL:(NSString *)strurl
                 Image:(UIImage *)img WXScene:(enum WXScene)_scene;
-(void) sendImageContent:(UIImage *)img WXScene:(enum WXScene)_scene filepath:(NSString *)filepath title:(NSString *)title
                    desc:(NSString *)desc;

@end
