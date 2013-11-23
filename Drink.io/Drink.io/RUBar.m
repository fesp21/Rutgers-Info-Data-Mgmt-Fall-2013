//
//  RUBars.m
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUBar.h"
#import "RUDBManager.h"

@implementation RUBar

- (RUBar *)   initWithName: (NSString *) name
           withPhoneNumber: (NSString *) phoneNumber
                   withUrl: (NSString *) url
           withThroughfare: (NSString *) thoroughfare
        withSubThroughfare: (NSString *) subThoroughfare
              withLocality: (NSString *) locality
           withSubLocality: (NSString *) subLocality
    withAdministrativeArea: (NSString *) administrativeArea
 withSubAdministrativeArea: (NSString *) subAdministrativeArea
            withPostalCode: (NSString *) postalCode
        withISOcountryCode: (NSString *) ISOcountryCode
            andWithCountry: (NSString *) country {
    
    if (self = [super init]) {
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.url = url;
        self.thoroughfare = thoroughfare;
        self.subThoroughfare = subThoroughfare;
        self.locality = locality;
        self.subLocality = subLocality;
        self.administrativeArea = administrativeArea;
        self.subAdministrativeArea = subAdministrativeArea;
        self.postalCode = postalCode;
        self.ISOcountryCode = ISOcountryCode;
        self.country = country;
    }
    
    return self;
}

- (BOOL) frequentedByUser: (NSString *) fullName {
    
    return NO;
}

- (BOOL) sellsBeer: (NSString *) beerName {
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"select * from sells where bar = \"%@\" AND beer = \"%@\"",
                               self.name, beerName];
    
    FMResultSet * rs = [db executeQuery:query];
    
    return [rs next];
}

- (void) toggleSellsBeer: (NSString *) beerName andAtPrice: (NSString *) price
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    if (![self sellsBeer:beerName]) {
        [db insertIntoTable:@"sells" withParameters:[[NSArray alloc]
                                                     initWithObjects:self.name, beerName, price, nil]];
    } else {
        NSMutableString * delete = [[NSMutableString alloc] initWithFormat:@"DELETE FROM sells "
                                    "WHERE bar=\"%@\" AND beer=\"%@\";", self.name, beerName];
        [db executeUpdate:delete];
    }
}

- (BOOL) isInDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"select * from bars where phoneNumber = \"%@\" AND name = \"%@\"",
                               self.phoneNumber, self.name];
    
    FMResultSet * rs = [db executeQuery:query];
    
    return [rs next];
}

- (void) toggleFrequentFor: (NSString *) frequentersName {
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    if (![self isFrequentedByUserWithName:frequentersName]) {
        [db insertIntoTable:@"frequents" withParameters:[[NSArray alloc] initWithObjects:frequentersName, self.name, nil]];
    } else {
        NSMutableString * delete = [[NSMutableString alloc] initWithFormat:@"DELETE FROM frequents "
                                    "WHERE drinker=\"%@\" AND bar=\"%@\";", frequentersName, self.name ];
        [db executeUpdate:delete];
    }
}

- (BOOL) isFrequentedByUserWithName: (NSString *) name {
    RUDBManager * db = [RUDBManager getSharedInstance];
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"SELECT * FROM frequents "
                               "WHERE drinker=\"%@\" AND bar=\"%@\";", name, self.name ];
    
    FMResultSet * rs = [db executeQuery:query];
    
    BOOL exists = [rs next];
    
    return exists;
}

- (BOOL) removeFromDatabase {
    
    return NO;
}
- (BOOL) insertIntoDatabase {
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    NSMutableString * insert = [[NSMutableString alloc] initWithString:@"insert into bars"];
    
    NSMutableString * column = [[NSMutableString alloc] initWithString:@"("];
    NSMutableString * values = [[NSMutableString alloc] initWithString:@"VALUES ("];
    
    if (self.name) {
        [column appendString:@"name,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.name]];
    }
    
    if (self.phoneNumber) {
        [column appendString:@"phoneNumber,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.phoneNumber]];
    }
    if (self.url){
        [column appendString:@"url,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.url]];
    }
    if (self.thoroughfare){
        [column appendString:@"thoroughfare,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.thoroughfare]];
    }
    if (self.subThoroughfare){
        [column appendString:@"subThoroughfare,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.subThoroughfare]];
    }
    if (self.locality){
        [column appendString:@"locality,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.locality]];
    }
    if (self.subLocality){
        [column appendString:@"subLocality,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.subLocality]];
    }
    if (self.administrativeArea){
        [column appendString:@"administrativeArea,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.administrativeArea]];
    }
    if (self.subAdministrativeArea){
        [column appendString:@"subAdministrativeArea,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.subAdministrativeArea]];
    }
    if (self.postalCode){
        [column appendString:@"postalCode,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.postalCode]];
    }
    if (self.ISOcountryCode){
        [column appendString:@"ISOcountryCode,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.ISOcountryCode]];
    }
    if (self.country){
        [column appendString:@"country,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.country]];
    }
    
    [column deleteCharactersInRange:NSMakeRange([column length] - 1, 1)];
    [values deleteCharactersInRange:NSMakeRange([values length] - 1, 1)];
    
    [column appendString:@")"];
    [values appendString:@")"];
    
    [insert appendString:column];
    [insert appendString:values];
    [insert appendString:@";"];
    
    return [db executeUpdate:insert];
}

@end
