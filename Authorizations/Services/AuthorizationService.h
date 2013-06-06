//
//  Service.h
//  Authorizations
//
//  Created by Casey Egan on 5/30/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApprovalDetailBase.h"
#import "ServiceResponse.h"
#import "UserInformation.h"


@interface AuthorizationService : NSObject

@property (nonatomic,retain) NSData *serviceResponseData;
@property (nonatomic,retain) ServiceResponse *serviceResponse;

-(NSDictionary *) getApiGatewayAccessTokens;
-(NSArray *) getAchAuthorizationHistory;
-(NSArray *) getCheckAuthorizationHistory;
-(NSArray *) getWireAuthorizationHistory;


- (void) loginUser:(NSString *) userId;
- (void) resetUserData:(NSString *) userId;

- (void) getAuthorizationHistoryAsync;

- (void) getAchAuthorizationsAsyncWithCallBack:(NSString *) callBack;
- (void) getCheckAuthorizationsAsyncWithCallBack:(NSString *) callBack;
- (void) getWireAuthorizationsAsyncWithCallback:(NSString *) callBack;

-(void) authorizeAch:(NSMutableArray *) achsToAuthorize AsAsync:(BOOL) async;
-(void) authorizeCheck:(NSMutableArray *) checksToAuthorize AsAsync:(BOOL) async;
-(void) authorizeWire:(NSMutableArray *) wiresToAuthorize AsAsync:(BOOL) async;


-(ServiceResponse *) getAchAuthorizationById:(NSString *) identifier;
-(ServiceResponse *) getCheckAuthorizationById:(NSString *) identifier;
-(ServiceResponse *) getWireAuthorizationById:(NSString *) identifier;

- (NSData *) getAchAuthorizationsAsAsync:(BOOL) asAsync withCallBack:(NSString *) callBack;

@end
