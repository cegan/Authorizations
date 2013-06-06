//
//  ParsingUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 5/4/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInformation.h"
#import "AchDetail.h"
#import "CheckDetail.h"
#import "WireDetail.h"


@interface ParsingUtilities : NSObject



+ (UserInformation *) parseUserInfoResults:(NSData*) response;

+ (NSMutableArray *) parseAchAuthorizationResults:(NSData*) response;
+ (NSMutableArray *) parseCheckAuthorizationResults:(NSData*) response;
+ (NSMutableArray *) parseWireAuthorizationResults:(NSData*) response;

+ (NSArray *) parseAchAuthorizationHistoryResults:(NSData*) response;
+ (NSArray *) parseCheckAuthorizationHistoryResults:(NSData*) response;
+ (NSArray *) parseWireAuthorizationHistoryResults:(NSData*) response;


@end
