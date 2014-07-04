//
//  ParkingSpotsViewController.h
//  Handy
//
//  Created by Elay Datika on 5/17/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface ParkingSpotsViewController : GAITrackedViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSMutableArray *placesData;
    NSMutableArray *arr;
}
@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (nonatomic,retain) NSString * getData; //stores all kind of get data
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
-(NSDictionary *)currentPlaceForCellDict;

@end
