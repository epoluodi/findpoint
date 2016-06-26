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


@end
