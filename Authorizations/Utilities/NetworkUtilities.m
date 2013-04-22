//
//  NetworkUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 2/4/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "NetworkUtilities.h"
#import "Reachability.h"


@implementation NetworkUtilities



+ (BOOL) isRemoteHostReachable{
    
    
    Reachability *reachabilityWithHost = [Reachability reachabilityWithHostName:@"1"];
    
    if(reachabilityWithHost.currentReachabilityStatus == NotReachable){
        
        return NO;
    }
    
    return YES;
}

+ (BOOL) hasConnection{

    
    Reachability *reachability  = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if(networkStatus == NotReachable){
        
        return NO;
    }
    
    return YES;
}

@end
