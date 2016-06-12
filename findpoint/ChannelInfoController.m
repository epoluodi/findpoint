//
//  ChannelInfoController.m
//  findpoint
//
//  Created by 程嘉雯 on 16/6/8.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "ChannelInfoController.h"
#import "GroupInfo.h"
#import <Common/PublicCommon.h>
#import "gridcellfornick.h"
#import <Common/FileCommon.h>
#import "Common.h"

@interface ChannelInfoController ()

@end

@implementation ChannelInfoController
@synthesize btnexit,grid;
@synthesize VC,mediaid;
@synthesize ChannelID;
@synthesize channelname,memo,members,area;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队信息";
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"团队定位" style:UIBarButtonItemStylePlain target:self action:@selector(rightbtn)];
    [self.navigationItem setRightBarButtonItem:rightButton animated:YES];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    grid.layer.borderColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.5f] CGColor];
    grid.layer.borderWidth=0.5;
    
    UIImage*img1 = [PublicCommon createImageWithColor:RGBA(234    , 48, 52, 0.8f) Rect:CGRectMake(0, 0, 10, 10)];
    UIImage*img2 = [PublicCommon createImageWithColor:RGBA(231, 92, 97, 0.8f) Rect:CGRectMake(0, 0, 10, 10)];
    [btnexit setTitle:@"退出团队" forState:UIControlStateNormal];
    [btnexit setBackgroundImage:img1 forState:UIControlStateNormal];
    [btnexit setBackgroundImage:img2 forState:UIControlStateHighlighted];
    btnexit.layer.cornerRadius=6;
    btnexit.layer.masksToBounds=YES;
    
    [btnexit addTarget:self action:@selector(OnBtnexit) forControlEvents:UIControlEventTouchUpInside];
    
    groupinfo = [[GroupInfo getInstancet] getGroupForGroupid:ChannelID];
    channelname.text= [groupinfo objectForKey:@"CHNAME"];
    members.text= [NSString stringWithFormat:@"%@", [groupinfo objectForKey:@"PEOPLES"] ];
    area.text= [groupinfo objectForKey:@"CHAREA"];
    memo.text= [groupinfo objectForKey:@"DESC"];
    [self updategridlayout];
    [grid registerNib:[UINib nibWithNibName:@"gridcellfornick" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    membercount=20;
    grid.delegate=self;
    grid.dataSource=self;
    gridbackimg = [[UIImageView alloc] init];
    [grid setBackgroundView:gridbackimg];
    gridbackimg.contentMode=UIViewContentModeCenter;
    gridbackimg.alpha=0;
 
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    scaleAnimation.duration=0.4;
    
    [btnexit.layer addAnimation:scaleAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [FileCommon getCacheDirectory];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *filename = [NSString stringWithFormat:@"%@.png",mediaid];
        NSString* _filename = [path stringByAppendingPathComponent:filename];
        if ([fm fileExistsAtPath:_filename])
        {
            NSData *pngdata = [NSData dataWithContentsOfFile:_filename];
            if (pngdata)
            {
                [UIView beginAnimations:@"chanege" context:nil];
                //动画持续时间
                [UIView setAnimationDuration:0.8f];
                
                //设置动画曲线，控制动画速度
                [UIView  setAnimationCurve: UIViewAnimationCurveEaseInOut];
                //设置动画方式，并指出动画发生的位置
                //提交UIView动画
                
                
                gridbackimg.image =  [Common circleImageWithName:[UIImage imageWithData:pngdata]];
                [gridbackimg setAlpha:0.2];
                
                [UIView commitAnimations];
            }
        }
        
    });
    
}




-(void)updategridlayout
{
    NSArray *layoutlist = grid.constraints;
    int h=0;
    for (NSLayoutConstraint *layout in layoutlist) {
        if ([layout.identifier isEqualToString:@"girdheight"])
        {
            
            if (iPhone6plus)
                layout.constant=300;
            if (iPhone6)
                layout.constant=260;
            if (iPhone5)
                layout.constant=240;
            h=layout.constant;
        }
    }
    [self DrawLineView:h];
}


//画线
-(void)DrawLineView:(int)h
{
    for (UIView *_v in [_backimg subviews]) {
        [_v removeFromSuperview];
    }
    
    UIView *v = [[UIView alloc] init];
        v .frame  = CGRectMake(30,
   grid.frame.origin.y +h+ 10+35 ,
                           [PublicCommon GetALLScreen].size.width -60, 1);
  
    [v setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2f] ];
    [_backimg addSubview:v];

    
    v = [[UIView alloc] init];
    v .frame  = CGRectMake(30,
                           grid.frame.origin.y +h+ 10+35 +35,
                           [PublicCommon GetALLScreen].size.width -60, 1);

    [v setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2f] ];
    [_backimg addSubview:v];
    
    v = [[UIView alloc] init];
    v .frame  = CGRectMake(30,
                           grid.frame.origin.y +h+ 10+35 +35+35,
                           [PublicCommon GetALLScreen].size.width -60, 1);
   
    [v setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2f] ];
    [_backimg addSubview:v];
    
    
}


-(void)OnBtnexit
{
    [VC.RefreshList beginRefreshing];
    [VC refreshlistchannel];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightbtn
{
    self.tabBarController.selectedIndex=1;
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




#pragma mark --UICollectionViewDelegateFlowLayout
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return membercount;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    gridcellfornick*cell = [grid dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell displayAnim];
    
    
    
    
    return  cell;
    
    
    
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(81, 97);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"gridhead" forIndexPath:indexPath];
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={320,45};
//    return size;
//}

#pragma mark -





@end
