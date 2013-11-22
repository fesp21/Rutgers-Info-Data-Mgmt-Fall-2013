//
//  RUBarDetailViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RUBar.h"

@interface RUBarDetailViewController : UITableViewController {
}

@property (nonatomic, retain) RUBar * bar;

- (IBAction)questionMarkPressed:(id)sender;

@end
