//
//  RUBeersViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUBeersViewController : UITableViewController<UIAlertViewDelegate> {
    NSMutableArray * beers;
}

- (IBAction)plusTapped:(id)sender;

@end
