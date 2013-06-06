//
//  ParsingUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 5/4/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "ParsingUtilities.h"

@implementation ParsingUtilities


+ (UserInformation *) parseUserInfoResults:(NSData*) response{
    
    UserInformation *userInformation = [[UserInformation alloc] init];
    
    NSError *myError = nil;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    
    for (NSDictionary *item in results){
        
        userInformation.networkId   = [item objectForKey:@"NetworkId"];
        userInformation.password    = [item objectForKey:@"Password"];
        userInformation.nameFirst   = [item objectForKey:@"NameFirst"];
        userInformation.nameLast    = [item objectForKey:@"NameLast"];
        userInformation.title       = [item objectForKey:@"Title"];
    }
    
    return userInformation;
}

+ (NSMutableArray *) parseAchAuthorizationResults:(NSData*) response{
    
    NSLog(@"Response Is: %@",response);
    
    NSError *myError = nil;
    NSMutableArray *returnList      = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    NSDictionary *results           = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    for (NSDictionary *item in results){
        
        AchDetail *achDetail            = [[AchDetail alloc] init];
        achDetail.contactInformation    = [[ContactInformation alloc] init];
        
        achDetail.hasBeenViewed         = NO;
        achDetail.iD                    = [item objectForKey:@"Id"];
        achDetail.amount                = [[item objectForKey:@"Amount"] doubleValue];
        achDetail.name                  = [item objectForKey:@"Name"];
        achDetail.accountNumber         = [item objectForKey:@"Account"];
        achDetail.userNotes             = [item objectForKey:@"UserNotes"];
        achDetail.originatingSystem     = [item objectForKey:@"OriginatingSystem"];
        achDetail.arrivalDate           = [dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]];
        achDetail.arrivalTime           = [NSDateFormatter localizedStringFromDate:[dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]]
                                                                         dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        NSDictionary *contactInfo  = [item objectForKey:@"ContactInformation"];
        
        for (NSString *key in [contactInfo allKeys]) {
            
            achDetail.contactInformation.address        = [contactInfo objectForKey:@"Address"];
            achDetail.contactInformation.city           = [contactInfo objectForKey:@"City"];
            achDetail.contactInformation.state          = [contactInfo objectForKey:@"State"];
            achDetail.contactInformation.zipCode        = [contactInfo objectForKey:@"ZipCode"];
            achDetail.contactInformation.homePhone      = [contactInfo objectForKey:@"HomePhone"];
            achDetail.contactInformation.mobilePhone    = [contactInfo objectForKey:@"MobilePhone"];
            achDetail.contactInformation.emailAddress   = [contactInfo objectForKey:@"EmailAddress"];
        }
        
        [returnList addObject:achDetail];
    }
    
    
   // [self sortResponseDataDescending:returnList];
    
    return returnList;
    
}

+ (NSMutableArray *) parseCheckAuthorizationResults:(NSData*) response{
    
    NSLog(@"Response Is: %@",response);
    
    NSError *myError = nil;
    NSMutableArray *returnList      = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    NSDictionary *results           = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    for (NSDictionary *item in results){
        
        CheckDetail *checkDetail            = [[CheckDetail alloc] init];
        checkDetail.contactInformation    = [[ContactInformation alloc] init];
        
        checkDetail.hasBeenViewed         = NO;
        checkDetail.iD                    = [item objectForKey:@"Id"];
        checkDetail.amount                = [[item objectForKey:@"Amount"] doubleValue];
        checkDetail.name                  = [item objectForKey:@"Name"];
        checkDetail.accountNumber         = [item objectForKey:@"Account"];
        checkDetail.originatingSystem     = [item objectForKey:@"OriginatingSystem"];
        checkDetail.arrivalDate           = [dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]];
        checkDetail.arrivalTime           = [NSDateFormatter localizedStringFromDate:[dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]]
                                                                           dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        
        
        NSDictionary *contactInfo  = [item objectForKey:@"ContactInformation"];
        
        for (NSString *key in [contactInfo allKeys]) {
            
            checkDetail.contactInformation.address        = [contactInfo objectForKey:@"Address"];
            checkDetail.contactInformation.city           = [contactInfo objectForKey:@"City"];
            checkDetail.contactInformation.state          = [contactInfo objectForKey:@"State"];
            checkDetail.contactInformation.zipCode        = [contactInfo objectForKey:@"ZipCode"];
            checkDetail.contactInformation.homePhone      = [contactInfo objectForKey:@"HomePhone"];
            checkDetail.contactInformation.mobilePhone    = [contactInfo objectForKey:@"MobilePhone"];
            checkDetail.contactInformation.emailAddress   = [contactInfo objectForKey:@"EmailAddress"];
        }
        
        [returnList addObject:checkDetail];
    }
    
   // [self sortResponseDataDescending:returnList];
    
    return returnList;
}

