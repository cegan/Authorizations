//
//  Notification.h
//  Authorizations
//
//  Created by Casey Egan on 1/31/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BadgeInformation : NSObject <NSCoding>


@property (nonatomic, assign) int pendingAchCount;
@property (nonatomic, assign) int pendingWireCount;
@property (nonatomic, assign) int pendingCheckCount;

@end
