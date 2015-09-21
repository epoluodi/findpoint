//
//  channelCell.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/2.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface channelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelinfo;
@property (weak, nonatomic) IBOutlet UILabel *labelname;

-(void)hideLabelname;
-(void)setChannelidTextColor:(BOOL)check;

@end
