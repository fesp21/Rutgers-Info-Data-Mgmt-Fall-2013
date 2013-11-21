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
        
        
        for (int i = 0; i < numberOfPeople; i++) {
            
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            
            NSString * firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString * lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
            
            ABMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
            
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(addresses); i++) {
                CFDictionaryRef addressDict = ABMultiValueCopyValueAtIndex(addresses, i);
                
                NSString *city = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressCityKey);
                NSString *country = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressCountryKey);
                NSString *state = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressStateKey);
                NSString *street = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressStreetKey);
                NSString *zip = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressZIPKey);
                
                
            }
            
        }
    }
    else {
        // Send an alert telling user to change privacy setting in settings app
    }
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [bestFriends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [bestFriends objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

@end
