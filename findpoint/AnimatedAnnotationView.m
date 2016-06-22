//
//  AnimatedAnnotationView.m
//  Category_demo2D
//
//  Created by 刘博 on 13-11-8.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "AnimatedAnnotationView.h"


#define kWidth          60.f
#define kHeight         60.f
#define kTimeInterval   0.15f

@implementation AnimatedAnnotationView

@synthesize imageView = _imageView;

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBounds:CGRectMake(0.f, 0.f, kWidth, kHeight)];
        [self setBackgroundColor:[UIColor redColor]];
        
//        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        [self addSubview:self.imageView];
    }
    
    return self;
}

#pragma mark - Utility

@end
