//
//  URLUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 4/15/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "ArchiveUtilities.h"

@interface URLUtilities : NSObject

+ (NSString *) getTokenURL;
+ (NSString *) getResetUserDataURL;
+ (NSString *) getAchApprovalsURL;
+ (NSString *) getCheckApprovalsURL;
+ (NSString *) getWireApprovalsURL;
+ (NSString *) getAchApprovalURLForId:(NSString *) approvalId;
+ (NSString *) getCheckApprovalURLForId:(NSString *) approvalId;
+ (NSString *) getWireApprovalURLForId:(NSString *) approvalId;

+ (NSString *) getLoginURLForUser:(NSString *) user;

+ (NSString *) getAchAuthorizationUrlWithData:(NSMutableArray *) data;
+ (NSString *) getCheckAuthorizationUrlWithData:(NSMutableArray *) data;
+ (NSString *) getWireAuthorizationUrlWithData:(NSMutableArray *) data;

@end
