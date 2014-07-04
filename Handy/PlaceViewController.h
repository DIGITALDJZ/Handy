//
//  PlaceViewController.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "GAITrackedViewController.h"
#import <FacebookSDK/FacebookSDK.h>

double userLan;
double userLon;
NSString *pinId;
NSString *pin;
NSString *pinNumber;
NSString *pinType;

@interface PlaceViewController : GAITrackedViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;
@property (strong, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIScrollView * scroll;

-(UIImage*)returnListPatientImage;
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName;
- (NSString *)documentsPathForFileName:(NSString *)name;
-(IBAction)newuser:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)openInMaps:(id)sender;

@end
