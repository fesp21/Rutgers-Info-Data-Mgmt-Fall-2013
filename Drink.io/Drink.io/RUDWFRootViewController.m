//
//  RUDWFRootViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/17/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDWFRootViewController.h"
#import "RUDBManager.h"

@implementation RUDWFRootViewController

- (void) viewWillAppear:(BOOL)animated
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    BOOL worked = [db createDB];
    
    worked = [db addBarWithName:@"Testing" withPhoneNumber:@"7489198238" withURL:@"http://asnjdkjnsa.com" withThoroughfare:@"me" withSubThoroughfare:@"here" withLocality:@"now" withSubLocality:@"later" withAdministrativeArea:@"because" withSubAdministrativeArea:@"frege" withPostalCode:@"logic" withISOcountryCode:@"scholar" withCountry:@"love" andWithFavorite:0];
    
    NSLog(@"%@", worked ? @"yes" : @"No");
}

-(IBAction)drinkTapped:(id)sender
{
    [self performSegueWithIdentifier:@"drink_with" sender:self];
}

- (IBAction) sqlTapped: (id) sender
{
    [self performSegueWithIdentifier:@"sql" sender:self];
}

@end
