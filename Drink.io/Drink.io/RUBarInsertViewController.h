//
//  RUFavoriteBarsViewController.h
//  Drink.io
//
//  Created by Paul Jones on 11/19/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RUBarInsertViewController : UITableViewController<CLLocationManagerDelegate, UIGestureRecognizerDelegate> {
    NSMutableArray * localBars;
    BOOL seeLocal;
}

@end
