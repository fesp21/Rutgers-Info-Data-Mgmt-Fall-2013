//
//  RUBeer.m
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUBeer.h"
#import "RUDBManager.h"

@implementation RUBeer

- (RUBeer *) initWithName: (NSString *) name andWithManufacturer: (NSString *) manf
{
    if (self = [super init]) {
        self.name = name;
        self.manf = manf;
    }
    
    return self;
}

- (BOOL) insertIntoDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    return [db insertIntoTable:@"beers"
                  withParameters:[[NSArray alloc] initWithObjects:
                                  self.name,
                                  self.manf,
                                  nil]];
}

- (BOOL) removeFromDatabase
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    NSMutableString * delete = [[NSMutableString alloc] initWithFormat:@"DELETE FROM beer "
                                "WHERE name=\"%@\" AND manf=\"%@\";", self.name, self.manf ];
    
    return [db executeUpdate:delete];
}

- (BOOL) likedByUser
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    NSMutableString * query = [[NSMutableString alloc] initWithFormat:@"SELECT * FROM likes "
                                "WHERE drinker=\"%@\" AND beer=\"%@\";", @"user name", self.name ];
    
    FMResultSet * rs = [db executeQuery:query];
    
    BOOL exists = [rs next];
    
    NSLog(@"%@ %@", query, exists ? @"yes" : @"no");
    
    return exists;
}

- (void) toggleLike
{
    RUDBManager * db = [RUDBManager getSharedInstance];
    
    if (![self likedByUser]) {
        [db insertIntoTable:@"likes" withParameters:[[NSArray alloc] initWithObjects:@"user name", self.name, nil]];
    } else {
        NSMutableString * delete = [[NSMutableString alloc] initWithFormat:@"DELETE FROM likes "
                                    "WHERE drinker=\"%@\" AND beer=\"%@\";", @"user name", self.name ];
        [db executeUpdate:delete];
    }
}

@end
