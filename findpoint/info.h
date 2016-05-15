//
//  info.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface info : NSObject
{
    NSUserDefaults *userinfo;
}
#pragma channel
@property (strong,nonatomic)UIImage *channelimage;
@property (strong,nonatomic)NSString *channelid;
@property (strong,nonatomic)NSString *channelname;
@property (assign) BOOL isopen;
@property (strong,nonatomic) NSString  *channelpwd;
@property (strong,nonatomic)NSString *loginer;
@property (strong,nonatomic)NSString *loginerid;
@property (strong,nonatomic) NSString *channelcreatedt;
@property (nonatomic) NSUInteger *channelcounts;
@property (strong,nonatomic) NSString *channeldesc;



#pragma Global
@property (strong,nonatomic) NSString *_Gchannelid;



@end
