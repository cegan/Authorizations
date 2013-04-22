//
//  BadgeUpdater.m
//  Authorizations
//
//  Created by Casey Egan on 1/31/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "BadgeUpdater.h"


@implementation BadgeUpdater


+ (void) updateBadgeValue:(NSString *) value forMenuItem:(NSString *) menuItem{
    
        
    BadgeInformation *badgeCounts = [[BadgeInformation alloc] init];
    BadgeInformation *notification = [ArchiveUtilities unArchiveNotificationWithKey:kUnviewedNotifications];

    badgeCounts.pendingAchCount    = notification.pendingAchCount;
    badgeCounts.pendingCheckCount  = notification.pendingCheckCount;
    badgeCounts.pendingWireCount   = notification.pendingWireCount;
    
   
    if([menuItem isEqualToString:kNewIncomingAchAuthorization]){
        
        badgeCounts.pendingAchCount =  [value integerValue];
    }
    else if([menuItem isEqualToString:kNewIncomingCheckAuthorization]){
        
        badgeCounts.pendingCheckCount =  [value integerValue];
    }
    else if([menuItem isEqualToString:kNewIncomingWireAuthorization]){
        
        badgeCounts.pendingWireCount =  [value integerValue];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = (badgeCounts.pendingAchCount + badgeCounts.pendingCheckCount + badgeCounts.pendingWireCount);
    [ArchiveUtilities archiveNotification:badgeCounts withKey:kUnviewedNotifications];

}

+ (void) incrementBadgeValueForMenuItem:(NSString *) menuItem{
    
    BadgeInformation *badgeCounts       = [[BadgeInformation alloc] init];
    BadgeInformation *existingBadgeInfo = [ArchiveUtilities unArchiveNotificationWithKey:kUnviewedNotifications];
    
    badgeCounts.pendingAchCount     = existingBadgeInfo.pendingAchCount;
    badgeCounts.pendingCheckCount   = existingBadgeInfo.pendingCheckCount;
    badgeCounts.pendingWireCount    = existingBadgeInfo.pendingWireCount;

    if([menuItem isEqualToString:kNewIncomingAchAuthorization]){
        
        badgeCounts.pendingAchCount = existingBadgeInfo.pendingAchCount + 1;
    }
    else if([menuItem isEqualToString:kNewIncomingCheckAuthorization]){
        
        badgeCounts.pendingCheckCount = existingBadgeInfo.pendingCheckCount + 1;
    }
    else if([menuItem isEqualToString:kNewIncomingWireAuthorization]){
        
        badgeCounts.pendingWireCount = existingBadgeInfo.pendingWireCount + 1;
    }
    
    [ArchiveUtilities archiveNotification:badgeCounts withKey:kUnviewedNotifications];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = (badgeCounts.pendingAchCount + badgeCounts.pendingCheckCount + badgeCounts.pendingWireCount);
}



+ (void) decrementBadgeForType:(NSString *) type withValue:(int) value{
    
    BadgeInformation *badgeInfo = [ArchiveUtilities unArchiveNotificationWithKey:kUnviewedNotifications];
    
    if([type isEqualToString:kNewAchAuthorizationReceipt] || [type isEqualToString:kNewAchAuthorizationSilentReceipt]){
        
        if(badgeInfo.pendingAchCount >= 0){
            
            badgeInfo.pendingAchCount = (badgeInfo.pendingAchCount - value);
        }
    }
    
    else if([type isEqualToString:kNewCheckAuthorizationReceipt])
    {
        if(badgeInfo.pendingCheckCount >= 0){
            
            badgeInfo.pendingCheckCount = (badgeInfo.pendingCheckCount - value);
        }
    }
    
    else if([type isEqualToString:kNewWireAuthorizationReceipt]){
        
        if(badgeInfo.pendingWireCount >= 0){
            
            badgeInfo.pendingWireCount = (badgeInfo.pendingWireCount - value);
        }
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = (badgeInfo.pendingAchCount + badgeInfo.pendingCheckCount + badgeInfo.pendingWireCount);
    
    [ArchiveUtilities archiveNotification:badgeInfo withKey:kUnviewedNotifications];
    
}



@end
