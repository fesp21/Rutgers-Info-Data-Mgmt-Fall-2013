//
//  RUBeer.h
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RUBar.h"

@interface RUBeer : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * manf;

- (RUBeer *) initWithName: (NSString *) name andWithManufacturer: (NSString *) manf;

- (BOOL) insertIntoDatabase;
- (BOOL) removeFromDatabase;

- (BOOL) isSoldAtBar: (RUBar *) bar;
- (void) toggleLikeFor: (NSString *) likersName;
- (BOOL) likedByUser;
- (BOOL) islikedByUserWithName: (NSString *) name;
- (void) toggleLike;

@end
