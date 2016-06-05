//
//  ChannelMainCell.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/26.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "ChannelMainCell.h"
#import <Common/FileCommon.h>
#import "WebService.h"

@implementation ChannelMainCell
@synthesize backimg,channelonlinestate,channelstatebackimg;
@synthesize channelname,channelstate,channeladdres,channelpeoples,channelcreatetime;
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    // Initialization code
}

-(void)showbackimg:(NSString *)mediaid
{
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    
    dispatch_async(globalQ, ^{
        NSString *path = [FileCommon getCacheDirectory];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *filename = [NSString stringWithFormat:@"%@.png",mediaid];
        NSString* _filename = [path stringByAppendingPathComponent:filename];
        if ([fm fileExistsAtPath:_filename])
        {
            NSData *pngdata = [NSData dataWithContentsOfFile:_filename];
            if (pngdata)
            {
                dispatch_async(mainQ, ^{
                    
                    [self showimganim:[UIImage imageWithData:pngdata]];
                  
                    return;
                });
            }
        }
        else
        {
            NSString *pngpath  = [NSString stringWithFormat:@"%@?mediaid=%@",downloadjpg,mediaid];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pngpath] ];
            if (data)
            {
                [fm createFileAtPath:_filename contents:data attributes:nil];
            }
            
            dispatch_async(mainQ, ^{
                
                if (!data)
                    return ;
                [self showimganim:[UIImage imageWithData:data]];

            });
        }
    });
 
    
    
}


-(void)showimganim:(UIImage *)img
{
    [UIView beginAnimations:@"chanege" context:nil];
    //动画持续时间
    [UIView setAnimationDuration:0.5f];
    
    //设置动画曲线，控制动画速度
    [UIView  setAnimationCurve: UIViewAnimationCurveEaseInOut];
    //设置动画方式，并指出动画发生的位置
    //        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:channelimage  cache:YES];
    //提交UIView动画
    [backimg setAlpha:0.0];
    backimg.image =  img;
    [backimg setAlpha:0.2];
    
    [UIView commitAnimations];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
