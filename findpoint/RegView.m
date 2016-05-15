//
//  RegView.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/25.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "RegView.h"
#import <Common/PublicCommon.h>

@implementation RegView
@synthesize usertxt;
@synthesize useriamge;
@synthesize colorimg1;
@synthesize colorimg2;
@synthesize colorimg3;
@synthesize colorimg4;
@synthesize colorimg5;
@synthesize colorimg6;
@synthesize colorimg7;
@synthesize colorimg8;
@synthesize colorimg9;



-(void)setMainView:(UIViewController *)ViewControl
{
    mainview = ViewControl;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    isEndedit = NO;
       usertxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        usertxt.delegate =self;
        usertxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    
       [usertxt setInputAccessoryView:[PublicCommon getInputToolbar:self sel:@selector(inputclose)]];
    
    useriamge.layer.cornerRadius = useriamge.frame.size.height/2;
    useriamge.layer.masksToBounds = YES;
    [useriamge setContentMode:UIViewContentModeScaleAspectFill];
    [useriamge setClipsToBounds:YES];
    
    
    
    useriamge.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f].CGColor;
    useriamge.layer.borderWidth = 2.0f;
    
    useriamge.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickusernickimage)];
    [useriamge addGestureRecognizer:singleTap1];
    
    colorGestureRecgnizer1 = [[UITapGestureRecognizer alloc]
                             initWithTarget:self action:@selector(clickcolor1)];
    colorGestureRecgnizer2 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor2)];
    colorGestureRecgnizer3 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor3)];
    colorGestureRecgnizer4 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor4)];
    colorGestureRecgnizer5 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor5)];
    colorGestureRecgnizer6 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor6)];
    colorGestureRecgnizer7 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor7)];
    colorGestureRecgnizer8 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor8)];
    colorGestureRecgnizer9 = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(clickcolor9)];
    
    
    
    [self initcolorviewshaow];
    
    
    
}


- (void)scareAnimation:(UIView *)_viewselct restore:(BOOL)restore
{
    [UIView beginAnimations:@"ScareAnimation" context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
 
    if (restore){
        [_viewselct setTransform:CGAffineTransformScale(_viewselct.transform, 0.77, 0.77)];
        [_viewselct updateConstraints];
        
    }
    else
        [_viewselct setTransform:CGAffineTransformScale(_viewselct.transform, 1.3, 1.3)];
    
    [UIView commitAnimations];
}


-(void)clickcolor1
{
    
 
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg1;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor2
{
    
    
 
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg2;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor3
{
    
    
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg3;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor4
{
    
 
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg4;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor5
{
    
    
    
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg5;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor6
{
    
    
        if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg6;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor7
{
    
    
    
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg7;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor8
{

    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg8;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}
-(void)clickcolor9
{
    
    
    if (selectcolorimg)
        [self scareAnimation:selectcolorimg restore:YES];
    selectcolorimg =colorimg9;
    [self scareAnimation:selectcolorimg restore:NO];
    
    
}


-(void)initcolorviewshaow
{
    colorimg1.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg1.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg1.layer.shadowRadius =3;
    colorimg1.layer.shadowOpacity =0.8f;
    colorimg1.tag=1;
    
    [colorimg1 addGestureRecognizer:colorGestureRecgnizer1];
    
    colorimg2.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg2.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg2.layer.shadowRadius =3;
    colorimg2.layer.shadowOpacity =0.8f;
    colorimg2.tag=2;
    [colorimg2 addGestureRecognizer:colorGestureRecgnizer2];
    
    colorimg3.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg3.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg3.layer.shadowRadius =3;
    colorimg3.layer.shadowOpacity =0.8f;
    colorimg3.tag=3;
    [colorimg3 addGestureRecognizer:colorGestureRecgnizer3];
    
    colorimg4.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg4.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg4.layer.shadowRadius =3;
    colorimg4.layer.shadowOpacity =0.8f;
    colorimg4.tag=4;
    [colorimg4 addGestureRecognizer:colorGestureRecgnizer4];
    
    colorimg5.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg5.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg5.layer.shadowRadius =3;
    colorimg5.layer.shadowOpacity =0.8f;
    colorimg5.tag=5;
    [colorimg5 addGestureRecognizer:colorGestureRecgnizer5];
    
    colorimg6.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg6.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg6.layer.shadowRadius =3;
    colorimg6.layer.shadowOpacity =0.8f;
    colorimg6.tag=6;
    [colorimg6 addGestureRecognizer:colorGestureRecgnizer6];
    
    colorimg7.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg7.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg7.layer.shadowRadius =3;
    colorimg7.layer.shadowOpacity =0.8f;
    colorimg7.tag=7;
    [colorimg7 addGestureRecognizer:colorGestureRecgnizer7];
    
    colorimg8.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg8.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg8.layer.shadowRadius =3;
    colorimg8.layer.shadowOpacity =0.8f;
    colorimg8.tag=8;
    [colorimg8 addGestureRecognizer:colorGestureRecgnizer8];
    
    colorimg9.layer.shadowOffset = CGSizeMake(4, 2);
    colorimg9.layer.shadowColor =[[UIColor blackColor]CGColor];
    colorimg9.layer.shadowRadius =3;
    colorimg9.layer.shadowOpacity =0.8f;
    colorimg9.tag=9;
    [colorimg9 addGestureRecognizer:colorGestureRecgnizer9];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]){
        
        if (usertxt.text.length < 6)
            isEndedit=NO;
        return YES;
    }
    
    if (isEndedit)
    {
        return NO;
    }
    if (usertxt.text.length > 6)
        return NO;
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (usertxt.text.length > 6)
        isEndedit =YES;
}

-(void)inputclose
{
  
    [usertxt resignFirstResponder];
    
}



-(void)clickusernickimage
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"选择头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 pickerview = [[UIImagePickerController alloc] init];//初始化
                                 pickerview.delegate = self;
                                 pickerview.allowsEditing = YES;//设置可编辑
                                 UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                                 pickerview.sourceType = sourceType;
                                 [mainview presentModalViewController:pickerview animated:YES];//进入照相界面
                             }];
    
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                pickerview = [[UIImagePickerController alloc] init];//初始化
                                pickerview.delegate = self;
                                pickerview.allowsEditing = YES;//设置可编辑
                                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                pickerview.sourceType = sourceType;
                                [mainview presentModalViewController:pickerview animated:YES];//进入照相界面
                            }];
    
   
   
    [alert addAction:camera];
    [alert addAction:photo];
    

    
    [mainview presentViewController:alert animated:YES completion:nil];
    
    
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"SMILE!");
    useriamge.image = image;
//    channelimage.image = image;
//    newinfo.channelimage = image;
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
  
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
