//
//  CallOutView.m
//  findpoint
//
//  Created by Stereo on 16/7/6.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//
#define kArrorHeight    10
#import "CallOutView.h"

@implementation CallOutView
@synthesize view;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */

-(instancetype)init
{
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    return self;
}


-(void)startanimation
{
    
    CAKeyframeAnimation * keyanimation =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyanimation.values = @[@0,@0.2,@0.3,@0.5,@0.6,@0.7,@0.8,@0.9,@01,@1.1,@1.2,@1.3,@1.2,@1.1,@1];
    keyanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    CAKeyframeAnimation * keyanimation2 =[CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyanimation2.values = @[@0,@0.1,@0.3,@0.5,@0.6,@0.6,@0.9];
    keyanimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //1.创建核心动画
    //    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:<#(NSString *)#>]
    CABasicAnimation *anima=[CABasicAnimation animation];
    
//    
   CGRect rect=  [view convertRect:view.bounds fromView:nil];
    
    //1.1告诉系统要执行什么样的动画
    anima.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y-100)];
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y)];

    
    
    CAAnimationGroup *group =[CAAnimationGroup animation];
    group.animations=@[keyanimation,keyanimation2];
    group.duration=0.6;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode=kCAFillModeForwards;
    group.removedOnCompletion=NO;
    [self.layer addAnimation:group forKey:nil];
}







//绘制背景
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}


@end
