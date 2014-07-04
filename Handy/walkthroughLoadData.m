//
//  walkthroughLoadData.m
//  HealthyBelly
//
//  Created by Gil Maman on 03/04/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import "walkthroughLoadData.h"

@interface walkthroughLoadData ()

@end

@implementation walkthroughLoadData

@synthesize welcomeLabel,startButton,statusIndicator;

#pragma mark view lifecycle

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
    
    //load user name
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonClick:(id)sender {
    //if should load resteraunts data
    if (![statusIndicator.text  isEqual: @"Setting up your account... please wait..."]) {
        statusIndicator.text = @"Setting up your account... please wait...";
        startButton.enabled = FALSE;
        [startButton setTitle:@"Loading..." forState:UIControlStateNormal];
        
            statusIndicator.textColor = [UIColor greenColor];
            statusIndicator.text = @"Done !";
            startButton.enabled = TRUE;
            [startButton setTitle:@"Enter HealthyBelly!" forState:UIControlStateNormal];
    
    } else { //if loaded already
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        navigationTabBar * basicInfoController = (navigationTabBar *)[storyboard instantiateViewControllerWithIdentifier:@"navigationTabBar"];
        
        [self.navigationController pushViewController:basicInfoController animated:YES];
    }
}
    




@end











