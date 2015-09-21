//
//  RegView.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/25.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegView : UIView<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    BOOL isEndedit;
     UIImagePickerController *pickerview;
    UIViewController * mainview;
    UIView *selectcolorimg;
    
    UITapGestureRecognizer *colorGestureRecgnizer1;
    UITapGestureRecognizer *colorGestureRecgnizer2;
    UITapGestureRecognizer *colorGestureRecgnizer3;
    UITapGestureRecognizer *colorGestureRecgnizer4;
    UITapGestureRecognizer *colorGestureRecgnizer5;
    UITapGestureRecognizer *colorGestureRecgnizer6;
    UITapGestureRecognizer *colorGestureRecgnizer7;
    UITapGestureRecognizer *colorGestureRecgnizer8;
    UITapGestureRecognizer *colorGestureRecgnizer9;
}

@property (weak, nonatomic) IBOutlet UITextField *usertxt;
@property (weak, nonatomic) IBOutlet UIImageView *useriamge;
@property (weak,nonatomic) IBOutlet UIView *colorimg1;
@property (weak,nonatomic) IBOutlet UIView *colorimg2;
@property (weak,nonatomic) IBOutlet UIView *colorimg3;
@property (weak,nonatomic) IBOutlet UIView *colorimg4;
@property (weak,nonatomic) IBOutlet UIView *colorimg5;
@property (weak,nonatomic) IBOutlet UIView *colorimg6;
@property (weak,nonatomic) IBOutlet UIView *colorimg7;
@property (weak,nonatomic) IBOutlet UIView *colorimg8;
@property (weak,nonatomic) IBOutlet UIView *colorimg9;

-(void)setMainView:(UIViewController *)ViewControl;

@end
