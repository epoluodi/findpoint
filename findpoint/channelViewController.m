//
//  channelViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/1.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "channelViewController.h"
#import "MBProgressHUD.h"
#import "WebService.h"
#import "ChannelMainCell.h"
#import "GroupInfo.h"


@interface channelViewController ()
{
    WebService *web;
    MBProgressHUD *hud;
    dispatch_queue_t globalQ;
    dispatch_queue_t mainQ;
}
@end

@implementation channelViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    mainQ = dispatch_get_main_queue();
    
    
    title = [[UINavigationItem alloc] init];
    
    
    leftButton = [[UIBarButtonItem alloc]
                  initWithTitle:@"创建"                                   style:UIBarButtonItemStyleBordered                                   target:self                                   action:@selector(leftbtn)];
    
    [title setLeftBarButtonItem:leftButton];
    
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"加入" style:UIBarButtonItemStyleBordered target:self action:@selector(rightbtn)];
    [title setRightBarButtonItem:rightButton animated:YES];
    title.title = @"团队列表";
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar pushNavigationItem:title animated:YES];
    
    refresh = [[UIRefreshControl alloc] init];
      refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"努力加载中……"];
    [refresh addTarget:self action:@selector(refreshlistchannel) forControlEvents:UIControlEventValueChanged];
    [table addSubview:refresh];
    
    UINib *nib = [UINib nibWithNibName:@"channelmaincell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    table.delegate=self;
    table.dataSource=self;
    
    
//    hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
    
    [refresh beginRefreshing];
    [self refreshlistchannel];
    
    // Do any additional setup after loading the view.
}




//下啦刷新
-(void)refreshlistchannel
{
    if (refresh.isRefreshing){
    
        
        dispatch_async(globalQ, ^{
            web = [[WebService alloc] initUrl:getselfchannelurl];
            __block NSArray *arry = [web getMyChannel];
            NSLog(@"获得当前用户通道 : %@",arry);
            if (arry)
            {
                [[GroupInfo getInstancet] clearGroups];
                for (NSDictionary *d in arry) {
                    [[GroupInfo getInstancet] addgroupInfo:d];
                }
            }
            dispatch_async(mainQ, ^{
                [refresh endRefreshing];
          
                if ([GroupInfo getInstancet].GroupCount==0)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"目前没有加入到任何团队中！！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    return ;
                }
                else
                    [table reloadData];
                
                
            });
            
        });
        
    }
}


///刷新列表
-(void)refreshchanncellist
{
    
}

#pragma mark table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [GroupInfo getInstancet].GroupCount;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *v = [[UIView alloc] init];
    v.frame = cell.contentView.frame;
    v.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.1];
    cell.selectedBackgroundView=v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelMainCell *cell = (ChannelMainCell*)[table dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *d = [[GroupInfo getInstancet] getGroupForindex:indexPath.row];
    
   
    cell.channelname.text = [d objectForKey:@"CHNAME"];
    cell.channelpeoples.text = [NSString stringWithFormat:@"人数:%@", [d objectForKey:@"PEOPLES"] ];
    cell.channelcreatetime.text = [NSString stringWithFormat:@"创建时间:%@", [d objectForKey:@"CDT"] ];
    
    
    if (![[d objectForKey:@"ISOPEN"] isEqualToString:@"1"])
    {
        cell.channelstatebackimg.image = [UIImage imageNamed:@"lock"];
        cell.channelstate.text = @"非公开";
        cell.channelstate.textColor=[UIColor yellowColor];
    }
    else{
        cell.channelstatebackimg.image = [UIImage imageNamed:@"open"];
        cell.channelstate.text = @"公开";
        cell.channelstate.textColor=[UIColor greenColor];
    }
    
    cell.channeladdres.text = [NSString stringWithFormat:@"活动区域:%@", [d objectForKey:@"CHAREA"] ];
    
    [cell showbackimg:[d objectForKey:@"CPHOTO"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
          [self performSegueWithIdentifier:@"showchannel" sender:self];
}





-(void)leftbtn
{
       [self performSegueWithIdentifier:@"addchannel" sender:self];
}
-(void)rightbtn
{
           [self performSegueWithIdentifier:@"showjoin" sender:self];

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
