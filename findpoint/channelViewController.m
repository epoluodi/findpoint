//
//  channelViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/1.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "channelViewController.h"

@interface channelViewController ()

@end

@implementation channelViewController

@synthesize navbar,table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    title = [[UINavigationItem alloc] init];
    
    
    leftButton = [[UIBarButtonItem alloc]
                  initWithTitle:@"创建"                                   style:UIBarButtonItemStyleBordered                                   target:self                                   action:@selector(leftbtn)];
    
    [title setLeftBarButtonItem:leftButton];
    
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"加入" style:UIBarButtonItemStyleBordered target:self action:@selector(rightbtn)];
    [title setRightBarButtonItem:rightButton animated:YES];
    
    [navbar pushNavigationItem:title animated:YES];
    
    refresh = [[UIRefreshControl alloc] init];
      refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"努力加载中……"];
    [refresh addTarget:self action:@selector(refreshlistchannel) forControlEvents:UIControlEventValueChanged];
    [table addSubview:refresh];
    
    
    // Do any additional setup after loading the view.
}



-(void)refreshlistchannel
{
    if (refresh.isRefreshing)
        NSLog(@"刷新频道列表");
}


-(void)leftbtn
{
   
}
-(void)rightbtn
{
    
    [self performSegueWithIdentifier:@"addchannel" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
