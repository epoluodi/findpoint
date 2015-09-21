//
//  LoginAndRegView.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/24.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "LoginAndRegView.h"

@interface LoginAndRegView ()


@end

@implementation LoginAndRegView
@synthesize CMSCView;
@synthesize navbar;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_back"]]];
    
    title = [[UINavigationItem alloc] init];
    title.title=@"登录";
    
    leftButton = [[UIBarButtonItem alloc]
                  initWithTitle:@"取消"                                   style:UIBarButtonItemStyleBordered                                   target:self                                   action:@selector(leftbtn)];
    
    [title setLeftBarButtonItem:leftButton];
    
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"其它登录" style:UIBarButtonItemStyleBordered target:self action:@selector(rightbtn)];
    [title setRightBarButtonItem:rightButton animated:YES];
    
    
    [navbar setBackgroundImage:[UIImage imageNamed:@"login_back"] forBarMetrics:UIBarMetricsDefault];
    
    [navbar pushNavigationItem:title animated:YES];
    
    
    
    
    
//    loginview = [[LoginView alloc] init];
//    regview = [[RegView alloc] init:self];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:loginview options:nil];
    
    //得到第一个UIView
    loginview = [nib objectAtIndex:0];
    
    
     nib = [[NSBundle mainBundle]loadNibNamed:@"RegView" owner:regview options:nil];
    regview = [nib objectAtIndex:0];
    [regview setMainView:self];
    //得到第一个UIView
//    regview = (RegView *)[nib objectAtIndex:0];
    
    CMSCView.primaryView =loginview;
    CMSCView.secondaryView =regview;
    [CMSCView setSpinTime:1];
    
    
    // Do any additional setup after loading the view.
}


-(void)leftbtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightbtn
{
    if (CMSCView.getprimaryView)
    {
        rightButton.title = @"其它登录";
        
    }
    else
    {
        rightButton.title=@"账号登录";
    }
    [CMSCView flipTouched:self];
    
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
