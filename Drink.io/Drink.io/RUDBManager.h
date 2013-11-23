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

- (void) addFriendWithFirstName: (NSString *) firstName
                   withLastName: (NSString *) lastName
                      withPhone: (NSString *) phone
                     withStreet: (NSString *) street
                       withCity: (NSString *) city
                      withState: (NSString *) state
                        withZip: (NSString *) zip
                    withCountry: (NSString *) country
                withCountryCode: (NSString *) countryCode
                andWithFavorite: (NSInteger) favorite;

- (void)   addBarWithName: (NSString *) bar
          withPhoneNumber: (NSString *) phoneNumber
                  withURL: (NSString *) URL
         withThoroughfare: (NSString *) thoroughfare
      withSubThoroughfare: (NSString *) subThoroughfare
             withLocality: (NSString *) locality
          withSubLocality: (NSString *) subLocality
   withAdministrativeArea: (NSString *) administrativeArea
withSubAdministrativeArea: (NSString *) subAdministrativeArea
           withPostalCode: (NSString *) postalCode
       withISOcountryCode: (NSString *) ISOcountryCode
              withCountry: (NSString *) country
          andWithFavorite: (NSInteger) favorite;

- (void) makeBestFriendWithFirstName: (NSString *) firstName
                        withLastName: (NSString *) lastName
                        andWithPhone: (NSString *) phone;

- (void) makeFavoriteBarWithPhone: (NSString *) phone;

- (NSMutableArray *) getBeers;
- (NSArray *) getFriends;
- (NSMutableArray *) getBestFriends;
- (NSMutableArray *) getBars;

- (NSString *) query: (NSString *) querySQL;

@end
