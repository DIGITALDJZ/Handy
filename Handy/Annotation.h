//
//  Annotation.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation, MKMapViewDelegate>{
    
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *idOfLocation;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phone;

@end
