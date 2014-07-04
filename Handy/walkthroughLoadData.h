//
//  walkthroughLoadData.h
//  HealthyBelly
//
//  Created by Gil Maman on 03/04/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "navigationTabBar.h"

@interface walkthroughLoadData : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusIndicator;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)startButtonClick:(id)sender;
@end
