//
//  SettingCell.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell
@synthesize SettingTypeEmun,labstate,labtitle,img;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
}


-(void)initview{
    switch (SettingTypeEmun) {
        case QQ:
            
            img.image = [UIImage imageNamed:@"QQ"];
            labtitle.text=@"QQ登录";
            labstate.text=@"未登录";
            
            break;
        case MARKCOLOR:
            
            img.image = [UIImage imageNamed:@"color"];
            labtitle.text=@"坐标颜色";
            labstate.text=@"";
            labstate.backgroundColor=[UIColor redColor];
            
            break;
        case GPS:
            
            img.image = [UIImage imageNamed:@"gps"];
            labtitle.text=@"定位信息";
            labstate.hidden=YES;
            
            
            break;
        case SHAREAPP:
            
            img.image = [UIImage imageNamed:@"share"];
            labtitle.text=@"分享APP";
            labstate.hidden=YES;
            
            
            break;
        case ABOUTAPP:
            
            img.image = [UIImage imageNamed:@"about"];
            labtitle.text=@"关于APP";
            labstate.hidden=YES;
            
            break;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
