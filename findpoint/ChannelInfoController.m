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

@interface ChannelInfoController ()

@end

@implementation ChannelInfoController
@synthesize btnexit,grid;
@synthesize VC;
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
  
    [grid registerNib:[UINib nibWithNibName:@"gridcellfornick" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    membercount=20;
    grid.delegate=self;
    grid.dataSource=self;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self DrawLineView];
}

//画线
-(void)DrawLineView
{
    for (UIView *_v in [_backimg subviews]) {
        [_v removeFromSuperview];
    }
    
    UIView *v = [[UIView alloc] init];
        v .frame  = CGRectMake(30,
   grid.frame.origin.y +grid.frame.size.height+ 10+35 ,
                           [PublicCommon GetALLScreen].size.width -60, 1);
  
    [v setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2f] ];
    [_backimg addSubview:v];

    
    v = [[UIView alloc] init];
    v .frame  = CGRectMake(30,
                           grid.frame.origin.y +grid.frame.size.height+ 10+35 +35,
                           [PublicCommon GetALLScreen].size.width -60, 1);

    [v setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2f] ];
    [_backimg addSubview:v];
    
    v = [[UIView alloc] init];
    v .frame  = CGRectMake(30,
                           grid.frame.origin.y +grid.frame.size.height+ 10+35 +35+35,
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
    return UIEdgeInsetsMake(5, 5, 10, 5);
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



#pragma mark -





@end
