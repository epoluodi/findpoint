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
        self.bounds = CGRectMake(0.f, 0.f, 30, 30);
        
        self.backgroundColor = [UIColor grayColor];
        
        /* Create portrait image view and add to view hierarchy. */
        nickimg = [[UIImageView alloc] initWithFrame:CGRectMake(0  , 0, 30, 30)];
        [self addSubview:nickimg];
        
        self.layer.cornerRadius=15;
        self.layer.masksToBounds=YES;
        self.backgroundColor = [UIColor clearColor];
        nickimg.image=[UIImage imageNamed:@"state3"];
   
    }
    
    return self;
}



@end
