//
//  MarkVIew.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/21.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//
#define kWidth  150.f
#define kHeight 60.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   240.0
#define kCalloutHeight  120.0
#import "MarkVIew.h"

@implementation MarkVIew
@synthesize nickimg;
@synthesize IsCustomCallout;
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
        IsCustomCallout = NO;
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

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [_calloutview pointInside:[self convertPoint:point toView:_calloutview] withEvent:event];
    }
    
    return inside;
}

-(void)setMeetingimg:(UIImage *)img
{
    [_calloutview setMeetingimg:img];
}
-(void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    if (selected){
        if (IsCustomCallout)
        {
            if (!_calloutview)
            {
                _calloutview = [[CallOutView alloc] init];
                _calloutview.frame =CGRectMake(0, 0, kCalloutWidth, kCalloutHeight);
                _calloutview.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(_calloutview.bounds) / 2.f + self.calloutOffset.y);
            }
            _calloutview.controllview=_controllview;
            _calloutview.alpha=0;
            [self addSubview:_calloutview];
            [_calloutview initview:nil];
            [_calloutview startanimation];

        }
    }
    else
    {
        [_calloutview removeFromSuperview];
    }
    [super setSelected: selected animated:animated];
}


-(void)startAnimiation
{
    _layergq = [[CALayer alloc] init];
    _layergq.frame =CGRectMake(20.f,20.f, 25, 25);
    _layergq.borderColor=[[UIColor redColor] CGColor];
    _layergq.borderWidth = 1;
    _layergq.cornerRadius  = 12.5f;
    _layergq.masksToBounds=YES;
    _layergq.backgroundColor = [[UIColor clearColor] CGColor];
    _layergq.shadowColor=[[[UIColor blackColor] colorWithAlphaComponent:0.35f] CGColor];
    _layergq.shadowRadius = 6;
    _layergq.shadowOffset = CGSizeMake(5, 5);
    [self.layer addSublayer:_layergq];
    
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
    animationgroup.repeatCount=HUGE_VALF;
    
    [_layergq addAnimation:animationgroup forKey:nil];
    
}
-(void)stopAnimation
{
    [_layergq removeAllAnimations];
    [_layergq removeFromSuperlayer];
    _layergq = nil;
}

@end
