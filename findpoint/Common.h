//
//  Common.h
//  VMTSAPP
//
//  Created by appie on 15-1-6.
//  Copyright (c) 2015年 Seuic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//openssl x509 -in aps.cer -inform DER -out aps.pem -outform PEM
//openssl pkcs12 -nocerts -out Push.pem -in push.p12
//openssl pkcs12 -export -in aps.pem -inkey Push.pem -certfile yang.certSigningRequest -name "aps" -out aps.p12



///定义不同机型
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhonePod ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
struct Deviceinfo
{
   __unsafe_unretained NSString * dname;
   __unsafe_unretained NSString * dmodel;
    
} ;




#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface Common : NSObject


+ (NSString *) base64StringFromData: (NSData *)data length: (int)length;

+(void)SavePNGtoJpg:(NSData *)data filename:(NSString *)filename;
+(NSData *)downloadfile:(NSURL *)url;
@end

@protocol queryparams

-(void)setupshow;
-(void)cancelquery;
-(void)SetqueryParams:(int)type;
@end

