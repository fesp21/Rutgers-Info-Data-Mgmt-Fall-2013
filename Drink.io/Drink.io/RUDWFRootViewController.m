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
