//
//  RUDWFRootViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/17/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDWFRootViewController.h"
#import "RUDBManager.h"
#import "RUFriendInsertViewController.h"

@implementation RUDWFRootViewController

- (void) viewWillAppear:(BOOL)animated
{
    RUDBManager * db = [RUDBManager getSharedInstance];
}

-(IBAction)drinkTapped:(id)sender
{
    [self performSegueWithIdentifier:@"drink_with" sender:self];
}

- (IBAction)generateTapped:(id)sender {
    generate = true;
    [self performSegueWithIdentifier:@"drink_with_people" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"drink_with_people"] && generate) {
        RUFriendInsertViewController * dest = [segue destinationViewController];
        dest.generate = true;
    }
}

@end
