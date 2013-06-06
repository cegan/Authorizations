//
//  TokenUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 4/17/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveUtilities.h"
#import "AuthorizationService.h"
#import "Constants.h"

@interface TokenUtilities : NSObject

+ (void) generateAndArchiveUserApiGatewayTokens;
+ (void) refreshUsersAccessToken;
+ (BOOL) isUsersAccessTokenExpired;

+ (NSDate *) renewAccessTokenExpirationDateTime;
+ (NSString *) getAuthorizationHeaderValue;
@end
