//
//  ContactInformation.m
//  Authorizations
//
//  Created by Casey Egan on 4/5/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "ContactInformation.h"

@implementation ContactInformation


@synthesize address         = _address;
@synthesize city            = _city;
@synthesize state           = _state;
@synthesize zipCode         = _zipCode;
@synthesize homePhone       = _homePhone;
@synthesize mobilePhone     = _mobilePhone;
@synthesize emailAddress    = _emailAddress;


- (void) encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_address forKey:@"addressKey"];
    [aCoder encodeObject:_city forKey:@"cityKey"];
    [aCoder encodeObject:_state forKey:@"stateKey"];
    [aCoder encodeObject:_zipCode forKey:@"zipCodeKey"];
    [aCoder encodeObject:_homePhone forKey:@"homePhoneKey"];
    [aCoder encodeObject:_mobilePhone forKey:@"mobilePhoneKey"];
    [aCoder encodeObject:_emailAddress forKey:@"emailAddressKey"];
    
}


- (id) initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]){
        
        _address        = [aDecoder decodeObjectForKey:@"addressKey"];
        _city           = [aDecoder decodeObjectForKey:@"cityKey"];
        _state          = [aDecoder decodeObjectForKey:@"stateKey"];
        _zipCode        = [aDecoder decodeObjectForKey:@"zipCodeKey"];
        _homePhone      = [aDecoder decodeObjectForKey:@"homePhoneKey"];
        _mobilePhone    = [aDecoder decodeObjectForKey:@"mobilePhoneKey"];
        _emailAddress   = [aDecoder decodeObjectForKey:@"emailAddressKey"];
	}
    
	return self;
}


@end
