//
//  channelViewController.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/1.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface channelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UINavigationItem *title;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    UIRefreshControl *refresh;
    NSString *selectchid;
    NSString *selectmediaid;
}


@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak,nonatomic ,readonly) UIRefreshControl *RefreshList;


-(void)refreshlistchannel;

@end
