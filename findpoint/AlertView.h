//
//  AlertView.h
//  findpoint
//
//  Created by 程嘉雯 on 15/6/6.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AlertViewDelegate
@optional

-(void)cancelbtn;
-(void)onbtn:(NSMutableArray *)dataarary;
@end


@interface AlertView : NSObject<UITextFieldDelegate,UITextViewDelegate>
{
    __block UIAlertController *alertview;
    __block UITextField * text;
    __block UITextView *textview;
    NSMutableArray *dataarary;
    int length;
    UIAlertAction *ok;
    
    
}

@property (nonatomic, assign)   id <AlertViewDelegate>   delegate;

-(instancetype)initOneText:(NSString *)title message:(NSString *)message Style:(UIAlertControllerStyle)Style inputtype:(UIKeyboardType)inputype;
-(instancetype)initOneTextView:(NSString *)title message:(NSString *)message Style:(UIAlertControllerStyle)Style inputtype:(UIKeyboardType)inputype;

-(void)showAlert:(UIViewController *)main;
-(void)setTextLen:(int)len;
@end


