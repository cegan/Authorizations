//
//  ArchiveUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 6/7/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "ArchiveUtilities.h"
#import "ApprovalDetailBase.h"
#import "BadgeInformation.h"
#import "UserInformation.h"
#import "TokenUtilities.h"
#import "Constants.h"

@implementation ArchiveUtilities


+ (UserInformation *) getArchivedUserInformation{
    
    return (UserInformation *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInformationKey]];
}

+ (BadgeInformation *) unArchiveNotificationWithKey:(NSString *)key{
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
}

+ (NSMutableArray *) unArchiveHistoricalItemsWithKey:(NSString *)key{
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
}

+ (NSMutableArray *) getAllHistoricalItems{
    
    NSMutableArray* allHistoricalItems = [[NSMutableArray alloc] init];
    
    NSMutableArray *unArchivedAchs        = [self unArchiveHistoricalItemsWithKey:kAchDataKey];
    NSMutableArray *unArchivedChecks      = [self unArchiveHistoricalItemsWithKey:kCheckDataKey];
    NSMutableArray *unArchivedWires       = [self unArchiveHistoricalItemsWithKey:kWireDataKey];
    
    [allHistoricalItems addObjectsFromArray: unArchivedAchs];
    [allHistoricalItems addObjectsFromArray: unArchivedChecks];
    [allHistoricalItems addObjectsFromArray: unArchivedWires];
    
    return allHistoricalItems;
}

+ (NSString *) unarchiveUserDeviceToken{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults){
        
        return [standardUserDefaults objectForKey:kAuthAppDeviceToken];
    }
    
    return nil;
}

+ (NSString *) getloggedinUser{
    
    UserInformation *user = (UserInformation *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInformationKey]];
    
    return user.networkId;
}

+ (NSString *) unarchiveUsersApiGatewayAccessToken{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults){
        
        return [standardUserDefaults objectForKey:kUsersApiGatewayAccessTokenKey];
    }
    
    return nil;
}

+ (NSString *) unarchiveUsersApiGatewayRefreshToken{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults){
        
        return [standardUserDefaults objectForKey:kUsersApiGatewayRefreshTokenKey];
    }
    
    return nil;
}


+ (void) deleteAllArchivedApprovals{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAchDataKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCheckDataKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWireDataKey];
}

+ (void) archiveApprovedItems:(NSArray *)approvedItems withKey:(NSString *)key{
    
    NSMutableArray *allItems = [[NSMutableArray alloc] init];
    
    [allItems addObjectsFromArray:[self unArchiveHistoricalItemsWithKey:key]];
    [allItems addObjectsFromArray:approvedItems];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:allItems] forKey:key];
}

+ (void) archiveApprovedItem:(ApprovalDetailBase *)approval withKey:(NSString *)key{
    
    NSMutableArray *allItems = [[NSMutableArray alloc] init];
    
    [allItems addObjectsFromArray:[self unArchiveHistoricalItemsWithKey:key]];
    [allItems addObject:approval];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:allItems] forKey:key];
}

+ (void) archiveNotification:(BadgeInformation *)notification withKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:notification] forKey:key];
}

+ (void) archiveUserDeviceToken:(NSString *) deviceToken{
    
    [[NSUserDefaults standardUserDefaults] setObject: deviceToken forKey:kAuthAppDeviceToken];
}

+ (void) archiveUsersApiGatewayAccessToken:(NSString *) usersApiGatewayAccessToken{
    
    [[NSUserDefaults standardUserDefaults] setObject: [TokenUtilities renewAccessTokenExpirationDateTime] forKey:kAccessTokenExpirationKey];
    [[NSUserDefaults standardUserDefaults] setObject: usersApiGatewayAccessToken forKey:kUsersApiGatewayAccessTokenKey];
}

+ (void) archiveUsersApiGatewayRefreshToken:(NSString *) usersApiGatewayRefreshToken{
    
    [[NSUserDefaults standardUserDefaults] setObject: usersApiGatewayRefreshToken forKey:kUsersApiGatewayRefreshTokenKey];
}

+ (void) archiveUserInformation:(UserInformation *) userInformation{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:userInformation] forKey:kUserInformationKey];
}

+ (void) archiveDefaultSortingIndex:(NSNumber *) sortingIndex{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:sortingIndex] forKey:@"SortingIndex"];
}


+ (NSNumber *) unArchiveDefaultSortingIndex{
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"SortingIndex"]];
}


+ (void) logoutUser{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInformationKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccessTokenExpirationKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsersApiGatewayAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsersApiGatewayRefreshTokenKey];
}


@end
