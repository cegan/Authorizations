//
//  ServiceResponse.h
//  Authorizations
//
//  Created by Casey Egan on 6/26/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceResponse : NSObject

@property (nonatomic, copy) NSString *errorDetails;
@property (nonatomic, assign) BOOL wasSuccessful;
@property (nonatomic,retain) NSMutableArray *responseData;

@end
