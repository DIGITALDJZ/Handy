//
//  RegisterViewController.m
//  Handy
//
//  Created by Elay Datika on 5/18/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "UserNamePasswordViewController.h"
#import "ListPlaceViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize profilePictureView, nameLabel, statusLabel, getData, UsernameText, passwordText, confirmText, scroll, emailText;
NSString * userEmail;
NSString * userName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[FBSession activeSession] accessTokenData] accessToken];
    // Do any additional setup after loading the view.
    self.screenName = @"RegisterWithFacebookViewController";
    self.scroll.scrollEnabled = YES;
    self.scroll.contentSize = CGSizeMake(320, 800);
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    loginView.delegate = self;
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 280);
    UIFont * roboto = [UIFont fontWithName:@"Roboto-Light" size:15.0];
    UIFont * robotoReg = [UIFont fontWithName:@"Roboto-Regular" size:20.0];
    nameLabel.font = roboto;
    statusLabel.font = roboto;
    statusLabel.font = roboto;
    UsernameText.delegate = self;
    passwordText.delegate = self;
    confirmText.delegate = self;
    
    //[self.view addSubview:loginView];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[UsernameText resignFirstResponder];
    [passwordText resignFirstResponder];
    [confirmText resignFirstResponder];
    
	return YES;
    
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.objectID;
    self.nameLabel.text = user.name;
    NSLog(@"username: %@", user.name);
    NSLog(@"ID: %@", user.objectID);
    NSLog(@"Email: %@", [user objectForKey:@"email"]);
    userEmail = [user objectForKey:@"email"];
    userName = user.name;
    //NSLog(@"BirthDay: %@", [user objectForKey:@"birthday"]);
    //NSLog(@"Loc: %@", user.location);
    
   
        
    
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = [NSString stringWithFormat:@"Enter the details above"];
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startBtn:(id)sender {
    
}
@end
