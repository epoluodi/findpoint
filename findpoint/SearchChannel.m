//
//  SearchChannel.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/27.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "SearchChannel.h"
#import <Common/PublicCommon.h>
#import "MBProgressHUD.h"
#import "WebService.h"
#import "ChannelMainCell.h"
#import "GroupInfo.h"

@interface SearchChannel (){
    MBProgressHUD *hub;
    WebService *web;
    NSString *c_pwd ,*cid;
    AlertView *alert;
}

@end

@implementation SearchChannel
@synthesize searchview,table,memo;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"团队搜索";
 
    table.hidden=YES;
    memo.hidden=NO;
    searchview.delegate=self;
    searchview.placeholder=@"团队编号或者团队名称";
    searchview.inputAccessoryView = [PublicCommon getInputToolbar:self sel:@selector(closeinput)];
    resultrows=0;
    UINib *nib = [UINib nibWithNibName:@"channelmaincell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    [table setHidden:YES];
    table.delegate=self;
    table.dataSource=self;

    
    // Do any additional setup after loading the view.
}

//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchview resignFirstResponder];
    [self querychannel:searchview.text];
    
}


-(void)querychannel:(NSString *)key
{
    web = [[WebService alloc] initUrl:qurychannelurl];
    hub=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    [hub show:YES];
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
        resultlest = [web queryChannel:searchview.text];
        resultrows =[resultlest count];
        NSLog(@"搜索返回结果 %@",resultlest);
        dispatch_async(mainQ, ^{
            [hub hide:YES];
            
            if (resultrows!=0){
                [table setHidden:NO];
                [memo setHidden:YES];
                [table reloadData];
            }
            else
            {
                [table setHidden:YES];
                [memo setHidden:NO];
                [table reloadData];
            }
        });
        
        
        
    });
}


-(void)closeinput
{
    [searchview resignFirstResponder];
    if (![searchview.text isEqualToString:@""])
        [self querychannel:searchview.text];
}






#pragma mark table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultrows;
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
    NSDictionary *d = resultlest[indexPath.row];
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
    NSDictionary *d = resultlest[indexPath.row];
    cid =[d objectForKey:@"CHID"];
    if ( [[GroupInfo getInstancet] CheckGroup:cid] )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你已经加入该团队" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([[d objectForKey:@"ISOPEN"] isEqualToString:@"0"])
    {
        c_pwd= [d objectForKey:@"PWD"];
        alert = [[AlertView alloc] initwithTextfield:@"提示" message:@"请输入加入密码" inputtype:UIKeyboardTypeNumberPad];
        alert.delegate = self;
        [alert showAlert:self];
    }
    else
        [self joinchannel:cid];

    
}

-(void)onbtn:(NSMutableArray *)dataarary
{
    NSString *_pwd = dataarary[0];
    if ([_pwd isEqualToString:c_pwd])
    {
        [self joinchannel:cid];
        return;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
}

-(void)joinchannel:(NSString *)chid
{
    web = [[WebService alloc] initUrl:addchanneluser];
    hub=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    [hub show:YES];
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
        BOOL r= [web addChanneluser:chid];

        dispatch_async(mainQ, ^{
            [hub hide:YES];
            
            if (r){
                NSLog(@"加入成功");
                [_VC.RefreshList beginRefreshing];
                [_VC refreshlistchannel];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加入失败，请重新尝试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return ;
            }
        });
        
        
        
    });
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
