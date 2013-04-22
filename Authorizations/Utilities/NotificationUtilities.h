//
//  Notifications.h
//  Authorizations
//
//  Created by Casey Egan on 2/20/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationUtilities : NSObject

+ (void) sendDataRefreshNotification:(NSString *) type andCount:(int) count;


@end




