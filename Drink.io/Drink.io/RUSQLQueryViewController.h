//
//  RUSQLQueryViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/19/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUSQLQueryViewController : UIViewController {
    IBOutlet UITextField * textFieldForQuery;
    IBOutlet UITextView * textViewForResults;
}

- (IBAction) doneTapped: (id) sender;
- (IBAction) runTapped: (id) sender;

@end
