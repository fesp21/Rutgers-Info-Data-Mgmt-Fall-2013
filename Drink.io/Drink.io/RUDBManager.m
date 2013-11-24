//
//  RUDBManager.m
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDBManager.h"
#import "RUBeer.h"
#import "RUFriend.h"
#import "RUBar.h"

#define BARS_TABLE_NAME @"bars"
#define BEERS_TABLE_NAME @"beers"
#define DRINKER_TABLE_NAME @"drinkers"
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
                           nil]];
        
        [self createTable:DRINKER_TABLE_NAME
        andWithParameters:[[NSArray alloc] initWithObjects:
                           @"firstName char(64)",
                           @"lastName char(64)",
                           @"goneOutWith int",
                           @"gender int",
                           @"ageGroup int",
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
        
        [[[RUFriend alloc] initWithFirstName:@"user" withLastName:@"name" withGender:0 andWithAge:0] insertIntoDatabase];
        
        [self insertBeerWithName:@"Bud Light" andManufacturer:@"Anheuser-Busch InBev"];
        [self insertBeerWithName:@"Budweiser" andManufacturer:@"Anheuser-Busch InBev"];
        [self insertBeerWithName:@"Coors Light" andManufacturer:@"Millercoors Brewing"];
        [self insertBeerWithName:@"Miller Lite" andManufacturer:@"Millercoors Brewing"];
        [self insertBeerWithName:@"Natural Light" andManufacturer:@"Anheuser-Busch InBev"];
        [self insertBeerWithName:@"Corona Extra" andManufacturer:@"Crown Imports"];
        [self insertBeerWithName:@"Busch Light" andManufacturer:@"Anheuser-Busch InBev"];
        [self insertBeerWithName:@"Busch" andManufacturer:@"Anheuser-Busch InBev"];
        [self insertBeerWithName:@"Heineken" andManufacturer:@"Heineken"];
        [self insertBeerWithName:@"Michelob Ultra" andManufacturer:@"Anheuser-Busch InBev"];
        [self insertBeerWithName:@"Miller High Life" andManufacturer:@"Millercoors Brewing"];
        [self insertBeerWithName:@"Keystone Light" andManufacturer:@"Millercoors Brewing"];
        [self insertBeerWithName:@"Natural Ice" andManufacturer:@"Anheuser Busch InBev"];
        [self insertBeerWithName:@"Modelo Especial" andManufacturer:@"Crown Imports"];
        [self insertBeerWithName:@"Bud Light Lime" andManufacturer:@"Anheuser Busch InBev"];
        [self insertBeerWithName:@"Icehouse" andManufacturer:@"Millercoors Brewing"];
        [self insertBeerWithName:@"Bud Ice" andManufacturer:@"Anheuser Busch InBev"];
        [self insertBeerWithName:@"PBR" andManufacturer:@"Pabst Brewing Co."];
        [self insertBeerWithName:@"Yuengling Lager" andManufacturer:@"D G Yuengling & Sons"];
        [self insertBeerWithName:@"Corona Light" andManufacturer:@"Crown Imports"];
    }
    
}

- (BOOL) executeUpdate: (NSString *) update {
    return [db executeUpdate:update];
}

- (BOOL) insertBeerWithName: (NSString *) name andManufacturer: (NSString *) manf
{
    return [self insertIntoTable:BEERS_TABLE_NAME
                  withParameters:[[NSArray alloc] initWithObjects:
                                  name,
                                  manf,
                                  nil]];
}

