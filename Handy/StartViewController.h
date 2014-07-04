//
//  StartViewController.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface StartViewController : GAITrackedViewController
{
    NSMutableArray *placesData;
    NSMutableArray *arr1;
}
- (IBAction)startButton:(id)sender;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet NSString * getData;
@property (strong, nonatomic) IBOutlet NSString * getData2;
@property (weak, nonatomic) IBOutlet UITextField *UsernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
- (NSArray *)arr;
@end
