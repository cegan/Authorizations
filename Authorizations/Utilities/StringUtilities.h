//
//  StringUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 5/21/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtilities : NSObject

+ (NSString*) formatDoubleAsCurrency:(double)amount;
+ (NSAttributedString *) getRefreshControlAttributedStringWithValue:(NSString *) value;

@end
