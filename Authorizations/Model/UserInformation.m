//
//  UserInformation.m
//  Authorizations
//
//  Created by Casey Egan on 3/9/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation

@synthesize networkId       = _networkId;
@synthesize password        = _password;
@synthesize nameFirst       = _nameFirst;
@synthesize nameLast        = _nameLast;
@synthesize title           = _title;
@synthesize deviceToken     = _deviceToken;

- (void) encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_networkId forKey:@"networkId"];
    [aCoder encodeObject:_password forKey:@"password"];
	[aCoder encodeObject:_nameFirst forKey:@"nameFirst"];
    [aCoder encodeObject:_nameLast forKey:@"nameLast"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_deviceToken forKey:@"deviceToken"];
}


- (id) initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]){
        
        _networkId      = [aDecoder decodeObjectForKey:@"networkId"];
        _password       = [aDecoder decodeObjectForKey:@"password"];
		_nameFirst      = [aDecoder decodeObjectForKey:@"nameFirst"];
        _nameLast       = [aDecoder decodeObjectForKey:@"nameLast"];
        _title          = [aDecoder decodeObjectForKey:@"title"];
        _deviceToken    = [aDecoder decodeObjectForKey:@"deviceToken"];
	}
    
	return self;
}


@end
