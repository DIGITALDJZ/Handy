//
//  UserData.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "UserData.h"

@implementation UserData

-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

//returns specific value from user data
+(NSString*)returnUserData:(NSString*)returnValue{
    NSUserDefaults * storedObjects = [NSUserDefaults standardUserDefaults];
    
    NSString * userData = [storedObjects stringForKey:@"userData"];
    if (userData != nil){
        NSDictionary * JSONData = [NSJSONSerialization JSONObjectWithData: [userData dataUsingEncoding:NSUTF8StringEncoding]options: NSJSONReadingMutableContainers error: nil];
        return JSONData[returnValue];
    }
    
    return nil;
    
}

// gets called when new user signs in,  inserts basic user data to nsdefaults
-(void)insertUserData:(NSString*)userData {
    //storing the id in the user defaults
    NSUserDefaults * storedObjects = [NSUserDefaults standardUserDefaults];
    [storedObjects setObject:userData forKey:@"userData"];
    [storedObjects synchronize];
}

@end
