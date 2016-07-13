//
//  CustomerPointAnnotaton.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/20.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MarkVIew.h"

@interface CustomerPointAnnotaton : NSObject<MAAnnotation>

@property (copy,nonatomic)NSString *uid;
@property (copy,nonatomic)NSDictionary *data;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (weak,nonatomic)NSString *creater;
@property (nonatomic, copy) NSString *img;
@property (weak,nonatomic)MarkVIew *markview;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic)NSString *identity;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

//-(instancetype)getShadowRadiu;
@end
