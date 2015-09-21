//
//  settingMainViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/18.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "settingMainViewController.h"

@interface settingMainViewController ()

@end

@implementation settingMainViewController
@synthesize tableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inittableview];
    // Do any additional setup after loading the view.
}


-(void)inittableview
{
    tableview.delegate=self;
    tableview.dataSource=self;
    [tableview setBackgroundColor:[UIColor clearColor]];
    [tableview reloadData];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"账号信息";

            break;
        case 1:
            cell.textLabel.text = @"通知管理";
            
            break;
        case 2:
            cell.textLabel.text = @"GPS信息";
            
            break;
        case 3:
            cell.textLabel.text = @"分享应用";
            
            break;
        case 4:
            cell.textLabel.text = @"联系作者";
     
            break;
        case 5:
            cell.textLabel.text = @"关于";
            
            break;
            
    }

    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *viwe=[[UIView alloc] init];
    viwe.backgroundColor=[UIColor clearColor];
    return viwe;
}





-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *story;
//    LoginAndRegView *loginandregview;
    switch (indexPath.row) {
        case 0:
            
            [self performSegueWithIdentifier:@"account" sender:self];
            
//            story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//            
//            loginandregview = [story instantiateViewControllerWithIdentifier:@"reg1"];
//            
//            
//       
//            [self presentViewController:loginandregview animated:YES completion:nil];
            break;
        case 1:
             [self performSegueWithIdentifier:@"tongzhi" sender:self];
            
        
            break;
        case 3:
           
            break;
    }
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
