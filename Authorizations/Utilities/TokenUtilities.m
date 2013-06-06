//
//  TokenUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 4/17/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "TokenUtilities.h"

@implementation TokenUtilities


+ (void) refreshUsersAccessToken{
    
    NSDictionary *results = [[AuthorizationService alloc] init].getApiGatewayAccessTokens;
    
    [ArchiveUtilities archiveUsersApiGatewayAccessToken:[results objectForKey:@"access_token"]];
    [ArchiveUtilities archiveUsersApiGatewayRefreshToken:[results objectForKey:@"refresh_token"]];
}

+ (void) generateAndArchiveUserApiGatewayTokens{
    
    NSDictionary *results = [[AuthorizationService alloc] init].getApiGatewayAccessTokens;
    
    [ArchiveUtilities archiveUsersApiGatewayAccessToken:[results objectForKey:@"access_token"]];
    [ArchiveUtilities archiveUsersApiGatewayRefreshToken:[results objectForKey:@"refresh_token"]];
}

+ (BOOL) isUsersAccessTokenExpired{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults){
        
        NSDate *tokenExpirationDateTime =  [standardUserDefaults objectForKey:kAccessTokenExpirationKey];
        NSDate *currentDateTime         = [NSDate date];
        
        //is currentDateTime later than tokenExpirationDateTime
        if ([currentDateTime compare:tokenExpirationDateTime] == NSOrderedDescending) {
            
            return YES;
        }
        else{
            
            return NO;
        }
    }
    
    return YES;
}

+ (NSDate *) renewAccessTokenExpirationDateTime{
    
    NSDate *mydate                = [NSDate date];
    NSTimeInterval secondsInHours = 3500;
    
   return [mydate dateByAddingTimeInterval:secondsInHours];
    
}

+ (NSString *) getAuthorizationHeaderValue{
    
    
    NSLog(@"token is: %@", [ArchiveUtilities unarchiveUsersApiGatewayAccessToken]);
    
    return [NSString stringWithFormat: @"%@%@", @"Bearer ", [ArchiveUtilities unarchiveUsersApiGatewayAccessToken]];
    
}

@end
