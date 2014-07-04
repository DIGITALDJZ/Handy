//
//  RegisterViewController.h
//  Handy
//
//  Created by Elay Datika on 5/18/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "GAITrackedViewController.h"

@interface RegisterViewController : GAITrackedViewController <FBLoginViewDelegate>
//@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet NSString * getData;
@property (weak, nonatomic) IBOutlet UITextField *UsernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
- (IBAction)startBtn:(id)sender;
@end
