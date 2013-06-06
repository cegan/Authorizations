//
//  SearchUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 6/21/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "AchDetail.h"
#import "ApprovalDetailBase.h"
#import "SearchUtilities.h"
#import "ArchiveUtilities.h"



@implementation SearchUtilities  


+ (NSArray *) searchAllHistoricalItemsContainingText:(NSString *)searchText{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@ OR additionalDetail contains[cd] %@",searchText, searchText];

    return [[ArchiveUtilities getAllHistoricalItems] filteredArrayUsingPredicate:predicate];
}





@end
