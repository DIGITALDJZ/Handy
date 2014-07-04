//
//  ListViewController.m
//  Handy
//
//  Created by Elay Datika on 5/10/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "ListViewController.h"
#import "AFNetworking.h"
#import "PlaceViewController.h"
#import "ListTableViewCell.h"
#import "ListPlaceViewController.h"
#import "SWRevealViewController.h"
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize placesTableView, getData;
int i;
NSURL *imageUrl;
NSString * photoString;
NSString * name;
NSDictionary *currentPlace;
NSDictionary * currentPlaceForCell;
NSArray * placesDataFiltered;
float progress;
NSMutableArray * jsonResponse;
NSDictionary * newReturnDict;
NSURL * imageUrl;
NSString * photoString;
NSIndexPath * indexPathForLoad;

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
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"Family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"~~~~~~~~");
    }
    
    if (IsIphone5) {
        placesTableView.frame = CGRectMake(0, 0, 320, 559);
    }
    else {
        placesTableView.frame = CGRectMake(0, 0, 320, 471);
    }
    
    self.placesTableView.emptyDataSetSource = self;
    self.placesTableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.placesTableView.tableFooterView = [UIView new];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.screenName = @"List Screen";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    //[self.placesTableView addSubview:refreshControl];
    
    [self getPlacesData];
    
    [self tableView:placesTableView cellForRowAtIndexPath:indexPathForLoad];
    
    
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

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getPlacesData];
    [refreshControl endRefreshing];
}



- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"Loading...";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/*- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
                                 
    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
        return [placesData count];
        
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ListTableViewCell";
    
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    indexPathForLoad = indexPath;
    
        currentPlace = [placesData objectAtIndex:indexPath.row];
    NSLog(@"CURRENT: %@", currentPlace);
        // NSLog(@"Filtered: %@", patientsDataFiltered);
        
        
        //cell.backgroundColor = [UIColor clearColor];
        
        cell.typeLabel.text = currentPlace[@"PinType"];
        
        cell.nameLabel.text = currentPlace[@"PinName"];
        
        cell.decLabel.text = currentPlace[@"Description"];
    
      //  UIFont * roboto = [UIFont fontWithName:@"Roboto-Light" size:15.0];
    //UIFont * robotoReg = [UIFont fontWithName:@"Roboto-Regular" size:20.0];
    UIFont * latoBold20 = [UIFont fontWithName:@"Lato-Bold" size:20.0];
    UIFont * latoReg13 = [UIFont fontWithName:@"Lato-Regular" size:13.0];
    UIFont * latoLight15 = [UIFont fontWithName:@"Lato-Light" size:15.0];
    
    cell.nameLabel.font = latoBold20;
    cell.typeLabel.font = latoReg13;
    cell.decLabel.font = latoLight15;
    cell.decLabel.textColor = [self colorWithHexString:@"6b6b6b"];
    cell.typeLabel.textColor = [self colorWithHexString:@"464646"];
    cell.nameLabel.textColor = [self colorWithHexString:@"121212"];
    
        photoString = currentPlace[@"ImageDirectory"];
    
    ListPlaceViewController * imageViewController = [[ListPlaceViewController alloc]init];
    
    cell.cellImage.image = [imageViewController returnListPatientImage];
        //photoString = currentPatient[@"PatientPhoto"];
        
        //imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://handy-il.com/PrayForYourBrother/patientsImages/%@", photoString]];
        
        // NSLog(@"PhotoString: %@", photoString);
        //NSLog(@"URL: %@", imageUrl);
        
        // NSData *patientImageData = [[NSData alloc]initWithContentsOfURL:imageUrl];
        
        //NSData * patientImageData =  [NSData dataWithContentsOfURL:imageUrl];
        
        //UIImage * patientImage = [UIImage imageWithData:patientImageData];
        //getImagesRequest *patientNewImage = [[getImagesRequest alloc]init];
        
        //[patientNewImage returnListPatientImage];
        //[cell.image setImage:[UIImage imageWithData:patientImage]];
        //cell.image.image = [patientNewImage returnListPatientImage];
    
    return cell;
    
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


        currentPlaceForCell = [placesData objectAtIndex:indexPath.row];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    ListPlaceViewController * view = (ListPlaceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ListDetails"];
    view.nameLabel.text = currentPlaceForCell[@"PinName"];
    view.typeLabel.text = currentPlaceForCell[@"PinType"];
    view.decLabel.text = currentPlaceForCell[@"Description"];
    NSLog(@"NameForCell: %@", currentPlaceForCell);
    newReturnDict = currentPlaceForCell;
    [self.navigationController pushViewController:view animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(NSDictionary *)currentPlaceForCellDict {
    
    
    return newReturnDict;
}

- (void) getPlacesData {
    
    
    NSLog(@"Getting Data...");
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString * requestURL = [NSString stringWithFormat:@"https://handy-il.com/Handy/vla.php"];
    
    
    
    //send the request
    AFHTTPRequestOperation *op = [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) { //if success
        getData = operation.responseString;
        //NSLog(@"DATA: %@", getData);
        
        //NSLog(@"BLA");
        jsonResponse = [NSJSONSerialization JSONObjectWithData:[getData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        //NSLog(@"JSONRE: %@", jsonResponse);
        placesData = [[NSMutableArray alloc]init];
        for (i=0; i<[jsonResponse count]; i++) {
            //NSLog(@"%@", getPatientsRequest.getData);
            arr = [[[jsonResponse valueForKey:@"locations"] objectAtIndex:i] mutableCopy];
            
            
            //NSLog(@"arr: %@", arr);
            //NSLog(@"PatientsData: %@", patientsData);
            [placesData addObject:arr];
            NSLog(@"placesDatablabla: %@", placesData);
        }
        
        [placesTableView reloadData];
        
        
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) { // if failed
                                          NSLog(@"Error: %@", error);
                                          UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error loading data. Please check your internet connection or try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                                          
                                          [op start];
                                          [alert show];
                                      }];
    
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
