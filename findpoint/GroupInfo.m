//
//  GroupInfo.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/5.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "GroupInfo.h"


static GroupInfo *groupinfo;
@implementation GroupInfo
@synthesize GroupCount;

+(instancetype)getInstancet
{
    if (!groupinfo)
    {
        groupinfo=[[GroupInfo alloc] init];
        
    }
    
    return groupinfo;
}


-(instancetype)init
{
    self=[super init];
    
    groups=[[NSMutableDictionary alloc] init];
    
    return self;
}


-(BOOL)CheckGroup:(NSString *)key
{
    return [[groups allKeys]containsObject:key];
}

-(void)addgroupInfo:(NSDictionary *)grouparry
{
    [groups setObject: grouparry forKey:[grouparry  objectForKey:@"CHID"]];
    GroupCount = (uint)[groups count];
}

-(void)clearGroups
{
    [groups removeAllObjects];
}

-(NSDictionary *)getGroupForindex:(int)index
{
    
    
    return [groups objectForKey:[[groups allKeys] objectAtIndex:index]];
}


-(NSDictionary *)getGroupForGroupid:(NSString *)groupid
{
    return [groups objectForKey:groupid];
}

-(NSInteger)getChannels
{
    return [groups count];
}

@end