+ (NSMutableArray *) parseWireAuthorizationResults:(NSData*) response{
    
    NSLog(@"Response Is: %@",response);
    
    NSError *myError = nil;
    NSMutableArray *returnList      = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    NSDictionary *results           = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    
    for (NSDictionary *item in results){
        
        WireDetail *wireDetail            = [[WireDetail alloc] init];
        wireDetail.contactInformation    = [[ContactInformation alloc] init];
        
        wireDetail.hasBeenViewed         = NO;
        wireDetail.iD                    = [item objectForKey:@"Id"];
        wireDetail.amount                = [[item objectForKey:@"Amount"] doubleValue];
        wireDetail.name                  = [item objectForKey:@"Name"];
        wireDetail.accountNumber         = [item objectForKey:@"Account"];
        wireDetail.originatingSystem     = [item objectForKey:@"OriginatingSystem"];
        wireDetail.arrivalDate           = [dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]];
        wireDetail.arrivalTime           = [NSDateFormatter localizedStringFromDate:[dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]]
                                                                          dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        
        NSDictionary *contactInfo  = [item objectForKey:@"ContactInformation"];
        
        for (NSString *key in [contactInfo allKeys]) {
            
            wireDetail.contactInformation.address        = [contactInfo objectForKey:@"Address"];
            wireDetail.contactInformation.city           = [contactInfo objectForKey:@"City"];
            wireDetail.contactInformation.state          = [contactInfo objectForKey:@"State"];
            wireDetail.contactInformation.zipCode        = [contactInfo objectForKey:@"ZipCode"];
            wireDetail.contactInformation.homePhone      = [contactInfo objectForKey:@"HomePhone"];
            wireDetail.contactInformation.mobilePhone    = [contactInfo objectForKey:@"MobilePhone"];
            wireDetail.contactInformation.emailAddress   = [contactInfo objectForKey:@"EmailAddress"];
        }
        
        [returnList addObject:wireDetail];
    }
    
   // [self sortResponseDataDescending:returnList];
    
    return returnList;
}

+ (NSArray *) parseAchAuthorizationHistoryResults:(NSData*) response{
    
    NSLog(@"Response Is: %@",response);
    
    NSError *myError = nil;
    NSMutableArray *returnList      = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    NSDictionary *results           = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    for (NSDictionary *item in results){
        
        AchDetail *achDetail            = [[AchDetail alloc] init];
        achDetail.contactInformation    = [[ContactInformation alloc] init];
        
        achDetail.hasBeenViewed         = YES;
        achDetail.isApproved            = YES;
        achDetail.iD                    = [item objectForKey:@"Id"];
        achDetail.amount                = [[item objectForKey:@"Amount"] doubleValue];
        achDetail.name                  = [item objectForKey:@"Name"];
        achDetail.accountNumber         = [item objectForKey:@"Account"];
        achDetail.userNotes             = [item objectForKey:@"UserNotes"];
        achDetail.originatingSystem     = [item objectForKey:@"OriginatingSystem"];
        achDetail.approvedOnDate        = [dateFormatter dateFromString:[item objectForKey:@"ApprovedOn"]];
        achDetail.arrivalDate           = [dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]];
        achDetail.arrivalTime           = [NSDateFormatter localizedStringFromDate:[dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]]
                                                                         dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        
        NSDictionary *contactInfo  = [item objectForKey:@"ContactInformation"];
        
        for (NSString *key in [contactInfo allKeys]) {
            
            achDetail.contactInformation.address        = [contactInfo objectForKey:@"Address"];
            achDetail.contactInformation.city           = [contactInfo objectForKey:@"City"];
            achDetail.contactInformation.state          = [contactInfo objectForKey:@"State"];
            achDetail.contactInformation.zipCode        = [contactInfo objectForKey:@"ZipCode"];
            achDetail.contactInformation.homePhone      = [contactInfo objectForKey:@"HomePhone"];
            achDetail.contactInformation.mobilePhone    = [contactInfo objectForKey:@"MobilePhone"];
            achDetail.contactInformation.emailAddress   = [contactInfo objectForKey:@"EmailAddress"];
        }
        
        
        [returnList addObject:achDetail];
    }
    
    return returnList;
    
}

