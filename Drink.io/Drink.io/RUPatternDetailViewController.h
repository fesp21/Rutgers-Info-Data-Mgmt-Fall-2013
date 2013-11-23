//
//  RUPatternDetailViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/23/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUPatternDetailViewController : UIViewController

@property IBOutlet UILabel * ageLabel;
@property IBOutlet UILabel * genderLable;

@property (assign, nonatomic) NSInteger ageGroup;
@property (assign, nonatomic) NSInteger gender;

@end
