//
//  RUDWFRootViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/17/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDWFRootViewController.h"
#import <MapKit/MapKit.h>

@implementation RUDWFRootViewController

-(IBAction)importFriendsTapped:(id)sender {
    NSLog(@"Import freinds tapped.\n");
    
}
-(IBAction)importBarsTapped:(id)sender {
    NSLog(@"Import bars tapped.\n");
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"Bars";
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            for (MKMapItem *item in response.mapItems)
            {
                NSLog(@"name = %@", item.name);
                NSLog(@"Phone = %@", item.phoneNumber);
            }
    }];
    
}
-(IBAction)drinkTapped:(id)sender {
    NSLog(@"Drink tapped.\n");
    [self performSegueWithIdentifier:@"drink_with" sender:self];
}

@end
