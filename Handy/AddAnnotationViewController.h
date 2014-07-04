//
//  AddAnnotationViewController.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFnetworking.h"
#import "CustomIOS7AlertView.h"
#import "GAITrackedViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AddAnnotationViewController : GAITrackedViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *decTextField;
- (IBAction)addImageButton:(id)sender;
- (IBAction)sendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end
