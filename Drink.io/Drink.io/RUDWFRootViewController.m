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
    NSLog(@"%@", worked ? @"yes" : @"No");
}

-(IBAction)drinkTapped:(id)sender
{
    NSLog(@"Drink tapped.\n");
    
    [self performSegueWithIdentifier:@"drink_with" sender:self];
}

@end
