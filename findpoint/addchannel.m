//
//  addchannel.m
//  findpoint
//
//  Created by 程嘉雯 on 15/6/1.
//  Copyright (c) 2015年 com.epoluodi.findpoint. All rights reserved.
//

#import "addchannel.h"
#import "AppDelegate.h"
#import "channelCell.h"
#import <Common/PublicCommon.h>
#import "WebService.h"
#import "info.h"
@interface addchannel ()
{
    AppDelegate *App;
    UIImagePickerController *pickerview;
    WebService *web;
    AlertView *alertview;
    NSMutableArray *cellarrary;
    NSString *channelname,*channelID,*channelpwd,*channeldesc;;
    BOOL ischeck,isopen;
    UIImage *channelimg;
}
@end

@implementation addchannel
@synthesize navbar;
@synthesize tableview;
@synthesize channelimage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellarrary = [[NSMutableArray alloc] init];
    App = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    channelimage.layer.cornerRadius = channelimage.frame.size.height/2;
    channelimage.layer.masksToBounds = YES;
    [channelimage setContentMode:UIViewContentModeScaleAspectFill];
    [channelimage setClipsToBounds:YES];
    
    
    channelimage.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f].CGColor;
    channelimage.layer.borderWidth = 2.0f;
    
    channelimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicknickimage)];
    [channelimage addGestureRecognizer:singleTap1];
//    if (App.info.channelimage != nil)
//        channelimage.image = App.info.channelimage;
//    else
//        channelimage.image = [UIImage imageNamed:@"touxiang"];
//    
    
    title = [[UINavigationItem alloc] init];
    title.title=@"添加团队";
    
    leftButton = [[UIBarButtonItem alloc]
                  initWithTitle:@"取消"                                   style:UIBarButtonItemStyleBordered                                   target:self                                   action:@selector(leftbtn)];
    
    [title setLeftBarButtonItem:leftButton];
    
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(rightbtn)];
    [title setRightBarButtonItem:rightButton animated:YES];
    
    [navbar setBarStyle:UIBarStyleBlackTranslucent];

    isopen=YES;
    [navbar pushNavigationItem:title animated:YES];
    [self inittableview];

    
    // Do any additional setup after loading the view.
}


-(void)inittableview
{
    tableview.delegate=self;
    tableview.dataSource=self;
    [tableview setBackgroundColor:[UIColor clearColor]];
    UINib *nib=[UINib nibWithNibName:@"channelCell" bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:@"channelCell"];
    
    [tableview reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    channelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell"];
    UISwitch *modelswitch;
  
    switch (indexPath.row) {
        case 0:
            cell.labelinfo.text = @"团队号";
      
            break;
        case 1:
            cell.labelinfo.text = @"团队名称";
    
            break;
//        case 2:
//            cell.labelinfo.text = @"是否公开";
//            [cell hideLabelname];
//            modelswitch = [[UISwitch alloc] init];
//            
//            modelswitch.frame= CGRectMake([PublicCommon GetALLScreen].size.width -modelswitch.frame.size.width-30 ,cell.labelinfo.frame.origin.y-5
//                                          ,modelswitch.frame.size.width, modelswitch.frame.size.height);
//           
//            [modelswitch addTarget:self action:@selector(switchmode:) forControlEvents:UIControlEventValueChanged];
//            modelswitch.onTintColor=[[UIColor greenColor] colorWithAlphaComponent:0.3f];
//            modelswitch.on=YES;
//            
//            [cell addSubview:modelswitch];
//           
//            
//            break;
        case 2:
            cell.labelinfo.text = @"团队密码";
          
            break;
//        case 4:
//            cell.labelinfo.text = @"频道人数";
//            cell.labelname.text = @"10人";
//            cell.labelname.enabled=NO;
//            break;
        case 3:
            cell.labelinfo.text = @"团队描述";
            break;
  
    }
    [cellarrary addObject:cell];//添加对象到队列里面

    return cell;
}
-(void)switchmode:(id)sender
{
    isopen = ((UISwitch *)sender).on;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *viwe=[[UIView alloc] init];
    viwe.backgroundColor=[UIColor clearColor];
    return viwe;
}





-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            alertview =[[AlertView alloc] initOneText:@"输入频道号" message:@"频道号必须为数字，例如 101.1" Style:UIAlertControllerStyleAlert inputtype:UIKeyboardTypeDecimalPad ];
            alertview.delegate=self;
            [alertview setTextLen:8];
            [alertview showAlert:self];
            break;
            
        case 1:
            alertview =[[AlertView alloc] initOneText:@"输入团队名称" message:@"为团队取一个个性的名称" Style:UIAlertControllerStyleAlert inputtype:UIKeyboardTypeDefault ];
            alertview.delegate=self;
            [alertview setTextLen:16];
            [alertview showAlert:self];
            break;
        case 2:
            alertview =[[AlertView alloc] initOneText:@"输入团队密码" message:@"设置6位密码" Style:UIAlertControllerStyleAlert inputtype:UIKeyboardTypeNumberPad ];
            alertview.delegate=self;
            [alertview setTextLen:6];
            [alertview showAlert:self];
            break;
        case 3:
            alertview =[[AlertView alloc] initOneTextView:@"团队描述" message:@"设置一个炫酷的描述,字数限制 50" Style:UIAlertControllerStyleAlert inputtype:UIKeyboardTypeDefault ];
            alertview.delegate=self;
            [alertview setTextLen:50];
            [alertview showAlert:self];
            break;
    }
}








