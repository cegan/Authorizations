//
//  SortingUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 5/5/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface SortingUtilities : NSObject


+ (NSMutableArray *) sortHistoryItems: (NSMutableArray *) itemsToSort ByType:(int) type;

@end
