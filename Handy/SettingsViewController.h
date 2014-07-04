//
//  SettingsViewController.h
//  Handy
//
//  Created by Elay Datika on 5/17/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface SettingsViewController : GAITrackedViewController
@property (weak, nonatomic) IBOutlet UILabel *emailText;
@property (weak, nonatomic) IBOutlet UILabel *passText;

@end