- (NSMutableArray *) getBars {
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"select * from bars"];
    NSMutableArray * response = [[NSMutableArray alloc] init];
    
    FMResultSet * rs = [db executeQuery:query];
    
    NSLog(@"%@", query);
    
    while ([rs next]) {
        
        NSString * name= [rs stringForColumn:@"name"]; // @"name char(64)",
        NSString * phoneNumber= [rs stringForColumn:@"phoneNumber"];// @"phoneNumber char(64) primary key not null",
        NSString * url= [rs stringForColumn:@"url"];// @"url char(64)",
        NSString * thoroughfare= [rs stringForColumn:@"thoroughfare"];// @"thoroughfare char(64)",
        NSString * subThoroughfare= [rs stringForColumn:@"subThoroughfare"];// @"subThoroughfare char(64)",
        NSString * locality= [rs stringForColumn:@"locality"];// @"locality char(64)",
        NSString * subLocality= [rs stringForColumn:@"subLocality"];// @"subLocality char(64)",
        NSString * administrativeArea= [rs stringForColumn:@"administrativeArea"];// @"administrativeArea char(64)",
        NSString * subAdministrativeArea= [rs stringForColumn:@"subAdministrativeArea"];// @"subAdministrativeArea char(64)",
        NSString * postalCode= [rs stringForColumn:@"postalCode"];// @"postalCode char(64)",
        NSString * ISOcountryCode= [rs stringForColumn:@"ISOcountryCode"];// @"ISOcountryCode char(64)",
        NSString * country= [rs stringForColumn:@"country"];// @"country char(64)",
        
        RUBar * bar = [[RUBar alloc] initWithName:name
                                  withPhoneNumber:phoneNumber
                                          withUrl:url
                                  withThroughfare:thoroughfare
                               withSubThroughfare:subThoroughfare
                                     withLocality:locality
                                  withSubLocality:subLocality
                           withAdministrativeArea:administrativeArea
                        withSubAdministrativeArea:subAdministrativeArea
                                   withPostalCode:postalCode
                               withISOcountryCode:ISOcountryCode
                                   andWithCountry:country];
        
        [response addObject:bar];
    }
    
    return response;
}

- (NSMutableArray *) getBeers
{
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"select * from beers"];
    NSMutableArray * response = [[NSMutableArray alloc] init];
    
    FMResultSet * rs = [db executeQuery:query];
    
    while ([rs next]) {
        NSString * name = [rs stringForColumn:@"name"];
        NSString * manf = [rs stringForColumn:@"manf"];
        
        [response addObject:[[RUBeer alloc] initWithName:name andWithManufacturer:manf]];
    }
    
    return response;
}

- (FMResultSet *) executeQuery: (NSString *) query
{
    return [db executeQuery:query];
}

- (BOOL) insertIntoTable: (NSString *) withName withParameters: (NSArray *) parameters
{
    NSMutableString * insertStatement = [[NSMutableString alloc] initWithFormat:@"insert into %@ values (", withName];
    
    for (int i = 0; i < [parameters count]; i++) {
        NSString * parameter = [parameters objectAtIndex:i];
        
        if (i < [parameters count] - 1)
            [insertStatement appendFormat:@"\"%@\",", parameter];
        else
            [insertStatement appendFormat:@"\"%@\"", parameter];
    }
    
    [insertStatement appendString:@");"];
    
    return [db executeUpdate:insertStatement];
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

- (NSArray *) getFriends {
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"select * from drinkers"];
    NSMutableArray * response = [[NSMutableArray alloc] init];
    
    FMResultSet * rs = [db executeQuery:query];
    
    while ([rs next]) {
        RUFriend * friend = [[RUFriend alloc] init];
        
        friend.firstName = [rs stringForColumn:@"firstName"];
        friend.lastName = [rs stringForColumn:@"lastName"];
        
        if (![[friend fullName] isEqualToString:@"user name"])
            [response addObject:friend];
    }
    
    return response;
}
- (NSMutableArray *) getBestFriends {
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"SELECT * "
                               " FROM drinkers d"
                               " WHERE goneOutWith IS NOT NULL AND goneOutWith <> 0"
                               " ORDER BY goneOutWith DESC"];
    
    NSMutableArray * bestFriends = [[NSMutableArray alloc] init];
    
    FMResultSet * rs = [db executeQuery:query];
    
    while ([rs next]) {
        RUFriend * friend = [[RUFriend alloc] init];
        
        friend.firstName = [rs stringForColumn:@"firstName"];
        friend.lastName = [rs stringForColumn:@"lastName"];
        
        if (![[friend fullName] isEqualToString:@"user name"])
            [bestFriends addObject:friend];
    }
    
    return bestFriends;
}

@end

