//
//  RUBars.h
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RUBar : NSObject

@property (strong, nonatomic) NSString * name ;
@property (strong, nonatomic) NSString * phoneNumber;
@property (strong, nonatomic) NSString * url ;
@property (strong, nonatomic) NSString * thoroughfare ;
@property (strong, nonatomic) NSString * subThoroughfare ;
@property (strong, nonatomic) NSString * locality ;
@property (strong, nonatomic) NSString * subLocality ;
@property (strong, nonatomic) NSString * administrativeArea ;
@property (strong, nonatomic) NSString * subAdministrativeArea ;
@property (strong, nonatomic) NSString * postalCode ;
@property (strong, nonatomic) NSString * ISOcountryCode ;
@property (strong, nonatomic) NSString * country ;

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
            andWithCountry: (NSString *) country;

- (BOOL) frequentedByUser: (NSString *) fullName;
- (BOOL) isInDatabase;
- (BOOL) removeFromDatabase;
- (BOOL) insertIntoDatabase;

@end
