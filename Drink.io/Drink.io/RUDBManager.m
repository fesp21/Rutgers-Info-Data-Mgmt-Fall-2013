//
//  RUDBManager.m
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDBManager.h"

#define BARS_TABLE_NAME @"bars"
#define BEERS_TABLE_NAME @"beers"
#define DRINKER_TABLE_NAME @"drinker"
#define DISTANCE_TABLE_NAME @"distance"
#define SELLS_TABLE_NAME @"sells"
#define LIKES_TABLE_NAME @"likes"
#define FREQUENTS_TABLE_NAME @"frequents"

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
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"drinkwithfriends.sqlite"];
    BOOL alreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
    
    db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    if (!alreadyExists){
        [self createTable:BEERS_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"name char(64)",
                           @"manf char(64)",
                           nil]];
        
        [self createTable:BARS_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"name char(64)",
                           @"phoneNumber char(64) primary key not null",
                           @"url char(64)",
                           @"thoroughfare char(64)",
                           @"subThoroughfare char(64)",
                           @"locality char(64)",
                           @"subLocality char(64)",
                           @"administrativeArea char(64)",
                           @"subAdministrativeArea char(64)",
                           @"postalCode char(64)",
                           @"ISOcountryCode char(64)",
                           @"country char(64)",
                           @"int favorite",
                           nil]];
        
        [self createTable:DRINKER_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"firstname char(64)",
                           @"lastname char(64)",
                           @"phone char(20) primary key not null",
                           @"addrStreet char(64)",
                           @"addrCity char(64)",
                           @"addrState char(64)",
                           @"addrZip char(64)",
                           @"addrCountry char(64)",
                           @"addrCountryCode char(64)",
                           @"int favorite",
                           nil]];
        
        [self createTable:DISTANCE_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"friendOneFirstName char(64)",
                           @"friendOneLastName char(64)",
                           @"friendTwoFirstName char(64)",
                           @"friendTwoLastName char(64)",
                           @"distanceKM real",
                           nil]];
        
        [self createTable:SELLS_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"bar char(64)",
                           @"beer char(64)",
                           @"price real",
                           nil]];
        
        [self createTable:LIKES_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"drinker char(20)",
                           @"beer char(20)",
                           nil]];
        
        [self createTable:FREQUENTS_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"drinker char(20)",
                           @"bar char(20)",
                           nil]];
    }
    
}

- (void) insertIntoTable: (NSString *) withName withParameters: (NSArray *) parameters
{
    
    NSMutableString * insertStatement = [[NSMutableString alloc] initWithFormat:@"insert into %@ values (", withName];
    
    NSLog(@"%@", insertStatement);
    
    for (int i = 0; i < [parameters count]; i++) {
        NSString * parameter = [parameters objectAtIndex:i];
        
        NSLog(@"%@", parameter);
        
        if (i < [parameters count] - 1)
            [insertStatement appendFormat:@"\"%@\",", parameter];
        else
            [insertStatement appendFormat:@"\"%@\"", parameter];
    }
    
    [insertStatement appendString:@");"];
    
    [db executeUpdate:insertStatement];
}

- (void) createTable: (NSString *) withName andWithParameters: (NSArray *) parameters
{
    NSMutableString * update = [[NSMutableString alloc] initWithFormat:@"create table %@ (", withName];
    
    for (int i = 0; i < [parameters count]; i++) {
        NSString * parameter = [parameters objectAtIndex:i];
        if (i < [parameters count] - 1)
            [update appendFormat:@"%@,", parameter];
        else
            [update appendFormat:@"%@", parameter];
    }
    
    [update appendString:@");]"];
    
    if (![db executeUpdate:update])
        NSLog(@"WARNING! Table \"%@\" was not created!", withName);
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

