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
@property (strong, nonatomic) NSString * number;
@property (strong, nonatomic) NSString * street;
@property (strong, nonatomic) NSString * city;
@property (strong, nonatomic) NSString * state;
@property (strong, nonatomic) NSString * zip;
@property (strong, nonatomic) NSString * country;

- (RUFriend *) initWithFirstName: (NSString *) firstName
                    withLastName: (NSString *) lastName
                      withNumber: (NSString *) number
                      withStreet: (NSString *) street
                        withCity: (NSString *) city
                       withState: (NSString *) state
                  andWithCountry: (NSString *) country;

- (NSString *) fullName;
- (BOOL) removeFromDatabase;
- (BOOL) isInDatabase;
- (BOOL) putInDatabase;

@end
