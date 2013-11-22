//
//  RUFriendDetailViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/22/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUFriendDetailViewController.h"
#import "RUDBManager.h"
#import "RUBeer.h"
#import "RUBar.h"

@interface RUFriendDetailViewController () {
    BOOL showBeers; // the opposite of view is "frequents"
    NSMutableArray * beers;
    NSMutableArray * bars;
}
@end

@implementation RUFriendDetailViewController

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
    
    showBeers = YES;
    
    beers = [[RUDBManager getSharedInstance] getBeers];
    bars = [[RUDBManager getSharedInstance] getBars];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (showBeers) {
        [[beers objectAtIndex:indexPath.row] toggleLikeFor: self.thisFriendsName];
        
        if ([[beers objectAtIndex:indexPath.row] islikedByUserWithName:self.thisFriendsName]) {
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        }
        
    } else {
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (showBeers)
        return [beers count];
    else
        return [bars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell10";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (showBeers) {
        cell.textLabel.text = [[beers objectAtIndex:indexPath.row] name];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([[beers objectAtIndex:indexPath.row] islikedByUserWithName:self.thisFriendsName]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.textLabel.text = [[bars objectAtIndex:indexPath.row] name];
    }
    
    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction) switchTapped:(id)sender {
    showBeers = !showBeers;
    [self.tableView reloadData];
    
    if (showBeers) {
        self.navigationItem.rightBarButtonItem.title = @"Bars";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Beers";
    }
    
}

@end
