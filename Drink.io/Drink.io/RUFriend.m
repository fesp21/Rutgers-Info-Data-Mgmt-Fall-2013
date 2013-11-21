//
//  RUFriend.m
//  Drink.io
//
//  Created by Paul Jones on 11/20/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUFriend.h"
#import "RUDBManager.h"

@implementation RUFriend

- (RUFriend *) initWithFirstName: (NSString *) firstName
                    withLastName: (NSString *) lastName
                      withNumber: (NSString *) number
                      withStreet: (NSString *) street
                        withCity: (NSString *) city
                       withState: (NSString *) state
                  andWithCountry: (NSString *) country
{
    
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.number = number;
        self.street = street;
        self.city = city;
        self.state = state;
        self.country = country;
    }
    
    return self;
}

- (BOOL) isInDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    return false;
}

- (BOOL) putInDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    NSMutableString * insert = [[NSMutableString alloc] initWithString:@"insert into drinker"];
    
    NSMutableString * column = [[NSMutableString alloc] initWithString:@"("];
    NSMutableString * values = [[NSMutableString alloc] initWithString:@"VALUES ("];
    
    if (self.firstName) {
        [column appendString:@"firstName,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.firstName]];
    }
    
    if (self.lastName) {
        [column appendString:@"lastName,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.lastName]];
    }
    
    if (self.number) {
        [column appendString:@"phone,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.number]];
    }
    
    if (self.street) {
        [column appendString:@"street,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.street]];
    }
    
    if (self.city) {
        [column appendString:@"city,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.city]];
    }
    
    if (self.state) {
        [column appendString:@"state,"];
        [values appendString:[NSString stringWithFormat: @"\"%@\",", self.state]];
    }
    
    if (self.country) {
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

- (NSArray *) getParameters
{
    return [[NSArray alloc] initWithObjects:self.firstName, self.lastName, self.number,
    self.street, self.city, self.state, self.country, nil];
}

@end
