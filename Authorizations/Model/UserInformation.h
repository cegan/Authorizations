//
//  UserInformation.h
//  Authorizations
//
//  Created by Casey Egan on 3/9/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject <NSCoding>


@property (nonatomic, copy) NSString *networkId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *nameFirst;
@property (nonatomic, copy) NSString *nameLast;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *deviceToken;

@end
