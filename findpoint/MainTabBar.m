//
//  MainTabBar.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/22.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "MainTabBar.h"

@interface MainTabBar ()

@end

@implementation MainTabBar


- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.tabBar.tintColor=[UIColor greenColor];

    self.tabBar.barStyle=UIBarStyleBlack;
//    self.tabBar.backgroundImage =[UIImage imageNamed:@"settingbackimg"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
