//
//  WalkThroughChildViewController.h
//  HealthyBelly
//
//  Created by gil maman on 11/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "walkthroughLoadData.h"

@class GPPSignInButton;

@interface WalkThroughChildViewController : UIViewController

@property (assign,nonatomic)NSUInteger index; // stores the current walkthrough index
@property (strong, nonatomic) IBOutlet GPPSignInButton *signInGooglePlus;//google+ sign in button

-(void)pushToLoadingData; //gets called after logging in
- (IBAction)UILoginFBClick:(id)sender;// fb Login button
- (IBAction)UIloginGP:(id)sender;

@end
