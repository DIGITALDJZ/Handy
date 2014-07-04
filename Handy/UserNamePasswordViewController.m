//
//  UserNamePasswordViewController.m
//  Handy
//
//  Created by Elay Datika on 5/18/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "UserNamePasswordViewController.h"
#import "AFNetworking.h"
#import "ListPlaceViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface UserNamePasswordViewController ()

@end

@implementation UserNamePasswordViewController
@synthesize nameText, passwodTextField, confirmText, mailText, getData;

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
    self.screenName = @"RegisterViewController";
    nameText.delegate = self;
    passwodTextField.delegate = self;
    confirmText.delegate = self;
    mailText.delegate = self;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    nameText.attributedPlaceholder = str;
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    mailText.attributedPlaceholder = str1;
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    passwodTextField.attributedPlaceholder = str2;
    
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    confirmText.attributedPlaceholder = str3;

}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[nameText resignFirstResponder];
    [passwodTextField resignFirstResponder];
    [confirmText resignFirstResponder];
    [mailText resignFirstResponder];
    
	return YES;
    
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

- (IBAction)StartButton:(id)sender {
    
    
    if (![mailText.text isEqualToString:@""]) {
        
        if (![passwodTextField.text isEqualToString:@""]) {
            
    if ([passwodTextField.text isEqual:confirmText.text]) {
        
        
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        
        NSString * requestURL = [NSString stringWithFormat:@"https://handy-il.com/Handy/newUser.php"];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:[NSString stringWithFormat:@"%@", mailText.text] forKey:@"username"];
        [parameters setValue:[NSString stringWithFormat:@"%@", [self md5:passwodTextField.text]] forKey:@"password"];
        [parameters setValue:[NSString stringWithFormat:@"%@", mailText.text] forKey:@"email"];
        [parameters setValue:[NSString stringWithFormat:@"%@", nameText.text] forKey:@"name"];
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
            [self presentViewController:vc animated:YES completion:nil];
            
            //NSLog(@"BLA");
            //jsonResponse = [NSJSONSerialization JSONObjectWithData:[getData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
            //NSLog(@"JSONRE: %@", jsonResponse);
            ListPlaceViewController * imageViewController = [[ListPlaceViewController alloc]init];
            //[imageViewController returnListPatientImage];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", mailText.text] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", passwodTextField.text] forKey:@"password"];
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
        }
    }
    
    else if ([mailText.text isEqualToString:@""]){
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter mail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    else if (![passwodTextField.text isEqual:confirmText.text]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
@end
