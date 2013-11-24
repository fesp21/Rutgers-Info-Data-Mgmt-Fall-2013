//
//  RUDWFRootViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/17/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUDWFRootViewController : UIViewController {
    BOOL generate;
}

- (IBAction) drinkTapped: (id) sender;
- (IBAction) generateTapped: (id) sender;

@end
