//
//  MarkVIew.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/21.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "MarkVIew.h"

@implementation MarkVIew
@synthesize nickimg;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 40, 40);
        self.backgroundColor = [UIColor clearColor];
        /* Create portrait image view and add to view hierarchy. */
        nickimg = [[UIImageView alloc] initWithFrame:CGRectMake(0  , 0, 40, 40)];
        [self addSubview:nickimg];
        nickimg.layer.cornerRadius=15;
        nickimg.layer.masksToBounds=YES;
        self.layer.shadowRadius                  =5;
        self.layer.shadowColor                   =[[UIColor grayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity=0.7;
        self.draggable=YES;
        self.canShowCallout=YES;
        nickimg.image=[UIImage imageNamed:@"state3"];
    }

    return self;
}


-(void)startAnimiation
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame =CGRectMake(20.f,20.f, 25, 25);
    layer.borderColor=[[UIColor redColor] CGColor];
    layer.borderWidth = 1;
    layer.cornerRadius  = 12.5f;
    layer.masksToBounds=YES;
    layer.backgroundColor = [[UIColor clearColor] CGColor];
    layer.shadowColor=[[[UIColor blackColor] colorWithAlphaComponent:0.35f] CGColor];
    layer.shadowRadius = 6;
    layer.shadowOffset = CGSizeMake(5, 5);
    [self.layer addSublayer:layer];
    
    self.centerOffset =CGPointMake(-10, 0);
    
    CAKeyframeAnimation * keyanimation =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyanimation.duration = 0.8f;
    keyanimation.values = @[@0,@0.2,@0.5,@0.7,@1,@1.2,@1.4,@1.6,@1.8,@2];
    keyanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
 

    CAKeyframeAnimation * keyanimation2 =[CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyanimation2.duration = 0.8f;
    keyanimation2.values = @[@1,@0.9,@0.8,@0.7,@0.6,@0.5,@0.4,@0.3,@0.0];
    keyanimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.duration=0.8f;
    animationgroup.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationgroup.animations = @[keyanimation,keyanimation2];
    animationgroup.repeatCount=INT_MAX;
    
    [layer addAnimation:animationgroup forKey:nil];
    
}

@end
