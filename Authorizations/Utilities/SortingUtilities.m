//
//  SortingUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 5/5/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "SortingUtilities.h"

@implementation SortingUtilities



+ (NSMutableArray *) sortHistoryItems: (NSMutableArray *) itemsToSort ByType:(int) type{
    
    NSSortDescriptor *sortDescriptor;
    
    switch(type){
            
        case kSortByCustomerName:
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            break;
        
        case kSortByApprovalType:
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES];
            break;
            
        case kSortByApprovedOnDate:
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"approvedOnDate" ascending:YES];
            break;
    }
    
    [itemsToSort sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return itemsToSort;
}

@end
