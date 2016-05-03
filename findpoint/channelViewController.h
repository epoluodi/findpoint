//
//  channelViewController.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/1.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface channelViewController : UIViewController
{
    UINavigationItem *title;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    UIRefreshControl *refresh;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;



-(void)refreshlistchannel;

@end
