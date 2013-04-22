//
//  ApprovalDetailBase.m
//  Authorizations
//
//  Created by Casey Egan on 5/30/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "ApprovalDetailBase.h"

@implementation ApprovalDetailBase

@synthesize iD                  = _iD;
@synthesize name                = _name;
@synthesize accountNumber       = _additionalDetail;
@synthesize originatingSystem   = _originatingSystem;
@synthesize userNotes           = _userNotes;
@synthesize amount              = _amount;
@synthesize arrivalTime         = _arrivalTime;
@synthesize arrivalDate         = _arrivalDate;
@synthesize approvedOnDate      = _approvedOnDate;
@synthesize isSelected          = _isSelected;
@synthesize hasBeenViewed       = _hasBeenViewed;
@synthesize isApproved          = _isApproved;
@synthesize hasApprovalErrors   = _hasApprovalErrors;
@synthesize exceptionDetails    = _exceptionDetails;
@synthesize approvalLocationLatitude = _approvalLocationLatitude;
@synthesize approvalLocationLongitude = _approvalLocationLongitude;
@synthesize contactInformation      = _contactInformation;



@end
