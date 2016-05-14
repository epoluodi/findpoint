//
//  GPSViewController.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/13.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDLocation.h"

@interface GPSViewController : UIViewController<GPSLocationDelegate>


- (IBAction)clickreturn:(id)sender;
- (IBAction)clickshare:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *txtsheng;
@property (weak, nonatomic) IBOutlet UILabel *txtcity;
@property (weak, nonatomic) IBOutlet UILabel *txtaddress;

@property (weak, nonatomic) IBOutlet UILabel *gpsjd;
@property (weak, nonatomic) IBOutlet UILabel *gpsspeed;
@property (weak, nonatomic) IBOutlet UILabel *gpshight;


@property (weak, nonatomic) IBOutlet UILabel *gpslocation;
@property (weak, nonatomic) IBOutlet MAMapView *map;




@end
