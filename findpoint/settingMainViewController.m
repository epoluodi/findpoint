//
//  settingMainViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/18.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "settingMainViewController.h"
#import "SettingCell.h"
@interface settingMainViewController ()

@end

@implementation settingMainViewController
@synthesize nickname,nickimage,table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSettingTable];
    // Do any additional setup after loading the view.
}



-(void)initSettingTable
{
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor=[UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"settingcell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
}



#pragma mark 初始化table

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v=[[UIView alloc] init];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell =(SettingCell*) [table dequeueReusableCellWithIdentifier:@"cell"];
    switch (indexPath.row) {
        case 0:
            cell.SettingTypeEmun=QQ;
            
            break;
        case 1:
            cell.SettingTypeEmun=MARKCOLOR;
            
            break;
        case 2:
            cell.SettingTypeEmun=GPS;
            
            break;
        case 3:
            cell.SettingTypeEmun=SHAREAPP;
            
            break;
        case 4:
            cell.SettingTypeEmun=ABOUTAPP;
            
            break;
    }
    [cell initview];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *v = [[UIView alloc] init];
    v.frame=cell.contentView.frame;
    v.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.4];
    cell.selectedBackgroundView=v;
}

#pragma mark -


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
