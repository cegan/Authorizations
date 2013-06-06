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

+ (UIImageView *) getBadgeImageWithCount:(NSInteger *) count;
+ (UIImageView *) getApprovalDateTimeStampForDate:(NSDate *) approvalDate;
+ (UIImageView *) getArrivalStampForDate:(NSDate *) date;
+ (UIImageView *) getApprovalTypeStampWithText:(NSString *) text atPosition:(int) position;
+ (NSString *) getLabelForAuthorizationType:(ApprovalDetailBase *) type;


+ (void) showModalApprovalSuccessInView:(UIView *) view;
+ (void) showModalApprovalErrorInView:(UIView *) view;
+ (void) showModalNetworkError:(NSInteger *) errorType InView:(UIView *) view;
+ (void) showLocalNotification:(NSString *) messageBody messageAction:(NSString *) messageAction;

+ (UIButton *) getAuthorizationsDoneButton;
+ (UIButton *) getAuthorizationDetailsBackButton;

@end
