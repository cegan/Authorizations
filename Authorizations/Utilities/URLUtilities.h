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
+ (NSString *) getLoginURLForUser:(NSString *) user;


+ (NSString *) getResetUserDataURL;
+ (NSString *) getAchApprovalsURL;
+ (NSString *) getCheckApprovalsURL;
+ (NSString *) getWireApprovalsURL;


+ (NSString *) getAchHistoryURL;
+ (NSString *) getCheckHistoryURL;
+ (NSString *) getWireHistoryURL;

+ (NSString *) getAchApprovalURLForId:(NSString *) approvalId;
+ (NSString *) getCheckApprovalURLForId:(NSString *) approvalId;
+ (NSString *) getWireApprovalURLForId:(NSString *) approvalId;



+ (NSString *) getAchAuthorizationUrlWithData:(NSMutableArray *) data;
+ (NSString *) getCheckAuthorizationUrlWithData:(NSMutableArray *) data;
+ (NSString *) getWireAuthorizationUrlWithData:(NSMutableArray *) data;

@end
