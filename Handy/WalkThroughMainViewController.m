//
//  WalkThroughMainViewController.m
//  HealthyBelly
//
//  Created by gil maman on 11/02/2014.
//  Copyright (c) 2014 gil maman. All rights reserved.
//

#import "WalkThroughMainViewController.h"

@interface WalkThroughMainViewController ()

@end

@implementation WalkThroughMainViewController

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
    
    //Make page controller
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:
                           UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(0, -10, self.view.frame.size.width, self.view.frame.size.height)];
    
    //sets the first view to open
    WalkThroughChildViewController * initialViewController = [self viewControllerAtIndex:0]; // first view index
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    //addes the page controller to the view
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}


#pragma mark page controller setup

//returns a walkthrough view with index
- (WalkThroughChildViewController *)viewControllerAtIndex:(NSUInteger)index {
        
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //init storyBoar
    
    NSString * nextViewControllerName = [NSString stringWithFormat:@"WalkThroughViewController%li",index];
    WalkThroughChildViewController * childViewController = (WalkThroughChildViewController *)[storyBoard instantiateViewControllerWithIdentifier:nextViewControllerName];
    childViewController.index = index;
        
    return childViewController;
    
}

//Decres the index when swiping back to prev view
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(WalkThroughChildViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

//add to the index when swiping forward
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(WalkThroughChildViewController *)viewController index];
    
    index++;
    
    if (index == [self returnAmountOfViews]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

// sets how many views there are in the page controller
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator
    return [self returnAmountOfViews];
}

//returns the amount of views there are for the walkthrough
-(int)returnAmountOfViews {
    int numOfViews = 0;
    @try {
        
        while (true) {
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //init storyBoar
            NSString * nextWalkthroughName = [NSString stringWithFormat:@"WalkThroughViewController%i",numOfViews]; // next walktrhough storyboard id
            WalkThroughMainViewController * nextWalkthroughView = (WalkThroughMainViewController *)[storyBoard instantiateViewControllerWithIdentifier:nextWalkthroughName];
            if (nextWalkthroughView) {
                numOfViews++;
            }
        }
        
    }@catch (NSException * exception) {
    }
    
    return numOfViews;

}

// the first selected walkthrough view
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

#pragma mark memory care

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
