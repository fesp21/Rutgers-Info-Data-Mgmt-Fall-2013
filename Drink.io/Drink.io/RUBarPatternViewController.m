//
//  RUBarPatternViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/23/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUBarPatternViewController.h"
#import "RUDBManager.h"
#import "RUBar.h"
#import "RUPatternDetailViewController.h"

@interface RUBarPatternViewController () {
    NSMutableArray * allBars;
    RUBar * selectedBar;
}

@end

@implementation RUBarPatternViewController

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
    
    allBars = [[RUDBManager getSharedInstance] getBars];

    NSLog(@"Hello I am here.");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedBar = [allBars objectAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [allBars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell50";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"%@", [[allBars objectAtIndex:indexPath.row] name]);
    cell.textLabel.text = [[allBars objectAtIndex:indexPath.row] name];
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail_pattern"]) {
        RUPatternDetailViewController * pdvc = [segue destinationViewController];
        pdvc.gender = [selectedBar isMostCommonGenderMale] ? 1 : 0;
        pdvc.ageGroup = [selectedBar getAgeGroup];
    }
}

@end
