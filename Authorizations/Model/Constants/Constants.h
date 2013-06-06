//
//  Constants.h
//  Authorizations
//
//  Created by Casey Egan on 6/6/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString *const kAchDataKey;
extern NSString *const kCheckDataKey;
extern NSString *const kWireDataKey;
extern NSString *const kHostAddress;
extern NSString *const kHostTokenRefreshAddress;
extern NSString *const kUnviewedNotifications;
extern NSString *const kMenuItemSelected;
extern NSString *const kAuthorizationItemSelected;
extern NSString *const kUserDidSuccessfullyLogin;
extern NSString *const kUserDidFailLogin;
extern NSString *const kAuthAppDeviceToken;
extern NSString *const kApiGatewayConsumerKeyAndSecret;
extern NSString *const kApiGatewayGrantType;
extern NSString *const kUsersApiGatewayAccessTokenKey;
extern NSString *const kUsersApiGatewayRefreshTokenKey;
extern NSString *const kAccessTokenExpirationKey;
extern NSString *const kUserInformationKey;


extern NSString *const kApprovalIdKey;
extern NSString *const kFailedIdKey;
extern NSString *const kCheckApprovalIdKey;
extern NSString *const kWireApprovalIdKey;
extern NSString *const kNewIncomingAchAuthorization;
extern NSString *const kNewIncomingCheckAuthorization;
extern NSString *const kNewIncomingWireAuthorization;
extern NSString *const kUpdateAchAuthorization;
extern NSString *const kUpdateCheckAuthorization;
extern NSString *const kUpdateWireAuthorization;
extern NSString *const kNewAchAuthorizationReceipt;
extern NSString *const kNewCheckAuthorizationReceipt;
extern NSString *const kNewWireAuthorizationReceipt;
extern NSString *const kNewAchAuthorizationSilentReceipt;

extern NSString *const kAchDelete;
extern NSString *const kCheckDelete;
extern NSString *const kWireDelete;
extern NSString *const kAchUpdate;
extern NSString *const kCheckUpdate;
extern NSString *const kWireUpdate;


extern NSString *const kAchCellIdentifier;
extern NSString *const kCheckCellIdentifier;
extern NSString *const kWireCellIdentifier;
extern NSString *const kLoginCellIdentifier;

extern int const kTableRowHeight;
extern int const kAuthorizationsMenuRowHeight;
extern int const kAchDetailsTotalRows;
extern int const kCheckDetailsTotalRows;
extern int const kWiresDetailsTotalRows;

extern int const kAuthorizationsAchMenuItem;
extern int const kAuthorizationsChecksMenuItem;
extern int const kAuthorizationsWiresMenuItem;

extern float const kTimeStampCornerRadius;
extern float const kBorderWidth;


#define BROWN_MENU_BACKGROUND_COLOR_FULL_ALPHA      [UIColor colorWithRed:229.00/255.0 green:217.0/255.00 blue:191.0/255.00 alpha:1];
#define BROWN_MENU_SEPERATOR_COLOR_FULL_ALPHA       [UIColor colorWithRed:183.00/255.0 green:163.0/255.00 blue:116.0/255.00 alpha:1];
#define BROWN_MENU_SEPERATOR_COLOR_HALF_ALPHA       [UIColor colorWithRed:183.00/255.0 green:163.0/255.00 blue:116.0/255.00 alpha:0.5];
#define BROWN_SEPERATOR_COLOR_HALF_ALPHA            [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:0.5]
#define BROWN_BORDER_COLOR_HALF_ALPHA               [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:0.5].CGColor
#define BROWN_BORDER_COLOR                          [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0].CGColor
#define RED_BORDER_COLOR                            [UIColor colorWithRed:147.00/255.0 green:27.0/255.00 blue:12.0/255.00 alpha:1.0].CGColor
#define GREEN_TEXT_COLOR                            [UIColor colorWithRed:0.00/255.0 green:88.0/255.00 blue:38.0/255.00 alpha:0.9]
#define RED_TEXT_COLOR                              [UIColor colorWithRed:147.00/255.0 green:27.0/255.00 blue:12.0/255.00 alpha:1.0]
#define RED_TEXT_COLOR_HALF_ALPHA                   [UIColor colorWithRed:147.00/255.0 green:27.0/255.00 blue:12.0/255.00 alpha:0.7]
#define BROWN_TEXT_COLOR                            [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0];
#define BROWN_TEXT_COLOR_HALF_ALPHA                 [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:0.5];
#define CHARCOAL_GREY_TEXT_COLOR                    [UIColor colorWithRed:85.0/255.0 green:85.0/255.00 blue:85.0/255.00 alpha:0.7]; 

#define HELVETICA_NEUE_BOLD_ITALIC                  [[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:12] init];




@end
