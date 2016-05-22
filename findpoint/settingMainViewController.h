//
//  settingMainViewController.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/18.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAndRegView.h"
#import "TencentClass.h"
#import "SheetUI.h"
@interface settingMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,QQDelegate,SHeeUIDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *nickimage;
@property (weak, nonatomic) IBOutlet UILabel *nickname;

@property (weak, nonatomic) IBOutlet UITableView *table;

@end
