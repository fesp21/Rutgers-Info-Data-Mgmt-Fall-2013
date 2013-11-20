//
//  RUSQLQueryViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/19/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUSQLQueryViewController.h"
#import "RUDBManager.h"

@interface RUSQLQueryViewController () {
    RUDBManager * db;
}

@end

@implementation RUSQLQueryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        db = [RUDBManager getSharedInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions 

- (IBAction) runTapped: (id) sender {
    [textViewForResults setText: [db query:textFieldForQuery.text]];
}

- (IBAction) doneTapped: (id) sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
