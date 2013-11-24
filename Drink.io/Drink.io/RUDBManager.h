//
//  RUDBManager.h
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface RUDBManager : NSObject
{
    NSString *databasePath;
    FMDatabase *db;
}

+ (RUDBManager *) getSharedInstance;

- (BOOL) insertIntoTable: (NSString *) withName withParameters: (NSArray *) parameters;
- (BOOL) executeUpdate: (NSString *) update;
- (FMResultSet *) executeQuery: (NSString *) query;

- (void) makeBestFriendWithFirstName: (NSString *) firstName
                        withLastName: (NSString *) lastName
                        andWithPhone: (NSString *) phone;

- (void) makeFavoriteBarWithPhone: (NSString *) phone;

- (NSMutableArray *) getBeers;
- (NSArray *) getFriends;
- (NSMutableArray *) getBestFriends;
- (NSMutableArray *) getBars;

@end
