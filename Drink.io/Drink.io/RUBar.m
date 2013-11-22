//
//  RUBars.m
//  Drink.io
//
//  Created by Paul Jones on 11/21/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUBar.h"

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

@end
