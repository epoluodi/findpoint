//
//  addchannel.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/1.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
#import "MBProgressHUD.h"
#import "channelViewController.h"

@interface addchannel : UIViewController<UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,AlertViewDelegate,UIAlertViewDelegate>
{
    UINavigationItem *title;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    MBProgressHUD *HUD;
    UIButton *selectbtn;
    int selectimage;
    UIAlertAction *selectchannelimage;
}


@property (weak, nonatomic) IBOutlet UIImageView *channelimage;

@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
