//
//  CalendarUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 5/25/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "CalendarUtilities.h"

@implementation CalendarUtilities


+ (int) getHourFromDate:(NSDate *) date{
    
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSDateComponents *components    = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour                  = [components hour];
    
    if(hour >= 13){
        
        hour = (hour - 12);
        
    }
    else{
        
        hour = (hour + 12);
    }
    
    return hour;
}

+ (int) getMinuteFromDate:(NSDate *) date{
    
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSDateComponents *components    = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger minutes               = [components minute];
    
    return minutes;
}

+ (NSString *) getCurrentDateTime{
    
    NSDate *today               = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setAMSymbol:@"AM"];
    [dateFormat setPMSymbol:@"PM"];
    [dateFormat setDateFormat:@"MM/dd/yy hh:mm a"];
    
    return [dateFormat stringFromDate:today];
}

+ (NSString *) getLongDateFormatForDate:(NSDate *) date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    
    return [dateFormat stringFromDate:date];
    
}

+ (NSString *) getTimeFromDate:(NSDate *) date{
    
    return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}


+ (int)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime{
    
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:fromDateTime toDate:toDateTime options:0];
    
    return [difference day];
}



@end
