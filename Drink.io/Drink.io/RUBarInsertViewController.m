//
//  RUFavoriteBarsViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/19/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUBarInsertViewController.h"
#import "RUDBManager.h"
#import "RUBar.h"
#import "RUBarDetailViewController.h"

@interface RUBarInsertViewController () {
    CLLocationManager * locationManager;
    UIActivityIndicatorView *activityIndicator;
    RUDBManager * db;
    NSArray * allBars;
    NSInteger longPress;
}

@end

@implementation RUBarInsertViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    seeLocal = YES;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    allBars = [[RUDBManager getSharedInstance] getBars];
    
    db = [RUDBManager getSharedInstance];
    allBars = [db getBars];
    
    localBars = [[NSMutableArray alloc] init];
    
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    
    [locationManager startUpdatingLocation];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location Services

- (void) locationManager: (CLLocationManager *) manager didUpdateLocations: (NSArray *) locations {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"Bars";
    CLLocation* location = [locations lastObject];
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [localBars removeAllObjects];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else {
            for (MKMapItem *item in response.mapItems)
            {
                RUBar * bar = [[RUBar alloc] initWithName:item.name
                                          withPhoneNumber:item.phoneNumber
                                                  withUrl:item.url.scheme
                                          withThroughfare:item.placemark.thoroughfare
                                       withSubThroughfare:item.placemark.subThoroughfare
                                             withLocality:item.placemark.locality
                                          withSubLocality:item.placemark.subLocality
                                   withAdministrativeArea:item.placemark.administrativeArea
                                withSubAdministrativeArea:item.placemark.subAdministrativeArea
                                           withPostalCode:item.placemark.postalCode
                                       withISOcountryCode:item.placemark.ISOcountryCode
                                           andWithCountry:item.placemark.country];
                
                [localBars addObject:bar];
            }
            [self.tableView reloadData];
            [activityIndicator removeFromSuperview];
        }
    }];
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * currentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (currentCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        currentCell.accessoryType = UITableViewCellAccessoryNone;
        
        if (seeLocal) {
            [[localBars objectAtIndex:indexPath.row] removeFromDatabase];
        } else {
            [[allBars objectAtIndex:indexPath.row] toggleFrequentFor:@"user name"];
        }
        
    } else {
        currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (seeLocal) {
            [[localBars objectAtIndex:indexPath.row] insertIntoDatabase];
        } else {
            [[allBars objectAtIndex:indexPath.row] toggleFrequentFor:@"user name"];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if (seeLocal) {
        numberOfRows = [localBars count];
    } else {
        numberOfRows = [allBars count];
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell4";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (seeLocal && localBars != NULL) {
        cell.textLabel.text = [[localBars objectAtIndex:indexPath.row] name];
        
        if ([[localBars objectAtIndex:indexPath.row] isInDatabase]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else cell.accessoryType = UITableViewCellAccessoryNone;
        
    } else {
        
        if ([allBars count] == 0) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"No saved bars"
                                                         message:@"You need to add a local bar to the database!"
                                                        delegate:self
                                               cancelButtonTitle:@"Okay"
                                               otherButtonTitles:nil,
                               nil];
            
            [av setAlertViewStyle:UIAlertViewStyleDefault];
            [av show];
            
            seeLocal = YES;
            [self.tableView reloadData];
            
        } else {
            cell.textLabel.text = [[allBars objectAtIndex:indexPath.row] name];
            
            if ([[allBars objectAtIndex:indexPath.row] isFrequentedByUserWithName:@"user name"]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"bar_detail_view"]){
        RUBarDetailViewController * detailView = [segue destinationViewController];
        detailView.bar = [allBars objectAtIndex:longPress];
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        if (indexPath == nil){
            
        } else if ([self.tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
            
            [self performSegueWithIdentifier:@"bar_detail_view" sender:self.tableView];
            longPress = indexPath.row;
        }
    }
}

#pragma mark - IBActions

- (IBAction)seeAllTapped:(id)sender
{
    seeLocal = !seeLocal;
    
    allBars = [db getBars];
    
    if (seeLocal) {
        self.navigationItem.rightBarButtonItem.title = @"See all";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"See local";
    }
    
    [self.tableView reloadData];
}

@end
