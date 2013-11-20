//
//  RUDBManager.m
//  Drink.io
//
//  Created by Paul Jones on 11/18/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUDBManager.h"
static RUDBManager *sharedInstance = nil;

static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation RUDBManager

+ (RUDBManager *) getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    
    return sharedInstance;
}

- (BOOL) addFriendWithFirstName: (NSString *) firstName
                   withLastName: (NSString *) lastName
                      withPhone: (NSString *) phone
                     withStreet: (NSString *) street
                       withCity: (NSString *) city
                      withState: (NSString *) state
                        withZip: (NSString *) zip
                    withCountry: (NSString *) country
                withCountryCode: (NSString *) countryCode
                andWithFavorite: (NSInteger *) favorite {
    return false;
}

- (BOOL)   addBarWithName: (NSString *) bar
          withPhoneNumber: (NSString *) phoneNumber
                  withURL: (NSString *) URL
         withThoroughfare: (NSString *) thoroughfare
      withSubThoroughfare: (NSString *) subThoroughfare
             withLocality: (NSString *) locality
          withSubLocality: (NSString *) subLocality
   withAdministrativeArea: (NSString *) administrativeArea
withSubAdministrativeArea: (NSString *) subAdministrativeArea
           withPostalCode: (NSString *) postalCode
       withISOcountryCode: (NSString *) ISOcountryCode
              withCountry: (NSString *) country
          andWithFavorite: (NSInteger) favorite {
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into sells (bar, beer, price) values (\"Clydez\",\"Bud\",20)"];
        
        NSLog(@"%@", insertSQL);
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        [self whatHappened];
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (int)insertIdentifier:(NSString *)identifier
               lastName:(NSString *)lastName
              firstName:(NSString *)firstName
                  email:(NSString *)email
{
    int result;
    
    const char *insert_stmt = "INSERT INTO UsersTable (id, lastName, firstName, email) VALUES (?, ?, ?, ?);";
    
    if ((result = sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL)) != SQLITE_OK)
    {
        NSLog(@"%s: prepare failure '%s' (%d)", __FUNCTION__, sqlite3_errmsg(database), result);
        return result;
    }
    
    if ((result = sqlite3_bind_text(statement, 1, [identifier UTF8String], -1, NULL)) != SQLITE_OK)
    {
        NSLog(@"%s: bind #1 failure '%s' (%d)", __FUNCTION__, sqlite3_errmsg(database), result);
        sqlite3_finalize(statement);
        return result;
    }
    
    if ((result = sqlite3_bind_text(statement, 2, [lastName UTF8String], -1, NULL)) != SQLITE_OK)
    {
        NSLog(@"%s: bind #2 failure '%s' (%d)", __FUNCTION__, sqlite3_errmsg(database), result);
        sqlite3_finalize(statement);
        return result;
    }
    
    if ((result = sqlite3_bind_text(statement, 3, [firstName UTF8String], -1, NULL)) != SQLITE_OK)
    {
        NSLog(@"%s: bind #3 failure '%s' (%d)", __FUNCTION__, sqlite3_errmsg(database), result);
        sqlite3_finalize(statement);
        return result;
    }
    
    if ((result = sqlite3_bind_text(statement, 4, [email UTF8String], -1, NULL)) != SQLITE_OK)
    {
        NSLog(@"%s: bind #4 failure '%s' (%d)", __FUNCTION__, sqlite3_errmsg(database), result);
        sqlite3_finalize(statement);
        return result;
    }
    
    if ((result = sqlite3_step(statement)) != SQLITE_DONE)
    {
        NSLog(@"%s: step failure: '%s'", __FUNCTION__, sqlite3_errmsg(database));
    }
    
    sqlite3_finalize(statement);
    
    return result;
}