-(void)clicknickimage
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"选择团队标志" message:@"\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                pickerview = [[UIImagePickerController alloc] init];//初始化
            pickerview.delegate = self;
            pickerview.allowsEditing = YES;//设置可编辑
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                                 pickerview.sourceType = sourceType;
            [self presentModalViewController:pickerview animated:YES];//进入照相界面
                             }];
    
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 pickerview = [[UIImagePickerController alloc] init];//初始化
                                 pickerview.delegate = self;
                                 pickerview.allowsEditing = YES;//设置可编辑
                                 UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                 pickerview.sourceType = sourceType;
                                 [self presentModalViewController:pickerview animated:YES];//进入照相界面
                             }];
    
    
    
    selectchannelimage = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
 
        [UIView beginAnimations:@"chanege" context:nil];
        //动画持续时间
        [UIView setAnimationDuration:0.8f];
    
        //设置动画曲线，控制动画速度
        [UIView  setAnimationCurve: UIViewAnimationCurveEaseInOut];
        //设置动画方式，并指出动画发生的位置
//        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:channelimage  cache:YES];
        //提交UIView动画
        [channelimage setAlpha:0.5];
        
        NSString *imagename = [NSString stringWithFormat:@"png%d.png",selectimage];
        channelimage.image =  [UIImage imageNamed:imagename];
        channelimg =  [UIImage imageNamed:imagename];
         [channelimage setAlpha:1];
        

        [UIView commitAnimations];
        

    
        
        
       
    }];
    [alert addAction:selectchannelimage];
    [alert addAction:camera];
    [alert addAction:photo];
    
    [self initchannelintipng:alert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}



-(void)initchannelintipng:(UIAlertController *)alert
{
    UIScrollView * scrollview = [[UIScrollView alloc] init];
   
    
    CGRect newframe  = CGRectMake(10, 10,
                                  ([PublicCommon GetALLScreen].size.width -40),110);
    scrollview.frame=   newframe;
    
    
    scrollview.pagingEnabled=NO;
    scrollview.bounces=YES;
    scrollview.scrollEnabled=YES;
    scrollview.showsVerticalScrollIndicator=NO;
    scrollview.alwaysBounceHorizontal=NO;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.alwaysBounceVertical=NO;
    
    for (int i = 1; i<12; i++) {
        [self LoadBackPng:i scrollview:scrollview];
    }

    
    
    [alert.view addSubview:scrollview];
    
    
}

-(CGRect)getRectimage:(CGFloat)_x
{
    CGFloat x= 10+_x;
    CGFloat y = 30 ;
    
    CGFloat width =65;
    CGFloat height = 65;
    
    CGRect rect = CGRectMake(x, y, width, height);
    
    return rect;
}



-(void)LoadBackPng:(int)index scrollview:(UIScrollView *)scrollview
{
    UIImageView * imageviwe = [[UIImageView alloc] init];
    imageviwe.frame =[self getRectimage:((index-1) * 65 + ((index-1) > 0 ? (index-1) * 10 : 0) )];
    NSString *imagename = [NSString stringWithFormat:@"png%d.png",index];
    imageviwe.image = [UIImage imageNamed:imagename];
    imageviwe.userInteractionEnabled=YES;
    imageviwe.layer.shadowOffset = CGSizeMake(6, 4);
    imageviwe.layer.shadowColor =[[UIColor grayColor]CGColor];
    imageviwe.layer.shadowRadius =5;
    imageviwe.layer.shadowOpacity =0.8f;
    

    UIButton *btn = [[UIButton  alloc] init];

    btn.frame =CGRectMake(0, 0, imageviwe.frame.size.width, imageviwe.frame.size.height);
    btn.layer.cornerRadius = btn.frame.size.height/2;
    btn.layer.masksToBounds = YES;
    [btn setContentMode:UIViewContentModeScaleAspectFill];
    [btn setClipsToBounds:YES];
//    btn.layer.borderWidth=2;
//    btn.layer.borderColor = [[UIColor clearColor]CGColor];
    
    [imageviwe addSubview:btn];
    btn.tag = index;
    [btn addTarget:self action:@selector(imageselect:) forControlEvents:UIControlEventTouchUpInside];
    
    scrollview.contentSize = CGSizeMake( (index) * 65 + ((index-1) > 0 ? (index-1) * 10 : 0)  + 30,0);
    [scrollview addSubview:imageviwe];
    
    
    
}

