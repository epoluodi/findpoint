//
//  SheetUI.h
//  VMTSAPP
//
//  Created by appie on 15-1-19.
//  Copyright (c) 2015年 Seuic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "ShareClass.h"


@interface SheetUI : NSObject
{
    NSObject<SHeeUIDelegate> *senderViwe;
  
    
}


@property BOOL IsQQ;
@property BOOL IsWX;
@property BOOL ISWEiBO;




-(id)initclass:(NSObject<SHeeUIDelegate> *) mainview;
-(id)initclass:(NSObject<SHeeUIDelegate> *) mainview wx:(BOOL)wx weibo:(BOOL)weibo qq:(BOOL)qq;
-(UIAlertController *)SHowSheet:(NSString *)Other;

@end
