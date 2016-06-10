//
//  ChannelInfoController.h
//  findpoint
//
//  Created by 程嘉雯 on 16/6/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/PublicCommon.h>
#import "channelViewController.h"

@interface ChannelInfoController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIBarButtonItem *rightButton;
    NSDictionary *groupinfo;
    int membercount;
    NSArray *memberlist;
}

@property (weak, nonatomic) IBOutlet UIButton *btnexit;
@property (weak, nonatomic) IBOutlet UICollectionView *grid;
@property (weak,nonatomic) channelViewController *VC;

@property (weak, nonatomic) IBOutlet UIImageView *backimg;

@property (weak, nonatomic) IBOutlet UILabel *channelname;
@property (weak, nonatomic) IBOutlet UILabel *members;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *memo;

@property (weak,nonatomic) NSString *ChannelID;


@end
