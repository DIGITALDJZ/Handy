//
//  WalkThroughChildViewController.m
//  HealthyBelly
//
//  Created by gil maman on 11/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import "WalkThroughChildViewController.h"

@interface WalkThroughChildViewController ()

@end

@implementation WalkThroughChildViewController

@synthesize index,signInGooglePlus;

#pragma mark view life cycle

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
    // end init facebook login

    
}

#pragma mark facebook Login

/* 
    -Signs the user through facebook
    -gets called when clicking the "sign in through facebook button" on walkthrough
    -calls an update for the db.
*/



#pragma mark sign in with google +


//when finished signing in auth


//gets called after logging in and changes to loading data
-(void)pushToLoadingData {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    walkthroughLoadData * basicInfoController = (walkthroughLoadData *)[storyboard instantiateViewControllerWithIdentifier:@"walkthroughLoadData"];
    
    [self.navigationController pushViewController:basicInfoController animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
