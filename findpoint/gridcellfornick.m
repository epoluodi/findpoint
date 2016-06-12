//
//  gridcellfornick.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/9.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "gridcellfornick.h"

@implementation gridcellfornick
@synthesize img = niciimg,name;

-(void)awakeFromNib
{
    niciimg.layer .cornerRadius=niciimg.frame.size.width/2;
    niciimg.layer.borderWidth=0.5f;
    niciimg.layer.borderColor=[[UIColor whiteColor] CGColor];
    niciimg.layer.masksToBounds=YES;
    name.text=@"-";
    UIView *v =[[UIView alloc] init];
    v.frame = self.frame;
    [v setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    v.layer .cornerRadius=6;
    v.layer.borderWidth=0.5f;
    v.layer.borderColor=[[UIColor whiteColor] CGColor];
    v.layer.masksToBounds=YES;
    self.selectedBackgroundView =v;
    name.textColor=[UIColor whiteColor];
    niciimg.image=nil;
}

-(void)showNickImg:(NSString *)strurl
{
    
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(globalQ, ^{
          NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strurl] ];
     
        dispatch_async(mainQ, ^{
            if (!data){
                niciimg.image = [UIImage imageNamed:@"app_logo"];
                return ;
            }
            UIImage *img = [UIImage imageWithData:data];
            [self displayAnim];
            niciimg.image = img;
        });
        
    });
    

}


-(void)displayAnim
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration=0.6;
//    scaleAnimation.beginTime=CACurrentMediaTime();
    [niciimg.layer addAnimation:scaleAnimation forKey:nil];
}
@end
