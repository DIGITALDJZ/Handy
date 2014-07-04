//
//  StartViewController.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "StartViewController.h"
#import "navigationTabBar.h"
#import "AFNetworking.h"
#import "ListPlaceViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize getData;

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
    self.screenName = @"Start Screen";
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    // Align the button in the center horizontally
    loginView.delegate = self;
    
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 400);
    [self.view addSubview:loginView];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.objectID;
    self.nameLabel.text = user.name;
    //self.nameLabel.text = user.username;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.statusLabel.text = [NSString stringWithFormat:@"Please wait..."];
    
    
    NSString * requestURL = [NSString stringWithFormat:@"https://handy-il.com/Handy/newUser.php"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%@", [user objectForKey:@"email"]] forKey:@"username"];
    [parameters setValue:[NSString stringWithFormat:@"%@", [user objectForKey:@"password"]] forKey:@"password"];
    [parameters setValue:[NSString stringWithFormat:@"%@", [user objectForKey:@"email"]] forKey:@"email"];
    [parameters setValue:[NSString stringWithFormat:@"%@", user.name] forKey:@"name"];
    [parameters setValue:[NSString stringWithFormat:@"address"] forKey:@"address"];
    [parameters setValue:[NSString stringWithFormat:@"birth"] forKey:@"birth"];
    AFHTTPRequestOperationManager * manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation * op1 = [manager1 POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) { //if success
        getData = operation.responseString;
        //NSLog(@"DATA: %@", getData);
        NSLog(@"Success");
        
        //NSString * storyboardName = @"MainStoryboard";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"navigationTabBar"];
        AppDelegate * app = [[AppDelegate alloc] init];
        [app tabBarMethod];
        [self presentViewController:vc animated:YES completion:nil];
        
        //NSLog(@"BLA");
        //jsonResponse = [NSJSONSerialization JSONObjectWithData:[getData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        //NSLog(@"JSONRE: %@", jsonResponse);
        ListPlaceViewController * imageViewController = [[ListPlaceViewController alloc]init];
        //[imageViewController returnListPatientImage];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [user objectForKey:@"email"]] forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [user objectForKey:@"password"]] forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Registered"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) { // if failed
                                              NSLog(@"Error: %@", error);
                                              UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                                              
                                              
                                              [alert show];
                                          }];
    
    [op1 start];

}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Reg"];
    //[self presentViewController:vc animated:YES completion:nil];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
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

- (IBAction)startButton:(id)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    navigationTabBar * basicInfoController = (navigationTabBar *)[storyboard instantiateViewControllerWithIdentifier:@"navigationTabBar"];
    
    [self.navigationController pushViewController:basicInfoController animated:YES];
    
}
@end
