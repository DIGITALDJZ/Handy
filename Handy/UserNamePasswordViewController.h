//
//  UserNamePasswordViewController.h
//  Handy
//
//  Created by Elay Datika on 5/18/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface UserNamePasswordViewController : GAITrackedViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mailText;
@property (weak, nonatomic) IBOutlet UITextField *passwodTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet NSString *getData;
- (IBAction)StartButton:(id)sender;
@end
