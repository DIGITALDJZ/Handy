//
//  WalkThroughMainViewController.h
//  HealthyBelly
//
//  Created by gil maman on 11/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkThroughChildViewController.h"

@interface WalkThroughMainViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController; // page controller

-(int)returnAmountOfViews; // returns the amount of walkthrough views there are

@end
