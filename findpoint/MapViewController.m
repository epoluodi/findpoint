//
//  MapViewController.m
//  findpoint
//
//  Created by 程嘉雯 on 16/5/9.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import "MapViewController.h"
#import "GDLocation.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize map;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    map.showsUserLocation=YES;
    map.zoomLevel=17;
    map.userTrackingMode=MAUserTrackingModeFollow;


//    [map setCenterCoordinate:([GDLocation getInstancet].GDCoordinate2D) animated:YES];
    // Do any additional setup after loading the view.
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
