//
//  CustomerPointAnnotaton.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/20.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomerPointAnnotaton : MAPointAnnotation

@property (copy,nonatomic)NSDictionary *gpsinfo;
@property (copy,nonatomic)NSString *uid;

@end
