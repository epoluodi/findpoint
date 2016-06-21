//
//  MarkVIew.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/21.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MarkVIew : MAAnnotationView

@property (nonatomic, strong) UIImageView *nickimg;
@property (nonatomic,copy)NSString *openid;
@property (nonatomic,copy)NSString *username;

@end
