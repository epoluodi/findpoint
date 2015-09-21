//
//  LoginAndRegView.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/24.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMSCoinView.h"
#import "LoginView.h"
#import "RegView.h"

@interface LoginAndRegView : UIViewController
{
    LoginView * loginview;
    RegView *regview;
    
    UINavigationItem *title;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    
    
}



@property (weak, nonatomic) IBOutlet CMSCoinView *CMSCView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;


@end
