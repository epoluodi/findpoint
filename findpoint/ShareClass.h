//
//  ShareClass.h
//  ShareClass
//
//  Created by xiaoguang yang on 15/5/21.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SHeeUIDelegate

-(void)setupshow;
-(void)cancelquery;
-(void)SetqueryParams:(int)type;
@end