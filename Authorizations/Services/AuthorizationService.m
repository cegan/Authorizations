//
//  Service.m
//  Authorizations
//
//  Created by Casey Egan on 5/30/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "AuthorizationService.h"
#import "AchDetail.h"
#import "CheckDetail.h"
#import "WireDetail.h"
#import "UserInformation.h"
#import "ServiceResponse.h"
#import "CalendarUtilities.h"
#import "StringUtilities.h"
#import "NotificationUtilities.h"
#import "ArchiveUtilities.h"
#import "URLUtilities.h"
#import "TokenUtilities.h"
#import "Constants.h"



@interface AuthorizationService()

- (void) makeAsyncServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod;

-(NSData *) makeServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod;
-(NSMutableArray *) parseAchAuthorizationResults:(NSData*) response;
-(NSMutableArray *) parseCheckAuthorizationResults:(NSData*) response;
-(NSMutableArray *) parseWireAuthorizationResults:(NSData*) response;

@end


@implementation AuthorizationService

@synthesize serviceResponse     = _serviceResponse;
@synthesize serviceResponseData = _serviceResponseData;


- (id)init{
    
    if ((self = [super init])) {
        
        _serviceResponse                = [[ServiceResponse alloc] init];
        _serviceResponse.wasSuccessful  = YES;
    }
    
    return self;
}


- (void) makeAsyncServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod{
    
    NSLog(@"URL request is: %@",url);
    
    if([TokenUtilities isUsersAccessTokenExpired]){
        
        [TokenUtilities refreshUsersAccessToken];
    }
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request addValue:[TokenUtilities getAuthorizationHeaderValue] forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:httpMethod];

    [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:nil];
}

- (NSData *) makeServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod{
    
 
    if([TokenUtilities isUsersAccessTokenExpired]){
        
        [TokenUtilities refreshUsersAccessToken];
    }
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request addValue:[TokenUtilities getAuthorizationHeaderValue] forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:httpMethod];
    
    return [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:nil];
    
}

- (void) resetUserData:(NSString *) userId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getResetUserDataURL] forHTTPMethod:@"POST"];
    _serviceResponse.responseData   = [self parseAchAuthorizationResults:_serviceResponseData];
}


/*Service Functions*/

- (void) loginUser:(NSString *) userId{
    
      
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kHostTokenRefreshAddress]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:kApiGatewayConsumerKeyAndSecret forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:[@"grant_type=password&username=admin&password=admin&scope=PRODUCTION" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
     
                        completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                            NSDictionary *tokenData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                            NSString *accessToken   = [tokenData objectForKey:@"access_token"];
                            NSString *refreshToken  = [tokenData objectForKey:@"refresh_token"];
                               
                            [ArchiveUtilities archiveUsersApiGatewayAccessToken:accessToken];
                            [ArchiveUtilities archiveUsersApiGatewayRefreshToken:refreshToken];
                               
                            [self getUserInformationForUser:userId withAccessToken:accessToken];
                               
                        }];
}


- (void) getUserInformationForUser:(NSString *) user withAccessToken:(NSString *) accessToken{
    
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[URLUtilities getLoginURLForUser:user]]];
    
    
        [request addValue:[TokenUtilities getAuthorizationHeaderValue] forHTTPHeaderField:@"Authorization"];
        [request setHTTPMethod:@"GET"];
    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
    
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
                                       UserInformation *userInformation = [self parseUserInfoResults:data];
    
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"loginCompleted" object:nil userInfo:[NSDictionary dictionaryWithObject:userInformation forKey:kUserInformationKey]];
    
                                   }];
    
    
    
}

-(ServiceResponse *) getAchAuthorizations{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getAchApprovalsURL] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [self parseAchAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getCheckAuthorizations{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getCheckApprovalsURL] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [self parseCheckAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getWireAuthorizations{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getWireApprovalsURL] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [self parseWireAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getAchAuthorizationById:(NSString *) authorizationId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getAchApprovalURLForId:authorizationId] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [self parseAchAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getCheckAuthorizationById:(NSString *) authorizationId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getCheckApprovalURLForId:authorizationId] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [self parseCheckAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getWireAuthorizationById:(NSString *) authorizationId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getWireApprovalURLForId:authorizationId] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [self parseWireAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) authorizeAch:(NSMutableArray *) achsToAuthorize AsAsync:(BOOL) async{
    
    if(async){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getAchAuthorizationUrlWithData:achsToAuthorize] forHTTPMethod:@"GET"];
    }
    else{
        
        _serviceResponseData    = [self makeServiceRequestWithUrl:[URLUtilities getAchAuthorizationUrlWithData:achsToAuthorize] forHTTPMethod:@"GET"];
        _serviceResponse        = [self getServiceResponse:_serviceResponseData];
    }
    
    return _serviceResponse;
}

