//
//  Constants.m
//  Authorizations
//
//  Created by Casey Egan on 6/6/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const kAchDataKey                     = @"AchData";
NSString *const kCheckDataKey                   = @"CheckData";
NSString *const kWireDataKey                    = @"WireData";

//NSString *const kHostAddress                    = @"http://testtwilio.fcsamerica.com:8280/Authorizations/1.0/";
NSString *const kHostAddress                    = @"http://192.168.1.2:8280/Authorizations/1.0/";

//NSString *const kHostTokenRefreshAddress        = @"http://testtwilio.fcsamerica.com:8280/token";
NSString *const kHostTokenRefreshAddress      = @"http://192.168.1.2:8280/token";


NSString *const kUnviewedNotifications          = @"Notification";
NSString *const kAuthAppDeviceToken             = @"AuthAppDeviceToken";
NSString *const kUsersApiGatewayAccessTokenKey  = @"UsersApiGatewayAccessTokenKey";
NSString *const kUsersApiGatewayRefreshTokenKey = @"UsersApiGatewayRefreshTokenKey";
NSString *const kAccessTokenExpirationKey       = @"AccessTokenExpirationKey";

//home
NSString *const kApiGatewayConsumerKeyAndSecret = @"Basic bTR0WWE5SUlmTFZjSUEydVlVUWQxc29rUGxRYTpxb2RXb3loRDRZdDAzUFg1VFl2dmNSZ0RSMVFh";

//twilio
//NSString *const kApiGatewayConsumerKeyAndSecret = @"Basic RFpRRGhiaTJzTUZHUGZvZXhLUng0dTlUMzdRYTpRRjQ4QTA0eWhUYTdsYTZYdW83b045M2l0cHdh";


NSString *const kUserInformationKey             = @"UserInformationKey";

NSString *const kMenuItemSelected               = @"didSelectMenuItem";
NSString *const kAuthorizationItemSelected      = @"authorizationItemSelected";
NSString *const kUserDidSuccessfullyLogin       = @"userDidSuccessfullyLogin";
NSString *const kUserDidFailLogin               = @"userDidFailLogin";


NSString *const kApprovalIdKey                  = @"AprId";
NSString *const kFailedIdKey                    = @"FailId";


NSString *const kCheckApprovalIdKey             = @"CheckAprId";
NSString *const kWireApprovalIdKey              = @"WireAprId";

NSString *const kNewIncomingAchAuthorization    = @"NewAch";
NSString *const kNewIncomingCheckAuthorization  = @"NewCheck";
NSString *const kNewIncomingWireAuthorization   = @"NewWire";


NSString *const kUpdateAchAuthorization         = @"AchUpdate";
NSString *const kUpdateCheckAuthorization       = @"CheckUpdate";
NSString *const kUpdateWireAuthorization        = @"WireUpdate";

NSString *const kNewAchAuthorizationSilentReceipt     = @"AchAuthSilent";
NSString *const kNewAchAuthorizationReceipt           = @"AchAuth";
NSString *const kNewCheckAuthorizationReceipt         = @"CheckAuth";
NSString *const kNewWireAuthorizationReceipt          = @"WireAuth";


NSString *const kAchDelete                      = @"AchDelete";
NSString *const kCheckDelete                    = @"CheckDelete";
NSString *const kWireDelete                     = @"WireDelete";


NSString *const kAchUpdate                      = @"AchUpdate";
NSString *const kCheckUpdate                    = @"CheckUpdate";
NSString *const kWireUpdate                     = @"WireUpdate";


NSString *const kAchCellIdentifier              = @"AchCellIdentifier";
NSString *const kCheckCellIdentifier;
NSString *const kWireCellIdentifier;




int const kTableRowHeight                       = 74.5;
int const kAuthorizationsMenuRowHeight          = 40;
int const kAchDetailsTotalRows                  = 8;
int const kCheckDetailsTotalRows                = 8;
int const kWiresDetailsTotalRows                = 8;
int const kAchDetailsTotalRowsWithErrors        = 10;
int const kTableViewSectionHeaderHeightVisible  = 20.0;
int const kTableViewSectionHeaderHeightHidden   = 0.0;
float const kTimeStampCornerRadius              = 5.0;
float const kBorderWidth                        = 0.5;

@end
