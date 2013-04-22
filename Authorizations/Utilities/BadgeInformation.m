//
//  Notification.m
//  Authorizations
//
//  Created by Casey Egan on 1/31/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "BadgeInformation.h"

@implementation BadgeInformation

@synthesize pendingAchCount    = _pendingAchCount;
@synthesize pendingCheckCount  = _pendingCheckCount;
@synthesize pendingWireCount   = _pendingWireCount;


- (void) encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInt32:_pendingAchCount forKey:@"achCountKey"];
    [aCoder encodeInt32:_pendingCheckCount forKey:@"checkCountKey"];
    [aCoder encodeInt32:_pendingWireCount forKey:@"wireCountKey"];
}


- (id) initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]){
        
        self.pendingAchCount = [aDecoder decodeInt32ForKey:@"achCountKey"];
        self.pendingCheckCount = [aDecoder decodeInt32ForKey:@"checkCountKey"];
        self.pendingWireCount = [aDecoder decodeInt32ForKey:@"wireCountKey"];

    }
    
    return self;
}
@end
