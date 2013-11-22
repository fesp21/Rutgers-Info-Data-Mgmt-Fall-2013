//
//  RUBestFriendsViewController.m
//  Drink.io
//
//  Created by Paul Jones on 11/19/13.
//  Copyright (c) 2013 Principles of Informations and Data Management. All rights reserved.
//

#import "RUBestFriendsViewController.h"
#import <AddressBook/AddressBook.h>
#import "RUDBManager.h"
#import "RUFriend.h"

@interface RUBestFriendsViewController () {
    RUDBManager * db;
    NSArray * bestFriends;
}

@end

@implementation RUBestFriendsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle: style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    people = [[NSMutableArray alloc ] init];
    bestFriends = [[RUDBManager getSharedInstance] getBestFriends];
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
        NSString * addressBookNum;
        
        for (int i = 0; i < numberOfPeople; i++) {
            
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            
            NSString * firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString * lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
            
            ABMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
            
            if (ABMultiValueGetCount(addresses) == 0)
                break;
            
            CFDictionaryRef addressDict = ABMultiValueCopyValueAtIndex(addresses, 0);
            
            NSString *street = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressStreetKey);
            NSString *city = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressCityKey);
            NSString *state = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressStateKey);
            NSString *zip = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressZIPKey);
            NSString *country = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressCountryKey);
            
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            NSString *phoneNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
            
            RUFriend * friend = [[RUFriend alloc] initWithFirstName:firstName
                                   withLastName:lastName
                                     withNumber:phoneNumber
                                     withStreet:street
                                       withCity:city
                                      withState:state
                                 andWithCountry:country];
            
            [people addObject:friend];
        }
    }
    else {
        // Send an alert telling user to change privacy setting in settings app
    }
    
    self.navigationItem.rightBarButtonItem = NULL;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[people objectAtIndex:indexPath.row] isInDatabase]) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [[people objectAtIndex:indexPath.row] removeFromDatabase];
    } else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [[people objectAtIndex:indexPath.row] insertIntoDatabase];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[people objectAtIndex:indexPath.row] fullName];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([[people objectAtIndex:indexPath.row] isInDatabase]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

@end
