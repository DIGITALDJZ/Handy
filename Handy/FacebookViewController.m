//
//  FacebookViewController.m
//  Handy
//
//  Created by Elay Datika on 5/19/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController
@synthesize profilePictureView, nameLabel, statusLabel, UsernameText, passwordText, confirmText;
NSString * userName;
NSString * userEmail;

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
    // Do any additional setup after loading the view.
    self.screenName = @"RegisterFacebookButton";
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends", @"bookmarked", @"create_event", @"create_note", @"export_stream", @"friends_about_me", @"friends_activities", @"friends_birthday", @"friends_checkins", @"friends_interests", @"friends_hometown", @"friends_likes", @"friends_location", @"friends_photos", @"friends_status", @"manage_notifications", @"photo_upload", @"publish_actions", @"publish_checkins", @"publish_stream", @"read_friendlists", @"read_insights", @"read_mailbox", @"read_requests", @"read_stream", @"rsvp_event", @"share_item", @"sms", @"status_update", @"user_about_me", @"user_activities", @"user_birthday", @"user_events", @"user_interests", @"user_likes", @"user_location", @"user_photo_video_tags", @"user_photos", @"user_status", @"user_videos", @"user_website"]];
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
    
    [self.view addSubview:loginView];
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
    self.statusLabel.text = [NSString stringWithFormat:@"You're logged in as: %@", userName];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
