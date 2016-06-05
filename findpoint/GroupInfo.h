//
//  GroupInfo.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/5.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupInfo : NSObject
{
    NSMutableDictionary *groups;
    
    
}

@property (assign)uint GroupCount;



//单例模式
+(instancetype)getInstancet;
//获得通道信息
-(NSDictionary *)getGroupForGroupid:(NSString *)groupid;
//检查通道
-(BOOL)CheckGroup:(NSString *)key;
-(NSDictionary *)getGroupForindex:(int)index;
//添加通道
-(void)addgroupInfo:(NSDictionary *)grouparry;
-(void)clearGroups;

@end
