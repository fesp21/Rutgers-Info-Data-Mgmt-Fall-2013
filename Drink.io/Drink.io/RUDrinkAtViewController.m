//
//  RUDrinkAtViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDrinkAtViewController.h"
#import "RUDBManager.h"

@interface RUDrinkAtViewController () {
    CLLocationManager * locationManager;
    UIActivityIndicatorView *activityIndicator;
    RUDBManager * db;
    NSArray * bars;
}

@end

@implementation RUDrinkAtViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    db = [RUDBManager getSharedInstance];
    bars = [db getBars];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view delegate

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
    } else if (selectedCell.accessoryType == UITableViewCellAccessoryNone) {
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[bars objectAtIndex:indexPath.row] name];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - IBActions

- (IBAction)doneTapped:(id)sender {
    [self performSegueWithIdentifier:@"drink_with_friends" sender:self];
}

@end
