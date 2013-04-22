//
//  ContactInformation.h
//  Authorizations
//
//  Created by Casey Egan on 4/5/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInformation : NSObject <NSCoding>

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *zipCode;
@property (nonatomic, copy) NSString *homePhone;
@property (nonatomic, copy) NSString *mobilePhone;
@property (nonatomic, copy) NSString *emailAddress;

@end
