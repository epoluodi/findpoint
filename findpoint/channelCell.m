//
//  channelCell.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "channelCell.h"

@implementation channelCell
@synthesize labelinfo;
@synthesize labelname;
- (void)awakeFromNib {
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:137/255 green:137/255 blue:137/255 alpha:0.1f];
    
    labelinfo.textColor = [UIColor whiteColor];
    labelname.textColor = [UIColor whiteColor];
    labelname.text=@"";
    
    
}

-(void)setChannelidTextColor:(BOOL)check
{
    if (check)
        labelname.textColor=[UIColor redColor];
    else
        labelname.textColor=[UIColor whiteColor];
}

-(void)hideLabelname
{
    [labelname removeFromSuperview];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
