//
//  RUBestFriendsViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/19/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUFriendInsertViewController : UITableViewController<UIGestureRecognizerDelegate> {
    NSMutableArray * people;
}

@property (nonatomic, assign) BOOL generate;

- (IBAction) helpedTapped:(id)sender;

@end
