//
//  SettingCell.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>



enum SettingType
{
    QQ,MARKCOLOR,GPS,SHAREAPP,ABOUTAPP,
};


@interface SettingCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *labtitle;
@property (weak, nonatomic) IBOutlet UILabel *labstate;
@property (assign)enum SettingType SettingTypeEmun;

-(void)initview;
@end
