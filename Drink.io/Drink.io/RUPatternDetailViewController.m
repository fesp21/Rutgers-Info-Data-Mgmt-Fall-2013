//
//  RUPatternDetailViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/23/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUPatternDetailViewController.h"

@interface RUPatternDetailViewController ()

@end

@implementation RUPatternDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"%i %i", self.ageGroup, self.gender);
    
    if (self.ageGroup == 0) {
        self.ageLabel.text = @"21 - 29";
    } else if (self.ageGroup == 1) {
        self.ageLabel.text = @"30 - 39";
    } else if (self.ageGroup == 2) {
        self.ageLabel.text = @"40 - 49";
    } else if (self.ageGroup == 3) {
        self.ageLabel.text = @">50";
    }
    
    if (self.gender == 0) {
        self.genderLable.text = @"Female";
    } else {
        self.genderLable.text = @"Male";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
