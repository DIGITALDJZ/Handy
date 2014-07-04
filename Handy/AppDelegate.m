//
//  AppDelegate.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "AppDelegate.h"
#import "navigationTabBar.h"
#import "GAI.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <Appsee/Appsee.h>
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation AppDelegate
UIView *myView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setBarTintColor:[self colorWithHexString:@"2e3545"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    [Appsee start:@"ff6d512cb3a744818b3093932710570d"];
    
    [Parse setApplicationId:@"wlvJYnGZeHeIh79rL3mm8nOYY2ldRyjHP3USXXTQ"
                  clientKey:@"IOsSB7Nu051D4PhiYry9G2qVRX4LnFwwBcDCiKw2"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    
    // Send push notification to query
    [PFPush sendPushMessageToQueryInBackground:pushQuery
                                   withMessage:@"Hello World!"];
    
    // Override point for customization after application launch.
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-50744507-3"];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [FBProfilePictureView class];
    [FBLoginView class];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasBeenLaunched2555555555"])
    {
        
            NSLog(@"Bool: %hhd", [[NSUserDefaults standardUserDefaults] boolForKey:@"Registered"]);
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        navigationTabBar * rootView = (navigationTabBar *)[storyboard instantiateViewControllerWithIdentifier:@"navigationTabBar"];
        UINavigationController * rootViewContoller = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"feed"];
        if (IsIphone5) {
            myView = [[UIView alloc] initWithFrame:CGRectMake(0, 510, 320, 10)];
        }
        else{
            
            myView = [[UIView alloc] initWithFrame:CGRectMake(0, 422, 320, 10)];
            
        }
        
        myView.backgroundColor = [self colorWithHexString:@"3a4151"];
        [rootView.view addSubview:myView];
        [rootView.view bringSubviewToFront:rootView.tabBar];
        self.window.rootViewController = rootView;

        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasBeenLaunched2555555555"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Helllo!" message:@"This is the first time your'e using Handy!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert show];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UINavigationController * rootView = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"WalkThroughNavigation"];
        self.window.rootViewController = rootView;
    }
    return YES;
}

- (void)tabBarMethod {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    navigationTabBar * rootView = (navigationTabBar *)[storyboard instantiateViewControllerWithIdentifier:@"navigationTabBar"];
    UINavigationController * rootViewContoller = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"feed"];
    if (IsIphone5) {
        myView = [[UIView alloc] initWithFrame:CGRectMake(0, 510, 320, 10)];
    }
    else{
        
        myView = [[UIView alloc] initWithFrame:CGRectMake(0, 422, 320, 10)];
        
    }
    
    myView.backgroundColor = [self colorWithHexString:@"3a4151"];
    [rootView.view addSubview:myView];
    [rootView.view bringSubviewToFront:rootView.tabBar];
    self.window.rootViewController = rootView;
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                sourceApplication:sourceApplication
                                  fallbackHandler:^(FBAppCall *call) {
                                      NSLog(@"Unhandled deep link: %@", url);
                                      // Here goes the code to handle the links
                                      // Use the links to show a relevant view of your app to the user
                                  }];
    
    // You can add your app-specific url handling code here if needed
    
    return urlWasHandled;
}
     
     -(UIColor*)colorWithHexString:(NSString*)hex
    {
        NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) return [UIColor grayColor];
        
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        
        if ([cString length] != 6) return  [UIColor grayColor];
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
