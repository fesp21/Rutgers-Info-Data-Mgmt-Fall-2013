//
//  RUDBManager.h
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface RUDBManager : NSObject
{
    NSString *databasePath;
}

+ (RUDBManager *) getSharedInstance;
- (BOOL) createDB;
- (BOOL) saveData: (NSString*) registerNumber name:(NSString*)name department:(NSString*)department year:(NSString*)year;
- (NSArray*) findByRegisterNumber:(NSString*)registerNumber;

@end
