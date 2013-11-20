//
//  RUDBManager.m
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDBManager.h"

static RUDBManager *sharedInstance = nil;

@implementation RUDBManager

+ (RUDBManager *) getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDatabase];
    }
    
    return sharedInstance;
}

- (void) createDatabase {
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"barbeerdrinker.db"];
    db     = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    NSLog(@"Do you have a good connection to the database? %@", [db goodConnection] ? @"YES" : @"NO");
    
    
}

- (NSString *) query: (NSString *) querySQL {
    return @"Interesting";
}

- (void) addFriendWithFirstName: (NSString *) firstName
                   withLastName: (NSString *) lastName
                      withPhone: (NSString *) phone
                     withStreet: (NSString *) street
                       withCity: (NSString *) city
                      withState: (NSString *) state
                        withZip: (NSString *) zip
                    withCountry: (NSString *) country
                withCountryCode: (NSString *) countryCode
                andWithFavorite: (NSInteger) favorite {
    
}

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
          andWithFavorite: (NSInteger) favorite {
    
}


- (void) makeBestFriendWithFirstName: (NSString *) firstName
                        withLastName: (NSString *) lastName
                        andWithPhone: (NSString *) phone {
}

- (void) makeFavoriteBarWithPhone: (NSString *) phone {
}

- (NSArray *) getFriends {
    NSArray * friends = [[NSArray alloc] init];
    
    return friends;
}
- (NSArray *) getBestFriends {
    NSArray * bestFriends = [[NSArray alloc] initWithObjects:@"Paul Jones",@"Frank Porco", @"Tomasz Imielinski", nil];
    
    return bestFriends;
}
- (NSArray *) getBars {
    NSArray * bars = [[NSArray alloc] init];
    
    return bars;
}
- (NSArray *) getFavoriteBars {
    NSArray * favoriteBars = [[NSArray alloc] initWithObjects:@"Clydz",@"Harvest Moon", @"Stuff Yer Face", nil];
    
    return favoriteBars;
}




@end

