//
//  MarkVIew.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/21.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CallOutView.h"

@interface MarkVIew : MAAnnotationView
{
    CallOutView *_calloutview;
    CALayer *_layergq;
}

@property (nonatomic, strong) UIImageView *nickimg;
@property (nonatomic,copy)NSString *openid;
@property (nonatomic,copy)NSString *username;
@property (assign) BOOL IsCustomCallout;
@property (weak,nonatomic)UIViewController *controllview;

-(void)setMeetingimg:(UIImage *)img;
-(void)startAnimiation;
-(void)stopAnimation;
@end
