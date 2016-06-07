//
//  SearchChannel.h
//  findpoint
//
//  Created by 程嘉雯 on 16/5/27.
//  Copyright © 2016年 com.epoluodi.findpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
@interface SearchChannel : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,AlertViewDelegate>
{
    __block int resultrows;
    __block NSArray *resultlest;
    
}

@property (weak, nonatomic) IBOutlet UILabel *memo;
@property (weak, nonatomic) IBOutlet UISearchBar *searchview;
@property (weak, nonatomic) IBOutlet UITableView *table;


@end
