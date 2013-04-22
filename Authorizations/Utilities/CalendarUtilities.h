//
//  CalendarUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 5/25/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarUtilities : NSObject


+ (int)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+ (NSString *) getTimeFromDate:(NSDate *) date;
+ (NSString *) getCurrentDateTime;
+ (NSString *) getLongDateFormatForDate:(NSDate *) date;
@end