-(ServiceResponse *) authorizeCheck:(NSMutableArray *) checksToAuthorize AsAsync:(BOOL) async{
    
    if(async){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getCheckAuthorizationUrlWithData:checksToAuthorize] forHTTPMethod:@"GET"];
    }
    else{
        
        _serviceResponseData    = [self makeServiceRequestWithUrl:[URLUtilities getCheckAuthorizationUrlWithData:checksToAuthorize] forHTTPMethod:@"GET"];
        _serviceResponse        = [self getServiceResponse:_serviceResponseData];
    }
    
    return _serviceResponse;
}

-(ServiceResponse *) authorizeWire:(NSMutableArray *) wiresToAuthorize AsAsync:(BOOL) async{
    
    if(async){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getWireAuthorizationUrlWithData:wiresToAuthorize] forHTTPMethod:@"GET"];
        
    }
    else{
        
        _serviceResponseData    = [self makeServiceRequestWithUrl:[URLUtilities getWireAuthorizationUrlWithData:wiresToAuthorize] forHTTPMethod:@"GET"];
        _serviceResponse        = [self getServiceResponse:_serviceResponseData];
    }
    
    
    return _serviceResponse;
}

-(ServiceResponse *) getServiceResponse:(NSData*) response{
    
    _serviceResponse = [[ServiceResponse alloc] init];
    
    NSError *myError = nil;
    
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    
    for (NSDictionary *item in results){
        
        BOOL wasSuccessful      = [[item valueForKey:@"WasSuccessful"] boolValue];
        NSString *errorDetails  = [item valueForKey:@"ErrorDetails"];
        
        if(wasSuccessful){
            
            _serviceResponse.wasSuccessful = YES;
        }
        else{
            
            _serviceResponse.wasSuccessful = NO;
            _serviceResponse.errorDetails  = errorDetails;
        }
    }
    
    return _serviceResponse;
}

-(NSDictionary *) getApiGatewayAccessTokens{
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kHostTokenRefreshAddress]];
    
    
    [request setHTTPMethod:@"POST"];
    [request addValue:kApiGatewayConsumerKeyAndSecret forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:[@"grant_type=password&username=admin&password=admin&scope=PRODUCTION" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:nil];
    
    return [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
}

-(NSArray *) getAchAuthorizationHistory{
    
    
    NSString *url = [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetAchAuthorizationHistory/", [ArchiveUtilities getloggedinUser]];
    
    _serviceResponseData = [self makeServiceRequestWithUrl:url forHTTPMethod:@"GET"];
    
    return [self parseAchAuthorizationHistoryResults:_serviceResponseData];
    
}

-(NSArray *) getCheckAuthorizationHistory{
    
    
    NSString *url = [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetCheckAuthorizationHistory/", [ArchiveUtilities getloggedinUser]];
    
    _serviceResponseData = [self makeServiceRequestWithUrl:url forHTTPMethod:@"GET"];
    
    return [self parseCheckAuthorizationHistoryResults:_serviceResponseData];
}

-(NSArray *) getWireAuthorizationHistory{
    
    NSString *url = [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetWireAuthorizationHistory/", [ArchiveUtilities getloggedinUser]];
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:url forHTTPMethod:@"GET"];
    
    return [self parseWireAuthorizationHistoryResults:_serviceResponseData];
}




/*Parsing Functions*/

- (UserInformation *) parseUserInfoResults:(NSData*) response{
    
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

-(NSMutableArray *) parseAchAuthorizationResults:(NSData*) response{
    
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
    
    
    [self sortResponseDataDescending:returnList];
    
    return returnList;
    
}

-(NSMutableArray *) parseCheckAuthorizationResults:(NSData*) response{
    
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
    
    [self sortResponseDataDescending:returnList];
    
    return returnList;
}

-(NSMutableArray *) parseWireAuthorizationResults:(NSData*) response{
    
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
    
    [self sortResponseDataDescending:returnList];
    
    return returnList;
}

-(NSArray *) parseAchAuthorizationHistoryResults:(NSData*) response{
    
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

-(NSArray *) parseCheckAuthorizationHistoryResults:(NSData*) response{
    
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

-(NSArray *) parseWireAuthorizationHistoryResults:(NSData*) response{
    
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




/*Sort Functions*/

- (void) sortResponseDataDescending:(NSMutableArray *) dataToSort{
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"arrivalDate" ascending:FALSE];
    [dataToSort sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
}



@end
