//
//  UserData.h
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

-(void)insertUserData:(NSString*)userData;
+(NSString*)returnUserData:(NSString*)returnValue; //returns specific value from user data

@end
