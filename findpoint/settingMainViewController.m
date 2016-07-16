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
#import "info.h"
#import "WebService.h"
#import "TencentClass.h"
#import "WeChatClass.h"
#import <Common/PublicCommon.h>


@interface settingMainViewController ()
{
    NSUserDefaults *userinfo;
    BOOL isloginQQ;
    SheetUI *shareview;
    UIAlertController *sharealert;
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
        case 2:
        shareview = [[SheetUI alloc] initclass:self];
        shareview.ISWEiBO=NO;
        shareview.IsQQ=NO;
        sharealert =  [shareview SHowSheet:nil];
        [self presentViewController:sharealert animated:YES completion:nil];
        break;
        case 3:
        [self showabout];
        break;
    }
}

-(void)showabout
{
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"关于" message:@"本APP主要用于旅行团队或者户外团队的多人定位管理，如有好的建议可以联系作者：epoluodi@163.com BY YXG \n 版权归作者所有" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
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
    
    NSDictionary *d ;
    
    
    d = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"logintype",
         [userinfo stringForKey:@"nickname"],@"nickname",[info getInstancent].uid,@"deviceid",
         [userinfo stringForKey:@"nickimage"],@"nickphotopath",
         [userinfo stringForKey:@"openId"],@"qqopenid",nil];
    
    WebService *web = [[WebService alloc] initUrl:UserCreate];
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQ, ^{
        BOOL r= [web UserCreateinfo:d];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *strmsg ;
            if (!r){
                strmsg = @"登录失败";
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:strmsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    });
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



#pragma mark 分享委托
-(void)setupshow
{
    
}
-(void)SetqueryParams:(int)type
{
    [sharealert dismissViewControllerAnimated:YES completion:nil];
    UIImage *img =[PublicCommon scaleToSize:[UIImage imageNamed:@"app_logo"] size:CGSizeMake(120, 120)];
    
    switch (type) {
        case 1:
        [[WeChatClass getInstance] sendLinkContent:@"点名APP 团队定位管理工具" Desc:@"专为旅行团队，户外团队设计的定位管理工具，支持集合点分享，位置反馈等功能" URL:@"https://itunes.apple.com/us/app/ding-dong-gu-piao-ge-ren-gu/id1114291111?l=zh&ls=1&mt=8" Image:img WXScene:WXSceneSession];
        
        break;
        case 2:
        [[WeChatClass getInstance] sendLinkContent:@"点名APP 团队定位管理工具" Desc:@"专为旅行团队，户外团队设计的定位管理工具，支持集合点分享，位置反馈等功能" URL:@"https://itunes.apple.com/us/app/ding-dong-gu-piao-ge-ren-gu/id1114291111?l=zh&ls=1&mt=8" Image:img WXScene:WXSceneTimeline];
        break;
        case 4:
        [[TencentClass getInstance] sendNewMsg:@"https://itunes.apple.com/us/app/ding-dong-gu-piao-ge-ren-gu/id1114291111?l=zh&ls=1&mt=8" pngname:UIImagePNGRepresentation(img) title:@"点名APP 团队定位管理工具" desc:@"专为旅行团队，户外团队设计的定位管理工具，支持集合点分享，位置反馈等功能"];
        
        break;
    }
}
-(void)cancelquery
{
    
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
