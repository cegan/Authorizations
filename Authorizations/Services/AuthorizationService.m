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
#import "ParsingUtilities.h"
#import "Constants.h"


 
@interface AuthorizationService()

- (void) makeAsyncServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod withCallBack:(NSString *) callBack;

- (NSData *) makeServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod;

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


- (void) makeAsyncServiceRequestWithUrl:(NSString *) url forHTTPMethod:(NSString *) httpMethod withCallBack:(NSString *) callBack{
    
    
    if([TokenUtilities isUsersAccessTokenExpired]){
        
        [TokenUtilities refreshUsersAccessToken];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request addValue:[TokenUtilities getAuthorizationHeaderValue] forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:httpMethod];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
     
                completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    
                    if(callBack){
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:callBack object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:callBack]];
                    }
            }];
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


/*Service Functions*/

- (void) resetUserData:(NSString *) userId{
    
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getResetUserDataURL] forHTTPMethod:@"POST" withCallBack:nil];
}

- (void) loginUser:(NSString *) userId{
    
      
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kHostTokenRefreshAddress]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:kApiGatewayConsumerKeyAndSecret forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:[kApiGatewayGrantType dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
     
                        completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                            NSDictionary *tokenData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                            NSString *accessToken   = [tokenData objectForKey:@"access_token"];
                            NSString *refreshToken  = [tokenData objectForKey:@"refresh_token"];
                            
                            if(accessToken){
                                
                                [ArchiveUtilities archiveUsersApiGatewayAccessToken:accessToken];
                                [ArchiveUtilities archiveUsersApiGatewayRefreshToken:refreshToken];
                                
                                [self getUserInformationForUser:userId withAccessToken:accessToken];
                            }
                        }];
}

- (void) getUserInformationForUser:(NSString *) user withAccessToken:(NSString *) accessToken{
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[URLUtilities getLoginURLForUser:user]]];
    
    
        [request addValue:[TokenUtilities getAuthorizationHeaderValue] forHTTPHeaderField:@"Authorization"];
        [request setHTTPMethod:@"GET"];
    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
    
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
                                       UserInformation *userInformation = [ParsingUtilities parseUserInfoResults:data];
    
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"loginCompleted" object:nil userInfo:[NSDictionary dictionaryWithObject:userInformation forKey:kUserInformationKey]];
    
                                   }];
    
    
    
}

- (void) getAuthorizationHistoryAsync{
    
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getAchHistoryURL] forHTTPMethod:@"GET" withCallBack:@"didFinishRefreshingAchHistory"];
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getCheckHistoryURL] forHTTPMethod:@"GET" withCallBack:@"didFinishRefreshingCheckHistory"];
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getWireHistoryURL] forHTTPMethod:@"GET" withCallBack:@"didFinishRefreshingWireHistory"];
}

- (void) getAchAuthorizationsAsyncWithCallBack:(NSString *) callBack{
    
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getAchApprovalsURL] forHTTPMethod:@"GET" withCallBack:callBack];
    
}

- (void) getCheckAuthorizationsAsyncWithCallBack:(NSString *) callBack{
    
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getCheckApprovalsURL] forHTTPMethod:@"GET" withCallBack:callBack];

}

- (void) getWireAuthorizationsAsyncWithCallback:(NSString *) callBack{
    
    [self makeAsyncServiceRequestWithUrl:[URLUtilities getWireApprovalsURL] forHTTPMethod:@"GET" withCallBack:callBack];
    
}

- (void) authorizeAch:(NSMutableArray *) achsToAuthorize AsAsync:(BOOL) async{
    
    if(async){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getAchAuthorizationUrlWithData:achsToAuthorize] forHTTPMethod:@"GET" withCallBack:nil];
    }
    
}

- (void) authorizeCheck:(NSMutableArray *) checksToAuthorize AsAsync:(BOOL) async{
    
    if(async){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getCheckAuthorizationUrlWithData:checksToAuthorize] forHTTPMethod:@"GET" withCallBack:nil];
    }
}

- (void) authorizeWire:(NSMutableArray *) wiresToAuthorize AsAsync:(BOOL) async{
    
    if(async){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getWireAuthorizationUrlWithData:wiresToAuthorize] forHTTPMethod:@"GET" withCallBack:nil];
    }
}

-(ServiceResponse *) getAchAuthorizationById:(NSString *) authorizationId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getAchApprovalURLForId:authorizationId] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [ParsingUtilities parseAchAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getCheckAuthorizationById:(NSString *) authorizationId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getCheckApprovalURLForId:authorizationId] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [ParsingUtilities parseCheckAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

-(ServiceResponse *) getWireAuthorizationById:(NSString *) authorizationId{
    
    _serviceResponseData            = [self makeServiceRequestWithUrl:[URLUtilities getWireApprovalURLForId:authorizationId] forHTTPMethod:@"GET"];
    _serviceResponse.responseData   = [ParsingUtilities parseWireAuthorizationResults:_serviceResponseData];
    
    return _serviceResponse;
}

- (NSData *) getAchAuthorizationsAsAsync:(BOOL) asAsync withCallBack:(NSString *) callBack{
    
    if(asAsync){
        
        [self makeAsyncServiceRequestWithUrl:[URLUtilities getAchApprovalsURL] forHTTPMethod:@"GET" withCallBack:callBack];
        return nil;
    }
    else{
        
        return [self makeServiceRequestWithUrl:[URLUtilities getAchApprovalsURL] forHTTPMethod:@"GET"];
    }
}

- (NSDictionary *) getApiGatewayAccessTokens{
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kHostTokenRefreshAddress]];
    
    
    [request setHTTPMethod:@"POST"];
    [request addValue:kApiGatewayConsumerKeyAndSecret forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:[@"grant_type=password&username=admin&password=admin&scope=PRODUCTION" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:nil];
    
    return [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
}

- (NSArray *) getAchAuthorizationHistory{

    _serviceResponseData = [self makeServiceRequestWithUrl:[URLUtilities getAchHistoryURL] forHTTPMethod:@"GET"];
    
    return [ParsingUtilities parseAchAuthorizationHistoryResults:_serviceResponseData];
    
}

- (NSArray *) getCheckAuthorizationHistory{
    
    
    _serviceResponseData = [self makeServiceRequestWithUrl:[URLUtilities getCheckHistoryURL] forHTTPMethod:@"GET"];
    
    return [ParsingUtilities parseCheckAuthorizationHistoryResults:_serviceResponseData];
}

- (NSArray *) getWireAuthorizationHistory{
    
    _serviceResponseData  = [self makeServiceRequestWithUrl:[URLUtilities getWireHistoryURL] forHTTPMethod:@"GET"];
    
    return [ParsingUtilities parseWireAuthorizationHistoryResults:_serviceResponseData];
}



@end
