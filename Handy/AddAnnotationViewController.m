//
//  AddAnnotationViewController.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "AddAnnotationViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface AddAnnotationViewController ()

@end

@implementation AddAnnotationViewController
@synthesize nameTextField, typeTextField, decTextField, imageView, addressTextField;
float progress;
CustomIOS7AlertView *alertView;
UIProgressView *progressView;



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
    self.screenName = @"AddAnnotation Screen";
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    //do the following when the user picks an image;
    [picker dismissViewControllerAnimated:YES completion:nil];
	imageView.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    //do the following when the user cancel the photo uploading;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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

- (IBAction)addImageButton:(id)sender {
    
    //the user clicks on the "pick" button and the UIImagePickerController shows up;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:Nil];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"AddedImageToAnnotation"          // Event label
                                                           value:nil] build]];    // Event value
    
}

- (IBAction)sendButton:(id)sender {
    //the user clicks on the upload button;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"Added Annotation"
                    // Event label
                                                           value:nil] build]];    // Event value
    //make a data of an image;
	NSData *imageData = UIImageJPEGRepresentation(self->imageView.image, 90);
    //log to see it working;
    //NSLog(@"uploading...");
    
    //make a random photo name;
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *randomS = [NSMutableString stringWithCapacity:70];
    for (NSUInteger i = 0U; i < 70; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [randomS appendFormat:@"%C", c];
    }
    
    //reset the progress var;
    progress = 0;
    
    //configure the HTTP request
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://handy-il.com/"]];
    
    
    //make the parameters;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%@", nameTextField.text] forKey:@"name"];
    [parameters setValue:[NSString stringWithFormat:@"%@", typeTextField.text] forKey:@"type"];
    [parameters setValue:[NSString stringWithFormat:@"%@", decTextField.text] forKey:@"dec"];
    [parameters setValue:[NSString stringWithFormat:@"%@", addressTextField.text] forKey:@"address"];
    [parameters setValue:[NSString stringWithFormat:@"%@.jpg", randomS] forKey:@"image"];
    
    //serialize the request and the response;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //check if there's an image;
    if (imageData == nil) {
        
        //if there's no image, do the following:
        
        //make the new parameters;
        NSMutableDictionary *parametersWithoutImage = [NSMutableDictionary dictionary];
        [parametersWithoutImage setValue:[NSString stringWithFormat:@"%@", nameTextField.text] forKey:@"name"];
        [parametersWithoutImage setValue:[NSString stringWithFormat:@"%@", typeTextField.text] forKey:@"type"];
        [parametersWithoutImage setValue:[NSString stringWithFormat:@"%@", decTextField.text] forKey:@"dec"];
        [parametersWithoutImage setValue:[NSString stringWithFormat:@"%@", addressTextField.text] forKey:@"address"];
        [parametersWithoutImage setValue:[NSString stringWithFormat:@"bla"] forKey:@"image"];
        
        //send the request;
        AFHTTPRequestOperation *opWithoutImage = [manager POST:@"Handy/uploadPinSecure.php" parameters:parametersWithoutImage success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            //NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"חולה הועלה!"
                                                            message:@"החולה הועלה. תודה!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alertView close];
            
            
        }
                                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                           
                                                           //NSLog(@"Error: %@ ***** %@", operation.responseString, error);
                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"שגיאה!"
                                                                                                           message:@"הייתה שגיאה בהעלאה. אנא נסה שוב מאוחר יותר. תודה!"
                                                                                                          delegate:self
                                                                                                 cancelButtonTitle:@"OK"
                                                                                                 otherButtonTitles:nil];
                                                           [alert show];
                                                           [alertView close];
                                                           
                                                       }];
        alertView = [[CustomIOS7AlertView alloc] init];
        
        // Add some custom content to the alert view
        [alertView setContainerView:[self createDemoView]];
        
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects: nil]];
        
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        [opWithoutImage start];
        
        //make a progress bar of the request;
        [opWithoutImage setUploadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
            self.progressView.progress = progress;
            progressView.progress = progress;
            //self.progressView.progress = progress;
            //self.progressView.progress = progress;
            //NSLog(@"Progress: %f", progress);
            
        }];
        
    }
    
    else {
        
        //if there is an image, do the following:
        
        //send the request with the regular parameters;
        AFHTTPRequestOperation *op = [manager POST:@"Handy/uploadPinSecure.php" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            //add the image to the request;
            [formData appendPartWithFileData:imageData name:@"uploadedfile" fileName:[NSString stringWithFormat:@"%@.jpg", randomS] mimeType:@"image/jpeg"];
            
            //log the parameters;
            //NSLog(@"Parameters: %@", parameters);
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"חולה הועלה!"
                                                            message:@"החולה הועלה. תודה!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alertView close];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"שגיאה!"
                                                            message:@"הייתה שגיאה בהעלאה. אנא נסה שוב מאוחר יותר. תודה!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alertView close];
        }];
        alertView = [[CustomIOS7AlertView alloc] init];
        
        // Add some custom content to the alert view
        [alertView setContainerView:[self createDemoView]];
        
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects: nil]];
        
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        [op start];
        
        //set up the progressView
        [op setUploadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
            self.progressView.progress = progress;
            progressView.progress = progress;
            //NSLog(@"Progress: %f", progress);
        }];
        
    }
    
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 60)];
    
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(40, 40, 200, 15)];
    UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, -5, 100, 50)];
    [firstLabel setText:@"רושם חולה..."];
    [demoView addSubview:progressView];
    [demoView addSubview:firstLabel];
    //NSLog(@"ProgressInView: %f", progress);
    
    return demoView;
}

@end
