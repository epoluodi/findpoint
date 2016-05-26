//
//  ChannelMainCell.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/26.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelMainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backimg;

@property (weak, nonatomic) IBOutlet UILabel *channelname;
@property (weak, nonatomic) IBOutlet UILabel *channeladdres;
@property (weak, nonatomic) IBOutlet UILabel *channelpeoples;
@property (weak, nonatomic) IBOutlet UILabel *channelcreatetime;


@property (weak, nonatomic) IBOutlet UIImageView *channelonlinestate;
@property (weak, nonatomic) IBOutlet UILabel *channelstate;
@property (weak, nonatomic) IBOutlet UIImageView *channelstatebackimg;


@end
