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
                      withPhone: (NSString *) phone
                     withStreet: (NSString *) street
                       withCity: (NSString *) city
                      withState: (NSString *) state
                        withZip: (NSString *) zip
                    withCountry: (NSString *) country
                withCountryCode: (NSString *) countryCode
                andWithFavorite: (NSInteger *) favorite;

- (BOOL)   addBarWithName: (NSString *) bar
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
          andWithFavorite: (NSInteger *) favorite;

- (BOOL) makeBestFriendWithFirstName: (NSString *) firstName
                        withLastName: (NSString *) lastName
                        andWithPhone: (NSString *) phone;

- (BOOL) makeFavoriteBarWithPhone: (NSString *) phone;

- (NSArray *) getFriends;
- (NSArray *) getBestFriends;
- (NSArray *) getBars;
- (NSArray *) getFavoriteBars;

- (NSString *) query: (NSString *) querySQL;

@end
