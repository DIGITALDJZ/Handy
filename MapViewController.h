//
//  MapViewController.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PlaceViewController.h"
#import "Annotation.h"
#import "GAITrackedViewController.h"

@interface MapViewController : GAITrackedViewController {
    
    CLGeocoder *geocoder;
    
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) NSString * getData; //stores all kind of get data

// Segmented control to switch view controllers
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchViewControllers;

// Array of view controllers to switch between
@property (nonatomic, copy) NSArray *allViewControllers;

// Currently selected view controller
@property (nonatomic, strong) UIViewController *currentViewController;

- (IBAction)addAnnotationButton:(id)sender;
-(Annotation *)ann;
-(NSString *)myString;

@end
