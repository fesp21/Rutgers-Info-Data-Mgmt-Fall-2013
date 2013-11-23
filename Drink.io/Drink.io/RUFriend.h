//
//  RUFriend.h
//  Drink.io
//
//  Created by Paul Jones on 11/20/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RUFriend : NSObject

@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * lastName;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger age;

- (RUFriend *) initWithFirstName: (NSString *) firstName
                    withLastName: (NSString *) lastName
                      withGender: (NSInteger) gender
                      andWithAge: (NSInteger) age;


- (NSString *) fullName;
- (BOOL) removeFromDatabase;
- (BOOL) isInDatabase;
- (BOOL) insertIntoDatabase;

@end
