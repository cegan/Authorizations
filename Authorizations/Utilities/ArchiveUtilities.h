//
//  ArchiveUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 6/7/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApprovalDetailBase.h"
#import "UserInformation.h"
#import "BadgeInformation.h"

@interface ArchiveUtilities : NSObject


+ (NSMutableArray *) unArchiveHistoricalItemsWithKey:(NSString *)key;
+ (BadgeInformation *) unArchiveNotificationWithKey:(NSString *)key;
+ (NSMutableArray *) getAllHistoricalItems;


+ (void) archiveApprovedItem:(ApprovalDetailBase *)approval withKey:(NSString *)key;
+ (void) archiveApprovedItems:(NSArray *)approvedItems withKey:(NSString *)key;
+ (void) archiveNotification:(BadgeInformation *)notification withKey:(NSString *)key;
+ (void) deleteAllArchivedApprovals;
+ (void) archiveUserInformation:(UserInformation *) userInformation;
+ (void) archiveUserDeviceToken:(NSString *) deviceToken;
+ (void) archiveUsersApiGatewayAccessToken:(NSString *) usersApiGatewayAccessToken;
+ (void) archiveUsersApiGatewayRefreshToken:(NSString *) usersApiGatewayRefreshToken;

+ (NSString *) unarchiveUserDeviceToken;
+ (NSString *) unarchiveUsersApiGatewayAccessToken;
+ (void) logoutUser;
+ (NSString *) getloggedinUser;
+ (UserInformation *) getArchivedUserInformation;

+ (void) archiveDefaultSortingIndex:(NSNumber *) sortingIndex;
+ (NSNumber *) unArchiveDefaultSortingIndex;


@end
