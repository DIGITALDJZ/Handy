//
//  PlaceViewController.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "PlaceViewController.h"
#import "Annotation.h"
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface PlaceViewController ()

@end

@implementation PlaceViewController
@synthesize nameLabel, typeLabel, decLabel, placeImage, descLabel, scroll;
NSString * name;
NSDictionary * currentPatient;
NSURL * imageUrl;
NSString * photoString;
CGFloat kParallaxRatio;
CGFloat kMainImageHeight;


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
    self.screenName = @"Place Screen From Map";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    MapViewController * mapViewCon = [[MapViewController alloc]init];
    Annotation * myann;
    myann = [mapViewCon ann];
    nameLabel.text = myann.title;
    typeLabel.text = myann.address;
    decLabel.text = myann.phone;
    photoString = myann.image;
    descLabel.text = myann.subtitle;
    placeImage.image = [self returnListPatientImage];
    NSLog(@"PHOTOINVIEW: %@", photoString);
    UIFont * roboto = [UIFont fontWithName:@"Roboto-Light" size:15.0];
    UIFont * robotoReg = [UIFont fontWithName:@"Roboto-Regular" size:20.0];
    
    UIFont * latoBold34 = [UIFont fontWithName:@"Lato-Bold" size:34.0];
    UIFont * latoLight21 = [UIFont fontWithName:@"Lato-Light" size:21.0];
    UIFont * latoLight17 = [UIFont fontWithName:@"Lato-Light" size:17.0];
    
    nameLabel.font = latoBold34;
    decLabel.font = latoLight21;
    typeLabel.font = latoLight21;
    descLabel.font = latoLight17;
    
    scroll.delegate = self;
    if (IsIphone5) {
        scroll.contentSize = CGSizeMake(320, 530);
    }
    else{
        scroll.contentSize = CGSizeMake(320, 618);
    }
    scroll.scrollEnabled = YES;
    
    kParallaxRatio = 0.4;
    kMainImageHeight = 294;
    placeImage.frame = CGRectMake(0, 0, self.view.frame.size.width, kMainImageHeight);
    
}

-(IBAction)newuser:(id)sender
{
    NSString *URLString = [@"tel://" stringByAppendingString:decLabel.text];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL];
}

- (IBAction)shareButton:(id)sender {
    
    // Check if the Facebook app is installed and we can present the share dialog
    //FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    //params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // Present the feed dialog
    // Put together the dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"I just visited %@ with Handy!", nameLabel.text], @"name",
                                   @"Handy", @"caption",
                                   @"I just visited an accessible place with Handy", @"description",
                                   @"https://handy-il.com", @"link",
                                   [NSString stringWithFormat:@"https://handy-il.com/Handy/Images/%@", photoString], @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
    // Make the request
    [FBRequestConnection startWithGraphPath:@"/me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Link posted successfully to Facebook
                                  NSLog(@"result: %@", result);
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                                  NSLog(@"%@", error.description);
                              }
                          }];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < -34) {
        self.placeImage.frame = CGRectMake((scrollView.contentOffset.y / 2) + 17, self.placeImage.frame.origin.y, self.view.frame.size.width - scrollView.contentOffset.y - 34, kMainImageHeight -scrollView.contentOffset.y - 34);
        NSLog(@"Rect: %@", NSStringFromCGRect(self.placeImage.frame));
    }
    else if (scrollView.contentOffset.y >= 0){
        self.placeImage.frame = CGRectMake(0, -scrollView.contentOffset.y / 2, self.view.frame.size.width, kMainImageHeight);
        NSLog(@"Rect: %@", NSStringFromCGRect(self.placeImage.frame));
    }
    else {
        
        self.placeImage.frame = CGRectMake(0, -scrollView.contentOffset.y / 1.5
                                           , self.view.frame.size.width, kMainImageHeight);
        NSLog(@"Rect: %@", NSStringFromCGRect(self.placeImage.frame));
    }
}

- (IBAction)openInMaps:(id)sender {
    NSString * addressString = [NSString stringWithFormat:@"https://maps.google.com/?q=%@ , Israel", typeLabel.text];
    NSString * urlString = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
    
}


// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

-(UIImage*)returnListPatientImage {
    UIImage * patientImage;
    
    MapViewController *dict = [[MapViewController alloc]init];
    //NSLog(@"currentPatientObject: %@", currentPatient);
    NSLog(@"PHOTO: %@", photoString);
    imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://handy-il.com/Handy/Images/%@", photoString]];
    //NSLog(@"NewURL: %@", imageUrl);
    NSString * fileName;
    NSString * filePath;
    //if image is already stored
    
    name = photoString;
    while (![photoString  isEqual: @"bla"]) {
        fileName = [NSString stringWithFormat:@"%@.jpg", photoString];
        filePath = [self documentsPathForFileName:fileName]; //Add the file name
        //get image from file
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        patientImage = [UIImage imageWithData:pngData];
        //NSLog(@"name1: %@", photoString);
        
        if (!patientImage) { // if image doesent exists
            //get image from url
            NSData * patientImageData = [NSData dataWithContentsOfURL:imageUrl];
            patientImage = [UIImage imageWithData:patientImageData];
            //NSLog(@"Getting image from database: %@", fileName);
            //NSLog(@"name: %@", photoString);
            //save image to app
            NSString * fileName = [NSString stringWithFormat:@"%@", photoString];
            [self saveImage:patientImage withFileName:fileName];
        }
        else {
            
            //NSLog(@"Image is already stored!");
            
        }
        
        break;
    }
    
    
    return patientImage;
}

//saves image to local ios storage
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName {
    NSData * imageData = UIImageJPEGRepresentation(image,100); //data from mage
    
    //path for image
    NSString * fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
    NSString *filePath = [self documentsPathForFileName:fileName]; //Add the file name
    
    [imageData writeToFile:filePath atomically:YES]; //Write the file
    NSLog(@"Image Saved at: %@", filePath);
}


//returns path for image
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
     NSLog(@"nameOfPath: %@", name);
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
