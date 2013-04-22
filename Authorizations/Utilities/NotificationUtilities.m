//
//  Notifications.m
//  Authorizations
//
//  Created by Casey Egan on 2/20/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "NotificationUtilities.h"

@implementation NotificationUtilities


+ (void) sendDataRefreshNotification:(NSString *) type andCount:(int) count{
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dict setObject:[NSString stringWithFormat:@"%i", count] forKey:@"count"];
    [dict setObject:type forKey:@"type"];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveManualRefreshtNotification"
                                                        object:nil
                                                        userInfo:[NSDictionary dictionaryWithObject:dict forKey:@"RefreshInfo"]];
    
}

@end
