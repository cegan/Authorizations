//
//  ApprovalDetailBase.h
//  Authorizations
//
//  Created by Casey Egan on 5/30/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactInformation.h"

@interface ApprovalDetailBase : NSObject


@property (nonatomic, copy) NSString *iD;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *accountNumber;
@property (nonatomic, copy) NSString *originatingSystem;
@property (nonatomic, copy) NSString *arrivalTime;
@property (nonatomic, copy) NSString *userNotes;
@property (nonatomic, copy) NSString *exceptionDetails;
@property (nonatomic, copy) NSString *approvalLocationLatitude;
@property (nonatomic, copy) NSString *approvalLocationLongitude;
@property (nonatomic, retain) ContactInformation *contactInformation;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL hasBeenViewed;
@property (nonatomic, assign) BOOL isApproved;
@property (nonatomic, assign) BOOL isPendingApproval;
@property (nonatomic, assign) BOOL hasApprovalErrors;

@property (nonatomic, copy) NSDate *arrivalDate;
@property (nonatomic, copy) NSDate *approvedOnDate;

@property (nonatomic, assign) double amount;

@end
