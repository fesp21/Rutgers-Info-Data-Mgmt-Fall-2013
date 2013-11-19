//
//  RUDBManager.h
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface RUDBManager : NSObject
{
    NSString *databasePath;
}

+ (RUDBManager *) getSharedInstance;

- (BOOL) createDB;

- (BOOL) addFriendWithFirstName: (NSString *) firstName
                   withLastName: (NSString *) lastName
                 andWithAddress: (NSString *) address;

- (BOOL) addBarWithName: (NSString *) bar
        withPhoneNumber: (NSString *) phoneNumber
         andWithAddress: (NSString *) address;

- (BOOL) addBestFriendWithFirstName: (NSString *) firstName
                       withLastName: (NSString *) lastName
                     andWithAddress: (NSString *) address;

- (BOOL) addFavoriteBarWithName: (NSString *) bar
                withPhoneNumber: (NSString *) phoneNumber
                 andWithAddress: (NSString *) address;

- (NSArray *) getFriends;
- (NSArray *) getBestFriends;
- (NSArray *) getBars;
- (NSArray *) getFavoriteBars;

@end
