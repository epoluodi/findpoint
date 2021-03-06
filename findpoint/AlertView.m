
//
//  AlertView.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/6.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AlertView.h"
#import <Common/PublicCommon.h>

@implementation AlertView
@synthesize delegate;

-(instancetype)initOneText:(NSString *)title message:(NSString *)message Style:(UIAlertControllerStyle)Style inputtype:(UIKeyboardType)inputype
{
    dataarary = [[NSMutableArray alloc] init];
    
    NSString *msg ;
    if (iPhone4 || iPhone5)
        msg= [NSString stringWithFormat:@"%@\n\n\n\n\n",message];
    else
        msg= [NSString stringWithFormat:@"%@\n\n",message];
  
    alertview =[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:Style];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (delegate)
            [delegate cancelbtn];
    }];
        ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            [alertview dismissViewControllerAnimated:YES completion:nil];
            if(delegate){
                [dataarary addObject:text.text];
                [delegate onbtn:dataarary];
            }
        }];
    
    [alertview addAction:cancel];
    [alertview addAction:ok];
    

    text = [[UITextField alloc] init];
    
    CGRect rect = CGRectMake(20, 70,
                             alertview.view.frame.size.width - 85 -
                             ([PublicCommon GetALLScreen].size.width -320), 40);
    text.frame =rect;
    text.clearButtonMode = UITextFieldViewModeUnlessEditing;
    text.borderStyle=UITextBorderStyleRoundedRect;
    text.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1f];
    text.textAlignment = UITextAlignmentCenter;
    text.delegate = self;
    text.keyboardType = inputype;
    [text setInputAccessoryView:[PublicCommon getInputToolbar:self sel:@selector(inputclose)]];
    [alertview.view addSubview:text];
    return [super init];
}



-(instancetype)initOneTextView:(NSString *)title message:(NSString *)message Style:(UIAlertControllerStyle)Style inputtype:(UIKeyboardType)inputype
{
    dataarary = [[NSMutableArray alloc] init];
    
    NSString *msg ;
    if (iPhone4 || iPhone5)
        msg= [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n",message];
    else
        msg= [NSString stringWithFormat:@"%@\n\n\n\n\n",message];
    
    alertview =[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:Style];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (delegate)
            [delegate cancelbtn];
    }];
    ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [alertview dismissViewControllerAnimated:YES completion:nil];
        if(delegate){
            [dataarary addObject:textview.text];
            [delegate onbtn:dataarary];
        }
    }];
    
    [alertview addAction:cancel];
    [alertview addAction:ok];
    
    
    textview = [[UITextView alloc] init];
    
    CGRect rect = CGRectMake(20, 70,
                             alertview.view.frame.size.width - 85 -
                             ([PublicCommon GetALLScreen].size.width -320), 80);
    textview.frame =rect;
    textview.font = [UIFont systemFontOfSize:18];

    textview.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1f];

    textview.delegate = self;
    textview.keyboardType = inputype;
    [textview setInputAccessoryView:[PublicCommon getInputToolbar:self sel:@selector(inputclose)]];
    [alertview.view addSubview:textview];
    return [super init];
}


-(instancetype)initwithTextfield:(NSString *)title message:(NSString *)message inputtype:(UIKeyboardType)inputype
{
    alertview =[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [tf resignFirstResponder];
        tf=nil;
      
    }];
    ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [alertview dismissViewControllerAnimated:YES completion:nil];
        if(delegate){
            dataarary = [[NSMutableArray alloc] init];

            [dataarary addObject:tf.text];
            [tf resignFirstResponder];
            tf=nil;
            [delegate onbtn:dataarary];
        }
    }];
    
    [alertview addAction:cancel];
    [alertview addAction:ok];
    
    
    [alertview addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        tf = textField;
        textField.placeholder = @"输入密码";
        textField.keyboardType = inputype;
  
    }];
    return [super init];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""])
    {
        if (text.text.length < length)
        {
            text.textColor = [UIColor blackColor];
            [ok setEnabled:YES];
            
        }
        return YES;
        
    }
    if (text.text.length +1> length)
    {
        text.textColor = [UIColor redColor];
        [ok setEnabled:YES];
        return NO;
    }
 
    return YES;

}




-(void)showAlert:(UIViewController *)main
{
    
    [main presentViewController:alertview animated:YES completion:nil];
}

-(void)setTextLen:(int)len
{
    length = len;
    text.placeholder = [NSString stringWithFormat:@"字限制:%d",length];
    
}
-(void)inputclose
{
    [text resignFirstResponder];
    [textview resignFirstResponder];
    
}



@end


