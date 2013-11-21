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

@end
