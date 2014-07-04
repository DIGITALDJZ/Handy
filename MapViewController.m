//
//  MapViewController.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#define THE_SPAN 0.01f;
#define LOCATION_LATITUDE 32.167008;
#define LOCATION_LONGITUDE 34.809006;
#define THE_SPAN 2.0f;
#define MAP_PADDING 1.1

// we'll make sure that our minimum vertical span is about a kilometer
// there are ~111km to a degree of latitude. regionThatFits will take care of
// longitude, which is more complicated, anyway.
#define MINIMUM_VISIBLE_LATITUDE 0.01

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize getData, mapView;
NSMutableArray * jsonResponse;
int i;
NSMutableDictionary *dict;
NSString *pinName;
NSString *pinType;
NSString *Descrition;
NSString *latitude;
NSString  *longitude;
double latitudeDouble;
double longitudeDouble;
NSString *idOfRow;
Annotation * myann;
Annotation * currentAnn;
NSString * imageString;
NSMutableArray * locations;
NSString * address;
NSString * phone;


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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    geocoder = [[CLGeocoder alloc] init];
    self.screenName = @"Map Screen";
    mapView.delegate = self;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //set parameters
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    /*MKCoordinateSpan span;
    span.latitudeDelta = THE_SPAN;
    span.longitudeDelta = THE_SPAN;
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span = span;*/
    /*mapview.zoomEnabled = YES;
     mapview.scrollEnabled = YES;
     mapview.rotateEnabled = YES;
     mapview.showsUserLocation = YES;*/
    //create the request
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    NSString * requestURL = [NSString stringWithFormat:@"https://handy-il.com/Handy/vla.php"];
    
    
    
    //send the request
    AFHTTPRequestOperation *op = [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) { //if success
        getData = operation.responseString;
        NSLog(@"DATA: %@", getData);
        
        NSLog(@"BLA");
        jsonResponse = [NSJSONSerialization JSONObjectWithData:[getData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSLog(@"JSONRE: %@", jsonResponse);
        
        
        //Span
        MKCoordinateSpan span;
        span.latitudeDelta = THE_SPAN;
        span.longitudeDelta = THE_SPAN;
        MKCoordinateRegion mapRegion;
        mapRegion.center = mapView.userLocation.coordinate;
        mapRegion.span = span;
        CLLocationCoordinate2D location1;
        location1.latitude = 31.793555;
        location1.longitude = 35.046387;
        [mapView setRegion:mapRegion animated: NO];
        [locations addObject:myann];
        [self.mapView setCenterCoordinate: location1
                                 animated: NO];
        NSLog(@"blabla: %@", getData);
        //MKCoordinateRegion mapRegion;
        //mapRegion.center = mapview.userLocation.coordinate;
        //mapRegion.span = span;
        /*mapview.zoomEnabled = YES;
         mapview.scrollEnabled = YES;
         mapview.rotateEnabled = YES;
         mapview.showsUserLocation = YES;*/
        
        //[mapview setRegion:mapRegion animated: YES];
        
        
        locations = [[NSMutableArray alloc]init];
        CLLocationCoordinate2D location;
        NSLog(@"JSON: %lu", (unsigned long)[jsonResponse count]);
        for (i=0; i<[jsonResponse count]; i++) {
            if([jsonResponse objectAtIndex:i] == nil) continue;
            dict = [[[jsonResponse valueForKey:@"locations"] objectAtIndex:i] mutableCopy];
            
            idOfRow = [dict valueForKey:@"id"];
            pinName = [dict valueForKey:@"PinName"];
            pinType = [dict valueForKey:@"PinType"];
            Descrition = [dict valueForKey:@"Description"];
            latitudeDouble = [[dict valueForKey:@"Latitude"] doubleValue];
            longitudeDouble = [[dict valueForKey:@"Longitude"] doubleValue];
            imageString = [dict valueForKey:@"ImageDirectory"];
            address = [dict valueForKey:@"Address"];
            phone = [dict valueForKey:@"Phone"];
            
            NSLog(@"WORKING...");
            
            NSLog(@"%@", idOfRow);
            NSLog(@"%@", pinName);
            NSLog(@"%@", pinType);
            NSLog(@"%@", Descrition);
            NSLog(@"Latitude: %f", latitudeDouble);
            
            myann = [[Annotation alloc]init];
            location.latitude = latitudeDouble;
            location.longitude = longitudeDouble;
            myann.coordinate = location;
            myann.title = pinName;
            myann.subtitle = Descrition;
            myann.idOfLocation = idOfRow;
            myann.image = imageString;
            myann.address = address;
            myann.phone = phone;
            [locations addObject:myann];
            
        }
        
        
        
        NSLog(@"numberOfRows1: %d", i);
        //Galgalim Annotation
        myann = [[Annotation alloc]init];
        location.latitude = LOCATION_LATITUDE;
        location.longitude = LOCATION_LONGITUDE;
        myann.coordinate = location;
        myann.title = @"Text";
        myann.subtitle = @"Text";
        //[locations addObject:myann];
        
        [self.mapView addAnnotations:locations];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) { // if failed
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"FAIL" message:@"Bla" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [op start];
        [alert show];
        
        
        
    }];

}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont boldSystemFontOfSize:20.0f],
      UITextAttributeFont,
      [UIColor whiteColor],
      UITextAttributeTextColor,
      nil]];
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"PressedOnPlace"          // Event label
                                                           value:nil] build]];    // Event value
    
    currentAnn = view.annotation;
    
    NSLog(@"ID: %@", currentAnn.title);
    
    PlaceViewController * myView = [[PlaceViewController alloc]init];
    myView.nameLabel.text = currentAnn.title;
    NSLog(@"LABEL: %@", currentAnn.title);
    NSLog(@"MYIMAGE: %@", currentAnn.image);
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    PlaceViewController * detailsView = (PlaceViewController*)[storyboard instantiateViewControllerWithIdentifier:@"Details"];
    [self.navigationController pushViewController:detailsView animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    
    MKPinAnnotationView *pinView = nil;
    if(annotation!= mapView.userLocation)
    {
        static NSString *defaultPin = @"pinIdentifier";
        pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
        if(pinView == nil)
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPin];
        pinView.pinColor = MKPinAnnotationColorRed; //Optional
        pinView.canShowCallout = YES; // Optional
        pinView.animatesDrop = YES;
        pinView.draggable = NO;
        
        pinView.canShowCallout = YES;
        
        
        // Add a detail disclosure button to the callout.
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = infoButton;
        
    }
    else
    {
        [mapView.userLocation setTitle:@"You are Here!"];
    }
    return pinView;
}

- (IBAction)addAnnotationButton:(id)sender {
}

-(Annotation *)ann {
    
    return currentAnn;
}
-(NSString *)returnImageString {
    
    return @"bla";
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
