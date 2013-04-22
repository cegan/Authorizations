//
//  SearchUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 6/21/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchUtilities : NSObject


+ (NSArray *) searchAllHistoricalItemsContainingText:(NSString *)searchText;

@end
