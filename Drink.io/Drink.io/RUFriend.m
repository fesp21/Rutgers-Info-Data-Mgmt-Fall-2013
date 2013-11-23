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
                      withGender: (NSInteger) gender
                      andWithAge: (NSInteger) age
{
    
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.gender = gender;
        self.age = age;
    }
    
    return self;
}

- (BOOL) isInDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"select * from drinkers where firstName = \"%@\" AND lastName = \"%@\"", self.firstName, self.lastName];
    
    FMResultSet * rs = [db executeQuery:query];
    
    return [rs next];
}

- (BOOL) insertIntoDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    NSMutableString * insert = [[NSMutableString alloc] initWithString:@"insert into drinkers"];
    
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
    
    if (self.lastName) {
        [column appendString:@"gender,"];
        [values appendString:[NSString stringWithFormat: @"\"%i\",", self.gender]];
    }
    
    if (self.lastName) {
        [column appendString:@"ageGroup,"];
        [values appendString:[NSString stringWithFormat: @"\"%i\",", self.age]];
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

- (BOOL) removeFromDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    NSMutableString * delete = [[NSMutableString alloc] initWithFormat:@"DELETE FROM drinkers "
    "WHERE firstName=\"%@\" AND lastName=\"%@\";", self.firstName, self.lastName ];
    
    return [db executeUpdate:delete];
}

- (NSString *) fullName
{
    return [[NSString alloc] initWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSArray *) getParameters
{
    return [[NSArray alloc] init];
}

@end
