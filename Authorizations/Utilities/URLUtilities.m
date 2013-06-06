//
//  URLUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 4/15/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "URLUtilities.h"



@implementation URLUtilities


+ (NSString *) getTokenURL{
    
    return [NSString stringWithFormat: @"%@%@", kHostAddress, @"token"];
}
+ (NSString *) getLoginURLForUser:(NSString *) user{
    
    return [NSString stringWithFormat: @"%@%@%@%@%@%@%@", kHostAddress,  @"LoginUser?userId=",
            user, @"&password=", @"", @"&deviceToken=", [ArchiveUtilities unarchiveUserDeviceToken]];
    
}


+ (NSString *) getAchApprovalsURL{
    
   return  [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetAchApprovals/", [ArchiveUtilities getloggedinUser]];

}

+ (NSString *) getCheckApprovalsURL{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetCheckApprovals/", [ArchiveUtilities getloggedinUser]];
}

+ (NSString *) getWireApprovalsURL{
    
   return [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetWireApprovals/", [ArchiveUtilities getloggedinUser]];

}

+ (NSString *) getAchHistoryURL{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetAchAuthorizationHistory/", [ArchiveUtilities getloggedinUser]];
}

+ (NSString *) getCheckHistoryURL{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetCheckAuthorizationHistory/", [ArchiveUtilities getloggedinUser]];
}

+ (NSString *) getWireHistoryURL{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"GetWireAuthorizationHistory/", [ArchiveUtilities getloggedinUser]];
}

+ (NSString *) getAchApprovalURLForId:(NSString *) approvalId{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress, @"GetAchApprovalsById/", approvalId];    
}

+ (NSString *) getCheckApprovalURLForId:(NSString *) approvalId{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress, @"GetCheckApprovalsById/", approvalId];
}

+ (NSString *) getWireApprovalURLForId:(NSString *) approvalId{
    
    return [NSString stringWithFormat: @"%@%@%@", kHostAddress, @"GetWireApprovalsById/", approvalId];
}

+ (NSString *) getAchAuthorizationUrlWithData:(NSMutableArray *) data{
    
    
    return [NSString stringWithFormat: @"%@%@%@%@%@", kHostAddress,  @"AuthorizeAchsAsync?achsToApprove=",
                             [self getAuthorizationIds:data], @"&deviceId=", [ArchiveUtilities unarchiveUserDeviceToken]];
    
}

+ (NSString *) getCheckAuthorizationUrlWithData:(NSMutableArray *) data{
    
    
    return [NSString stringWithFormat: @"%@%@%@%@%@", kHostAddress,  @"AuthorizeChecksAsync?checksToApprove=",
            [self getAuthorizationIds:data], @"&deviceId=", [ArchiveUtilities unarchiveUserDeviceToken]];
}

+ (NSString *) getWireAuthorizationUrlWithData:(NSMutableArray *) data{
    
    return [NSString stringWithFormat: @"%@%@%@%@%@", kHostAddress,  @"AuthorizeWiresAsync?wiresToApprove=",
            [self getAuthorizationIds:data], @"&deviceId=", [ArchiveUtilities unarchiveUserDeviceToken]];
    
}

+ (NSString *) getResetUserDataURL{
    
    return  [NSString stringWithFormat: @"%@%@%@", kHostAddress,  @"ResetUserData/", [ArchiveUtilities getloggedinUser]];
}

+ (NSString *) getAuthorizationIds:(NSMutableArray *) authorizations{
    
    NSString *achsToApprove = @"";
    
    for (ApprovalDetailBase *item in authorizations) {
        
        achsToApprove = [[achsToApprove stringByAppendingString:item.iD] stringByAppendingString:@","];
    }
    
    return achsToApprove;
}

@end
