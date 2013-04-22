//
//  AuthorizationUIUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 5/25/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApprovalDetailBase.h"
#import <UIKit/UIKit.h>

@interface AuthorizationUIUtilities : NSObject

+ (UIImageView *) getBadge:(NSInteger *) withBadgeNumber;
+ (UIImageView *) getApprovalDateTimeStampForDate:(NSString *) approvalDate;
+ (UIImageView *) getArrivalStampForDate:(NSDate *) date;


+ (void) updateApproveButton:(UIButton *) button withTotalNumberOfSelectedItems:(int) value;
+ (void) showModalApprovalSuccessInView:(UIView *) view;
+ (void) showModalApprovalErrorInView:(UIView *) view;
+ (void) showModalNetworkError:(NSInteger *) errorType InView:(UIView *) view;
+ (void) showLocalNotification:(NSString *) messageBody messageAction:(NSString *) messageAction;

+ (UIButton *) getAuthorizationsDoneButton;
+ (UIButton *) getAuthorizationDetailsBackButton;

@end