- (void) whatHappened {
    
    if (sqlite3_step(statement) == SQLITE_OK) {
        NSLog(@"Ok");
    }
    else if (sqlite3_step(statement) == SQLITE_ERROR) {
        NSLog(@"Error");
    }
    else if (sqlite3_step(statement) == SQLITE_INTERNAL) {
        NSLog(@"Internal");
    }
    else if (sqlite3_step(statement) == SQLITE_PERM) {
        NSLog(@"Perm");
    }
    else if (sqlite3_step(statement) == SQLITE_ABORT) {
        NSLog(@"Abort");
    }
    else if (sqlite3_step(statement) == SQLITE_BUSY) {
        NSLog(@"Busy");
    }
    else if (sqlite3_step(statement) == SQLITE_LOCKED) {
        NSLog(@"Locked");
    }
    else if (sqlite3_step(statement) == SQLITE_NOMEM) {
        NSLog(@"Nomem");
    }
    else if (sqlite3_step(statement) == SQLITE_READONLY) {
        NSLog(@"Readonly");
    }
    else if (sqlite3_step(statement) == SQLITE_INTERRUPT) {
        NSLog(@"Interrupt");
    }
    else if (sqlite3_step(statement) == SQLITE_IOERR) {
        NSLog(@"IOErr");
    }
    else if (sqlite3_step(statement) == SQLITE_CORRUPT) {
        NSLog(@"Corrupt");
    }
    else if (sqlite3_step(statement) == SQLITE_NOTFOUND) {
        NSLog(@"Not found");
    }
    else if (sqlite3_step(statement) == SQLITE_FULL) {
        NSLog(@"Full");
    }
    else if (sqlite3_step(statement) == SQLITE_CANTOPEN) {
        NSLog(@"Can't open");
    }
    else if (sqlite3_step(statement) == SQLITE_PROTOCOL) {
        NSLog(@"Potocol");
    }
    else if (sqlite3_step(statement) == SQLITE_EMPTY) {
        NSLog(@"Empty");
    }
    else if (sqlite3_step(statement) == SQLITE_SCHEMA) {
        NSLog(@"Schema");
    }
    else if (sqlite3_step(statement) == SQLITE_TOOBIG) {
        NSLog(@"Too big");
    }
    else if (sqlite3_step(statement) == SQLITE_CONSTRAINT) {
        NSLog(@"Constraint");
    }
    else if (sqlite3_step(statement) == SQLITE_MISMATCH) {
        NSLog(@"Mismatch");
    }
    else if (sqlite3_step(statement) == SQLITE_MISUSE) {
        NSLog(@"Misuse");
    }
    else if (sqlite3_step(statement) == SQLITE_NOLFS) {
        NSLog(@"Nolfs");
    }
    else if (sqlite3_step(statement) == SQLITE_AUTH) {
        NSLog(@"Auth");
    }
    else if (sqlite3_step(statement) == SQLITE_FORMAT) {
        NSLog(@"Format");
    }
    else if (sqlite3_step(statement) == SQLITE_RANGE) {
        NSLog(@"Range");
    }
    else if (sqlite3_step(statement) == SQLITE_NOTADB) {
        NSLog(@"Not a DB");
    }
    else if (sqlite3_step(statement) == SQLITE_ROW) {
        NSLog(@"Row");
    }
    else if (sqlite3_step(statement) == SQLITE_DONE) {
        NSLog(@"Done");
    }
}

- (BOOL) makeBestFriendWithFirstName: (NSString *) firstName
                        withLastName: (NSString *) lastName
                        andWithPhone: (NSString *) phone {
    
    return false;
}

- (BOOL) makeFavoriteBarWithPhone: (NSString *) phone {
    
    return false;
}

- (NSArray *) getFriends {
    NSArray * friends = [[NSArray alloc] init];
    
    return friends;
}
- (NSArray *) getBestFriends {
    NSArray * bestFriends = [[NSArray alloc] initWithObjects:@"Paul Jones",@"Frank Porco", @"Tomasz Imielinski", nil];
    
    return bestFriends;
}
- (NSArray *) getBars {
    NSArray * bars = [[NSArray alloc] init];
    
    return bars;
}
- (NSArray *) getFavoriteBars {
    NSArray * favoriteBars = [[NSArray alloc] initWithObjects:@"Clydz",@"Harvest Moon", @"Stuff Yer Face", nil];
    
    return favoriteBars;
}

- (BOOL) createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"barbeerdrinker.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:@"/initializeDB" ofType:@"txt"];
        NSString * dbInit = [[NSString alloc] initWithContentsOfFile:txtFilePath encoding:NSUTF8StringEncoding error:NULL];
        [self createTableWith:dbInit];
    }
    return isSuccess;
}

- (BOOL) createTableWith: (NSString *) sqlStatement {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = [sqlStatement UTF8String];
        if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
            return NO;
            NSLog(@"Failed to create table");
        }
        sqlite3_close(database);
        return YES;
    }
    else {
        return NO;
        NSLog(@"Failed to open/create database");
    }
}

- (NSString *) query: (NSString *) querySQL {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *name = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                return name;
            }
            else{
                return @"Failed";
            }
            sqlite3_reset(statement);
        }
    }
    
    return @"Failed";
}

- (BOOL) saveData:(NSString*)registerNumber name:(NSString*)name department:(NSString*)department year:(NSString*)year;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (regno,name, department, year) values (\"%d\",\"%@\", \"%@\", \"%@\")",
                               [registerNumber integerValue],
                               name, department, year];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (NSArray*) findByRegisterNumber:(NSString*)registerNumber
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"select name, department, year from studentsDetail where regno=\"%@\"",registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:name];
                NSString *department = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:department];
                NSString *year = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:year];
                return resultArray;
            }
            else{
                NSLog(@"Not found");
                return nil;
            }
            sqlite3_reset(statement);
        }
    }
    return nil;
}

@end

