//
//  gridcellfornick.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/9.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "gridcellfornick.h"

@implementation gridcellfornick
@synthesize img,name;

-(void)awakeFromNib
{
    img.layer .cornerRadius=img.frame.size.width/2;
    img.layer.borderWidth=0.5f;
    img.layer.borderColor=[[UIColor whiteColor] CGColor];
    img.layer.masksToBounds=YES;
    name.text=@"-";
    UIView *v =[[UIView alloc] init];
    v.frame = self.frame;
    [v setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    v.layer .cornerRadius=6;
    v.layer.borderWidth=0.5f;
    v.layer.borderColor=[[UIColor whiteColor] CGColor];
    v.layer.masksToBounds=YES;
    self.selectedBackgroundView =v;
}




-(void)displayAnim
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration=0.4;
    scaleAnimation.beginTime=CACurrentMediaTime()+1;
    [img.layer addAnimation:scaleAnimation forKey:nil];
}
@end
