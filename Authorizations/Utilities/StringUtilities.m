//
//  StringUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 5/21/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "StringUtilities.h"
#import "ArchiveUtilities.h"
#import "Constants.h"
#import "ApprovalDetailBase.h"

@implementation StringUtilities


+ (NSString*) formatDoubleAsCurrency:(double)amount{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];

    return [formatter stringFromNumber:[NSNumber numberWithFloat:amount]];
}

+ (NSAttributedString *) getRefreshControlAttributedStringWithValue:(NSString *) value{
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:value];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0] range:NSMakeRange(0,value.length)];
    
    return string;
}

@end
