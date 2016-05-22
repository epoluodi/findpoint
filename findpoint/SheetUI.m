//
//  SheetUI.m
//  VMTSAPP
//
//  Created by appie on 15-1-19.
//  Copyright (c) 2015年 Seuic. All rights reserved.
//

#import "SheetUI.h"

@implementation SheetUI
@synthesize IsQQ;
@synthesize ISWEiBO;
@synthesize IsWX;

//初始化
-(id)initclass:(NSObject<SHeeUIDelegate> *)mainview
{
    return [self initclass:mainview wx:YES weibo:YES qq:YES];
}
-(id)initclass:(NSObject<SHeeUIDelegate> *)mainview wx:(BOOL)wx weibo:(BOOL)weibo qq:(BOOL)qq
{
    senderViwe = mainview;
    IsWX=wx;
    ISWEiBO=weibo;
    IsQQ=qq;
    return [super init];
}

-(UIAlertController*)SHowSheet:(NSString *)Other
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        alert.title=@"分享信息";
    UIAlertAction *action1;
    UIAlertAction *action2;
  
    
  
    action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action) {
            [senderViwe cancelquery];
        NSLog(@"cancle action");
    }];
         [alert addAction:action1];
    
    if (Other != nil)
    {
    action2 = [UIAlertAction actionWithTitle:Other style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {
            
            
            [senderViwe setupshow];
            NSLog(@"other action");
        }];

        [alert addAction:action2];
    }
    
    

    
//    CGFloat width = [Common GetScreen].size.width;
//    
//    width = width /2 /2;
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    CGRect newframe  = CGRectMake(0, 0, alert.view.frame.size.width, 100);
    scrollview.frame=   newframe;
    scrollview.pagingEnabled=NO;
    scrollview.bounces=YES;
    scrollview.contentSize = CGSizeMake(321,  0);
    scrollview.scrollEnabled=YES;
    scrollview.showsHorizontalScrollIndicator=YES;

    
    UIButton *btn_sender =[[UIButton alloc] init];
    UIButton *btn_link =[[UIButton alloc] init];
    UIButton *btn_Fav =[[UIButton alloc] init];
    
    UIButton *btn_weibo =[[UIButton alloc] init];
    UIButton *btn_qq =[[UIButton alloc] init];
 

  
    
    
    [btn_sender setBackgroundImage:[UIImage imageNamed:@"png.bundle/wx"] forState:UIControlStateNormal];
    [btn_link setBackgroundImage:[UIImage imageNamed:@"png.bundle/moments"] forState:UIControlStateNormal];
    
    [btn_Fav setBackgroundImage:[UIImage imageNamed:@"png.bundle/collect"] forState:UIControlStateNormal];
        [btn_weibo setBackgroundImage:[UIImage imageNamed:@"png.bundle/weibo48"] forState:UIControlStateNormal];
    [btn_qq setBackgroundImage:[UIImage imageNamed:@"png.bundle/QQ"] forState:UIControlStateNormal];
    
    
    
    btn_sender.frame = CGRectMake(20, 30, 45, 45);
    [btn_sender setTitle:@"微信好友" forState:UIControlStateNormal];
    
    [btn_sender setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btn_sender.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    [btn_sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn_sender addTarget:self action:@selector(senderwechat) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    btn_link.frame = CGRectMake(btn_sender.frame.origin.x + 45 + 10, 30, 45, 45);
    [btn_link.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [btn_link setTitle:@"朋友圈" forState:UIControlStateNormal];
    [btn_link setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btn_link setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn_link addTarget:self action:@selector(linkwechat) forControlEvents:UIControlEventTouchUpInside];
    
    
    btn_Fav.frame = CGRectMake(45 + btn_link.frame.origin.x +10, 30, 45, 45);
    [btn_Fav.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [btn_Fav setTitle:@"收藏" forState:UIControlStateNormal];
    [btn_Fav setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btn_Fav setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn_Fav addTarget:self action:@selector(favwechat) forControlEvents:UIControlEventTouchUpInside];
    
    btn_weibo.frame = CGRectMake(45 + btn_Fav.frame.origin.x +10, 30, 45, 45);
    [btn_weibo.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [btn_weibo setTitle:@"微博" forState:UIControlStateNormal];
    [btn_weibo setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btn_weibo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn_weibo addTarget:self action:@selector(weibo)
        forControlEvents:UIControlEventTouchUpInside];
    
    
    btn_qq.frame = CGRectMake(45 + btn_link.frame.origin.x +10, 30, 45, 45);
    [btn_qq.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [btn_qq setTitle:@"QQ分享" forState:UIControlStateNormal];
    [btn_qq setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btn_qq setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn_qq addTarget:self action:@selector(appwechat) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (IsWX){
        [scrollview addSubview:btn_sender];
        [scrollview addSubview:btn_link];
//        [scrollview addSubview:btn_Fav];
    }
    if (IsQQ)
        [scrollview addSubview:btn_qq];
    if (ISWEiBO)
        [scrollview addSubview:btn_weibo];

    [alert.view addSubview:scrollview];

    
    //自定义搜索界面
    return alert;
    
}


-(void)senderwechat
{
    [senderViwe SetqueryParams:1];
    
}

-(void)linkwechat
{
    [senderViwe SetqueryParams:2];
}
-(void)favwechat
{
    [senderViwe SetqueryParams:3];
}
-(void)weibo
{
    [senderViwe SetqueryParams:5];
}
-(void)appwechat
{
    [senderViwe SetqueryParams:4];
}


@end

