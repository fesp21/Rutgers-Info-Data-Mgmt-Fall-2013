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

- (BOOL) removeFromDatabase {
    
    return NO;
}
- (BOOL) insertIntoDatabase {
    
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    return [db insertIntoTable:@"bars" withParameters:[[NSArray alloc] initWithObjects: self.name,
    self.phoneNumber,
    self.url,
    self.thoroughfare,
    self.subThoroughfare,
    self.locality,
    self.subLocality,
    self.administrativeArea,
    self.subAdministrativeArea,
    self.postalCode,
    self.ISOcountryCode,
    self.country,
    nil]];
}

@end
