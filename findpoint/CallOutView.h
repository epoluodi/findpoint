//
//  CallOutView.h
//  findpoint
//
//  Created by Stereo on 16/7/6.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallOutView : UIView
{
    UIImageView *leftimage;
    UILabel *title;
//    UILabel *subtitle;s
    UIActivityIndicatorView *indicator;
    UIButton *btnaddimg;
    UIButton *btndel;
}

@property (weak,nonatomic)UIViewController *controllview;


-(void)startanimation;
-(void)initview:(NSString *)strimgid;
@end
