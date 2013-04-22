//
//  BadgeUpdater.h
//  Authorizations
//
//  Created by Casey Egan on 1/31/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BadgeInformation.h"
#import "Constants.h"
#import "ArchiveUtilities.h"

@interface BadgeUpdater : NSObject

+ (void) updateBadgeValue:(NSString *) value forMenuItem:(NSString *) menuItem;
+ (void) incrementBadgeValueForMenuItem:(NSString *) menuItem;
+ (void) decrementBadgeForType:(NSString *) type withValue:(int) value;

@end
