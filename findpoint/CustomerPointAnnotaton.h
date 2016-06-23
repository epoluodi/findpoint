//
//  CustomerPointAnnotaton.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/20.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomerPointAnnotaton : NSObject<MAAnnotation>

@property (copy,nonatomic)NSString *uid;
@property (copy,nonatomic)NSDictionary *data;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;


@end
