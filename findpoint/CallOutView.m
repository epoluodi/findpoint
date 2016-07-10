//
//  CallOutView.m
//  findpoint
//
//  Created by Stereo on 16/7/6.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//
#define kArrorHeight    10
#import "CallOutView.h"
#import "MapViewController.h"

@implementation CallOutView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */

-(instancetype)init
{
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    title = [[UILabel alloc] init];
    //    subtitle = [[UILabel alloc] init];
    btndel = [[UIButton alloc] init];
    leftimage = [[UIImageView alloc] init];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

    
    self.userInteractionEnabled=YES;
    return self;
}

-(void)setMeetingimg:(UIImage *)img
{
    leftimage.contentMode = UIViewContentModeScaleAspectFill;
    leftimage.image=img;
}
//加载图片
-(void)initview:(NSString *)strimgid
{
    leftimage.frame = CGRectMake(5, 5, 140, 100);
    leftimage.layer.cornerRadius=6;
    leftimage.layer.borderColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.4] CGColor];
    leftimage.layer.borderWidth=1;
    leftimage.layer.masksToBounds=YES;

    leftimage.contentMode = UIViewContentModeScaleAspectFit;
    leftimage.image=[UIImage imageNamed:@"addimg"];
    [self addSubview:leftimage];
    leftimage.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(btnadd)];
    
    [leftimage addGestureRecognizer:tap];
    
    title.frame = CGRectMake(leftimage.frame.origin.y + leftimage.frame.size.width + 10,
                             10, 80, 30);
    title.text=@"集合点";
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor= [UIColor whiteColor];
    [self addSubview:title];
    
    btndel.frame= CGRectMake(leftimage.frame.origin.y + leftimage.frame.size.width + 30,
                             50, 40, 40);
    [btndel addTarget:self action:@selector(btndel) forControlEvents:UIControlEventTouchUpInside];
    [btndel setImage:[UIImage imageNamed:@"btndel"] forState:UIControlStateNormal];
    [self addSubview:btndel];
    
    
    
    if (!strimgid)
    {

    }
    else
    {
        
    }
}

//删除集合标记
-(void)btndel
{
    [((MapViewController *)_controllview) delmeetingmark];
}


-(void)btnadd
{
        [((MapViewController *)_controllview) addmeetingImage];
}


//动画
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
    CGPoint point = [_controllview.view convertPoint:self.center toView:_controllview.view];
    
    //1.1告诉系统要执行什么样的动画
    anima.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    
    anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(point.x,point.y -60)];
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(point.x,point.y)];
    
    
    
    CAAnimationGroup *group =[CAAnimationGroup animation];
    group.animations=@[keyanimation,keyanimation2,anima];
    group.duration=0.6;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode=kCAFillModeForwards;
    group.removedOnCompletion=NO;
    group.delegate=self;
    [self.layer addAnimation:group forKey:nil];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.alpha=1;
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
