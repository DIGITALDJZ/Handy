//
//  ListViewController.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "StartViewController.h"
#import "MBProgressHUD.h"
#import "UIScrollView+EmptyDataSet.h"

@interface ListViewController : GAITrackedViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UIScrollViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *placesData;
    NSMutableArray *arr;
}
@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (nonatomic,retain) NSString * getData; //stores all kind of get data
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
-(NSDictionary *)currentPlaceForCellDict;
@end