+ (NSArray *) parseCheckAuthorizationHistoryResults:(NSData*) response{
    
    NSLog(@"Response Is: %@",response);
    
    NSError *myError = nil;
    NSMutableArray *returnList      = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    NSDictionary *results           = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    for (NSDictionary *item in results){
        
        CheckDetail *checkDetail            = [[CheckDetail alloc] init];
        checkDetail.contactInformation    = [[ContactInformation alloc] init];
        
        checkDetail.hasBeenViewed         = YES;
        checkDetail.isApproved            = YES;
        checkDetail.iD                    = [item objectForKey:@"Id"];
        checkDetail.amount                = [[item objectForKey:@"Amount"] doubleValue];
        checkDetail.name                  = [item objectForKey:@"Name"];
        checkDetail.accountNumber         = [item objectForKey:@"Account"];
        checkDetail.userNotes             = [item objectForKey:@"UserNotes"];
        checkDetail.originatingSystem     = [item objectForKey:@"OriginatingSystem"];
        checkDetail.approvedOnDate        = [dateFormatter dateFromString:[item objectForKey:@"ApprovedOn"]];
        checkDetail.arrivalDate           = [dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]];
        checkDetail.arrivalTime           = [NSDateFormatter localizedStringFromDate:[dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]]
                                                                           dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        
        NSDictionary *contactInfo  = [item objectForKey:@"ContactInformation"];
        
        for (NSString *key in [contactInfo allKeys]) {
            
            checkDetail.contactInformation.address        = [contactInfo objectForKey:@"Address"];
            checkDetail.contactInformation.city           = [contactInfo objectForKey:@"City"];
            checkDetail.contactInformation.state          = [contactInfo objectForKey:@"State"];
            checkDetail.contactInformation.zipCode        = [contactInfo objectForKey:@"ZipCode"];
            checkDetail.contactInformation.homePhone      = [contactInfo objectForKey:@"HomePhone"];
            checkDetail.contactInformation.mobilePhone    = [contactInfo objectForKey:@"MobilePhone"];
            checkDetail.contactInformation.emailAddress   = [contactInfo objectForKey:@"EmailAddress"];
        }
        
        
        [returnList addObject:checkDetail];
    }
    
    return returnList;
    
}

+ (NSArray *) parseWireAuthorizationHistoryResults:(NSData*) response{
    
    NSLog(@"Response Is: %@",response);
    
    NSError *myError = nil;
    NSMutableArray *returnList      = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    NSDictionary *results           = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    for (NSDictionary *item in results){
        
        WireDetail *wireDetail            = [[WireDetail alloc] init];
        wireDetail.contactInformation    = [[ContactInformation alloc] init];
        
        wireDetail.hasBeenViewed         = YES;
        wireDetail.isApproved            = YES;
        wireDetail.iD                    = [item objectForKey:@"Id"];
        wireDetail.amount                = [[item objectForKey:@"Amount"] doubleValue];
        wireDetail.name                  = [item objectForKey:@"Name"];
        wireDetail.accountNumber         = [item objectForKey:@"Account"];
        wireDetail.userNotes             = [item objectForKey:@"UserNotes"];
        wireDetail.originatingSystem     = [item objectForKey:@"OriginatingSystem"];
        wireDetail.approvedOnDate        = [dateFormatter dateFromString:[item objectForKey:@"ApprovedOn"]];
        wireDetail.arrivalDate           = [dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]];
        wireDetail.arrivalTime           = [NSDateFormatter localizedStringFromDate:[dateFormatter dateFromString:[item objectForKey:@"ArrivalDate"]]
                                                                          dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        
        NSDictionary *contactInfo  = [item objectForKey:@"ContactInformation"];
        
        for (NSString *key in [contactInfo allKeys]) {
            
            wireDetail.contactInformation.address        = [contactInfo objectForKey:@"Address"];
            wireDetail.contactInformation.city           = [contactInfo objectForKey:@"City"];
            wireDetail.contactInformation.state          = [contactInfo objectForKey:@"State"];
            wireDetail.contactInformation.zipCode        = [contactInfo objectForKey:@"ZipCode"];
            wireDetail.contactInformation.homePhone      = [contactInfo objectForKey:@"HomePhone"];
            wireDetail.contactInformation.mobilePhone    = [contactInfo objectForKey:@"MobilePhone"];
            wireDetail.contactInformation.emailAddress   = [contactInfo objectForKey:@"EmailAddress"];
        }
        
        
        [returnList addObject:wireDetail];
    }
    
    return returnList;
    
}

@end
