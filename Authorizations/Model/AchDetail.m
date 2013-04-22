//
//  AchDetail.m
//  Authorizations
//
//  Created by Casey Egan on 5/15/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "AchDetail.h"
#import "CalendarUtilities.h"

@implementation AchDetail

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
@synthesize isPendingApproval   = _isPendingApproval;
@synthesize hasApprovalErrors   = _hasApprovalErrors;
@synthesize exceptionDetails    = _exceptionDetails;
@synthesize approvalLocationLatitude = _approvalLocationLatitude;
@synthesize approvalLocationLongitude = _approvalLocationLongitude;
@synthesize contactInformation = _contactInformation;



- (void) encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_iD forKey:@"iDKey"];
    [aCoder encodeObject:_name forKey:@"nameKey"];
	[aCoder encodeObject:_additionalDetail forKey:@"additionalDetailKey"];
    [aCoder encodeObject:_originatingSystem forKey:@"originatingSystemKey"];
    [aCoder encodeObject:_userNotes forKey:@"userNotesKey"];
    [aCoder encodeObject:_arrivalTime forKey:@"achArrivalTimeKey"];
    [aCoder encodeObject:_approvedOnDate forKey:@"achApprovedOnDateKey"];
    [aCoder encodeBool:_isSelected forKey:@"isSelectedKey"];
    [aCoder encodeBool:_hasBeenViewed forKey:@"hasBeenViewed["];
    [aCoder encodeBool:_isApproved forKey:@"isApprovedKey"];
    [aCoder encodeDouble:_amount forKey:@"amountKey"];
    [aCoder encodeObject:_approvalLocationLatitude forKey:@"approvalLocationLatitudeKey"];
    [aCoder encodeObject:_approvalLocationLongitude forKey:@"approvalLocationLongitudeKey"];
    [aCoder encodeObject:_contactInformation forKey:@"contactInformationKey"];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]){
        
        _iD                 = [aDecoder decodeObjectForKey:@"iDKey"];
        _name               = [aDecoder decodeObjectForKey:@"nameKey"];
		_additionalDetail   = [aDecoder decodeObjectForKey:@"additionalDetailKey"];
        _originatingSystem  = [aDecoder decodeObjectForKey:@"originatingSystemKey"];
        _userNotes          = [aDecoder decodeObjectForKey:@"userNotesKey"];
        _amount             = [aDecoder decodeDoubleForKey:@"amountKey"];
        _arrivalTime        = [aDecoder decodeObjectForKey:@"achArrivalTimeKey"];
        _approvedOnDate     = [aDecoder decodeObjectForKey:@"achApprovedOnDateKey"];
        _isSelected         = [aDecoder decodeBoolForKey:@"isSelectedKey"];
        _hasBeenViewed      = [aDecoder decodeBoolForKey:@"hasBeenViewed"];
        _isApproved         = [aDecoder decodeBoolForKey:@"isApprovedKey"];
        _approvalLocationLatitude = [aDecoder decodeObjectForKey:@"approvalLocationLatitudeKey"];
        _approvalLocationLongitude = [aDecoder decodeObjectForKey:@"approvalLocationLongitudeKey"];
        _contactInformation = [aDecoder decodeObjectForKey:@"contactInformationKey"];
	}
    
	return self;
}


@end