-(void)imageselect:(UIButton *)sender
{
    
    selectbtn.layer.backgroundColor = [[UIColor clearColor]CGColor];
    
    selectimage = (int)sender.tag;
    NSLog(@"%d",(int)sender.tag);
    sender.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ok"]] ;
    selectbtn = sender;
    [self animationbtn:sender.layer];
    
    
    
    
    
}


-(void)animationbtn:(CALayer *)layer
{
 
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    //动画执行时间
    [CATransaction setValue:[NSNumber numberWithFloat:5.0f] forKey:kCATransactionAnimationDuration];
    
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:.5];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
  
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
  
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.6f;
    
    [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil]];
    animationGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 
    
    [layer addAnimation:animationGroup forKey:nil];
    
    

}






- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"SMILE!");
    //    [self.capturedImages addObject:image];
    
    //    if ([self.cameraTimer isValid])
    //    {
    //        return;
    //    }
    channelimage.image = image;
    channelimg = image;
    
    
//    NSData *jpgdata = UIImageJPEGRepresentation(image, 80);
//    
//    NSLog(@"%@",[self getPathdocument]);
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSString *filePath = [self getPathdocument];
//    
//    
//    //    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
//    
//    [fileManager createFileAtPath:[filePath stringByAppendingString:@"/nickimage.jpg"] contents:jpgdata attributes:nil];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    [self finishAndUpdate];
}


-(void)leftbtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightbtn
{
    if (ischeck ==NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"团队号没有验证，无法添加新的团队" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //链接网络添加频道
    
   
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"申请创建团队";
    [HUD show:YES];
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    dispatch_async(globalQ, ^{
        
        if (!channelname)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"团队名称没有输入，请输入团队名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        
        NSString *baseimage;
        if (channelimg != nil)
        {
            NSData *imagedata = UIImageJPEGRepresentation(channelimg, 0.6f);
            baseimage = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        }
        else
            baseimage=@"0";
        if (!channelpwd)
            channelpwd=@"";
        if (!channeldesc)
            channeldesc=@"";
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"t_channeltype",//私人类型
                             
                              [info getInstancent].uid,@"t_userid",
                              channelID,@"t_channelid",
                              channelname, @"t_channelname",
                              channelpwd,@"t_channelpwd",
                              baseimage,@"t_photo",
                              channeldesc,@"t_desc",
                              nil];
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonstr = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];

        //提交
        web = [[WebService alloc] initChannel:addchannelurl];
        int ret = [web createchannel:jsonstr];
        dispatch_async(mainQ, ^{
            [HUD hide:YES];
            NSLog(@"检查结果:%d",ret);
            if (ret == 1)
            {
      
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"团队创建失败，可能团队号已经被创建，请重新尝试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            else if (ret ==-1)
            {
               
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            else{

                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"创建成功，可以开始使用你的团队，可以将你的团队分享给朋友们" delegate:self cancelButtonTitle:@"完成" otherButtonTitles: @"分享",nil];
                [alert show];
                
            }
        });
        
    });

    
    
    
}


#pragma alertview delegate
-(void)onbtn:(NSMutableArray *)dataarary{
    
    
    
    channelCell *cell =(channelCell*) [cellarrary objectAtIndex:[tableview indexPathForSelectedRow].row];
    cell.labelname.text = [dataarary objectAtIndex:0];
    [cell setChannelidTextColor:NO];
    switch ([tableview indexPathForSelectedRow].row) {
        case 0:
            channelID =[dataarary objectAtIndex:0];
//            if ([App.info.channelid isEqualToString:newinfo.channelid])
//                return;

            [self checkchannelid:channelID];

            break;
        case 1:
            channelname =[dataarary objectAtIndex:0];
            break;
        case 2:
            channelpwd =[dataarary objectAtIndex:0];
            break;
        case 3:
            channeldesc =[dataarary objectAtIndex:0];
            break;
    }
    
}

-(void)checkchannelid:(NSString *)channcelid
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"检查团队号";
    [HUD show:YES];
    ischeck = YES;
    
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    dispatch_async(globalQ, ^{
        web = [[WebService alloc] initChannel:checkchannelurl];
        int ret = [web checkchannelid:channcelid];
        dispatch_async(mainQ, ^{
            [HUD hide:YES];
            NSLog(@"检查结果:%d",ret);
            if (ret == 1)
            {
                    channelCell *cell =(channelCell*) [cellarrary objectAtIndex:0];
                
                [cell setChannelidTextColor:YES];
                ischeck=NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"团队号已经被占用！请重新设定新的团队号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            else if (ret ==-1)
            {
                ischeck=NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
              
            }
            else{
                ischeck=YES;
                
            }
        });
   
    });
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    channelViewController * channelview;
    switch (buttonIndex) {
        case 0:
            channelview= (channelViewController *)[self presentedViewController];
            [self dismissViewControllerAnimated:YES completion:nil];
            [channelview refreshlistchannel];
            break;
        case 1:
            //分享
            break;

    }
}

-(void)cancelbtn
{
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
