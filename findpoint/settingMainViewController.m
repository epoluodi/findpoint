//
//  settingMainViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/18.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "settingMainViewController.h"
#import "SettingCell.h"
#import "Common.h"

@interface settingMainViewController ()
{
    NSUserDefaults *userinfo;
    BOOL isloginQQ;
}
@end

@implementation settingMainViewController
@synthesize nickname,nickimage,table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    nickimage.layer.cornerRadius = 40;
    nickimage.layer.borderColor=[[UIColor whiteColor]CGColor];
    nickimage.layer.borderWidth=0.8f;
    nickimage.layer.masksToBounds=YES;
    

    userinfo = [NSUserDefaults standardUserDefaults];
    isloginQQ =[userinfo boolForKey:@"isregister"];
 
    
    
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
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell =(SettingCell*) [table dequeueReusableCellWithIdentifier:@"cell"];
    switch (indexPath.row) {
        case 0:
            cell.SettingTypeEmun=QQ;
            [cell initview];
            if (isloginQQ)
            {
                cell.labstate.text=@"已登录";
                nickname.text = [userinfo stringForKey:@"nickname"];
                NSString *imgfile =[userinfo stringForKey:@"nickimage"];
                NSURL *url = [NSURL URLWithString:imgfile];
                NSData *jpg = [Common downloadfile:url];
                if (jpg){
                    UIImage *img = [UIImage imageWithData:jpg];
                    nickimage.image=img;
                }
            }
            break;
        case 1:
            cell.SettingTypeEmun=GPS;
              [cell initview];
            break;
        case 2:
            cell.SettingTypeEmun=SHAREAPP;
              [cell initview];
            break;
        case 3:
            cell.SettingTypeEmun=ABOUTAPP;
              [cell initview];
            break;
    }
  
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *v = [[UIView alloc] init];
    v.frame=cell.contentView.frame;
    v.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.4];
    cell.selectedBackgroundView=v;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:
            if (![TencentClass checkQQ])
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你没有安装QQ客户端,无法进行QQ登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            [TencentClass getInstance].delegate=self;
            [[TencentClass getInstance] LoginQQ];
            
            break;
        case 1:
            [self performSegueWithIdentifier:@"showgps" sender:self];
            break;

    }
}



#pragma mark -



#pragma mark qqdelegate
-(void)loginFail
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"QQ登录失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
    SettingCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.labstate.text=@"未登录";
    [userinfo setBool:NO forKey:@"isregister"];//是否注册

    
}

-(void)loginSuccess:(NSString *)QQnick qqimg:(NSString *)qqimg
{
    
    nickname.text=QQnick;
    NSURL *url = [NSURL URLWithString:qqimg];
    NSData *jpg = [Common downloadfile:url];
    if (jpg){
        UIImage *img = [UIImage imageWithData:jpg];
        nickimage.image=img;
        [Common SavePNGtoJpg:jpg filename:[TencentClass getInstance].oauth.openId];
    }
    SettingCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.labstate.text=@"已登录";
    [userinfo setBool:YES forKey:@"isregister"];//是否注册Q
    [userinfo setObject:qqimg forKey:@"nickimage"];//当前头像
    [userinfo setObject:QQnick forKey:@"nickname"];//当前 名称
    

}

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
