//
//  navigationTabBar.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "navigationTabBar.h"
#import "AFNetworking.h"
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface navigationTabBar ()

@end

@implementation navigationTabBar
UIView * myView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:58.0f/255.0f green:65.0f/255.0f blue:81.0f/255.0f alpha:1.0f]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:58 green:65 blue:81 alpha:1.0]];
    //[[UITabBar appearance] setBarTintColor:[self colorWithHexString:@"3a4151"]];
    [[UITabBar appearance] setBackgroundColor:[self colorWithHexString:@"3a4151"]];
    //[[UINavigationBar appearance] setBackgroundColor:[self colorWithHexString:@"3a4151"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"TabBarFinalFinal.png"]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"TabBarSelected1.png"]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSLog(@"elayy");
    if (IsIphone5) {
        myView = [[UIView alloc] initWithFrame:CGRectMake(0, 510, 320, 10)];
    }
    else{
        
        myView = [[UIView alloc] initWithFrame:CGRectMake(0, 422, 320, 10)];
        
    }
    
    myView.backgroundColor = [self colorWithHexString:@"3a4151"];
    [self.view addSubview:myView];
    [self.view bringSubviewToFront:self.tabBar];
    
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
