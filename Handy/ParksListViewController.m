//
//  ParksListViewController.m
//  Handy
//
//  Created by Elay Datika on 5/17/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "ParksListViewController.h"
#import "AFNetworking.h"
#import "PlaceViewController.h"
#import "ListTableViewCell.h"
#import "ListPlaceViewController.h"
#import "SWRevealViewController.h"
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface ParksListViewController ()

@end

@implementation ParksListViewController
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
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.screenName = @"Parks List Screen";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.placesTableView.emptyDataSetSource = self;
    self.placesTableView.emptyDataSetDelegate = self;
    
    if (IsIphone5) {
        placesTableView.frame = CGRectMake(0, 0, 320, 559);
    }
    else {
        placesTableView.frame = CGRectMake(0, 0, 320, 471);
    }
    
    // A little trick for removing the cell separators
    self.placesTableView.tableFooterView = [UIView new];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString * requestURL = [NSString stringWithFormat:@"https://handy-il.com/Handy/returnParks.php"];
    
    
    
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
                                          UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"FAIL" message:@"Bla" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                                          
                                          [op start];
                                          [alert show];
                                      }];
    
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (arr == nil) {
        
        
        NSString *text = @"No Data";
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    else {
        
        NSString *text = @"Error";
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (arr == nil) {
        
        
        NSString *text = @"We're sorry, but we still don't have that kind of data.";
        
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     NSParagraphStyleAttributeName: paragraph};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    else {
        NSLog(@"js: %@", arr);
        
        NSString *text = @"Please try again later";
        
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     NSParagraphStyleAttributeName: paragraph};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    
    return nil;
}

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
    
    currentPlace = [placesData objectAtIndex:indexPath.row];
    NSLog(@"CURRENT: %@", currentPlace);
    // NSLog(@"Filtered: %@", patientsDataFiltered);
    
    
    //cell.backgroundColor = [UIColor clearColor];
    
    cell.typeLabel.text = currentPlace[@"PinType"];
    
    cell.nameLabel.text = currentPlace[@"PinName"];
    
    cell.decLabel.text = currentPlace[@"Description"];
    
    UIFont * latoBold20 = [UIFont fontWithName:@"Lato-Bold" size:20.0];
    UIFont * latoReg13 = [UIFont fontWithName:@"Lato-Regular" size:13.0];
    UIFont * latoLight15 = [UIFont fontWithName:@"Lato-Light" size:15.0];
    
    cell.nameLabel.font = latoBold20;
    cell.typeLabel.font = latoReg13;
    cell.decLabel.font = latoLight15;
    
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    currentPlaceForCell = [placesData objectAtIndex:indexPath.row];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    ListPlaceViewController * patientView = (ListPlaceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ListDetails"];
    patientView.nameLabel.text = currentPlaceForCell[@"PinName"];
    patientView.typeLabel.text = currentPlaceForCell[@"PinType"];
    patientView.decLabel.text = currentPlaceForCell[@"Description"];
    NSLog(@"NameForCell: %@", currentPlaceForCell);
    newReturnDict = currentPlaceForCell;
    [self.navigationController pushViewController:patientView animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(NSDictionary *)currentPlaceForCellDict {
    
    
    return newReturnDict;
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
