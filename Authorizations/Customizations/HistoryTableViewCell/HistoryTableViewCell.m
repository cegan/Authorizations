//
//  HistoryTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 2/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "AuthorizationUIUtilities.h"
#import "CalendarUtilities.h"

@interface HistoryTableViewCell()



@end



@implementation HistoryTableViewCell

#define kAmountLabelWidth                   81.0
#define kAmountLabelHeight                  21.0
#define kNameLabelWidth                     193.0
#define kNameLabelHeight                    20.0
#define kDetailLabelWidth                   203.0
#define kDetailLabelHeight                  21.0
#define kApproveCheckboxImageViewWidth      25.0
#define kApproveCheckboxImageViewHeight     25.0
#define kArrivalTimeStampWidth              50.0
#define kArrivalTimeStampHeight             17.0
#define kApprovalTimeStampWidth             85.0
#define kApprovalTimeStampHeight            17.0
#define kArrivalDayStampWidth               50.0
#define kArrivalDayStampHeight              17.0

@synthesize nameLabel                   = _nameLabel;
@synthesize detailsLabel                = _detailsLabel;
@synthesize amountLabel                 = _amountLabel;
@synthesize isApproved                  = _isApproved;




- (void) bindDetails:(ApprovalDetailBase *)approvalDetail{
    
    _nameLabel.text                = approvalDetail.name;
    _detailsLabel.text             = approvalDetail.accountNumber;
    _amountLabel.text              = [StringUtilities formatDoubleAsCurrency:approvalDetail.amount];
    _amountLabel.textColor         = RED_TEXT_COLOR;
    
    self.accessoryType             = UITableViewCellAccessoryDisclosureIndicator;
    
    [self addSubview:[AuthorizationUIUtilities getApprovalDateTimeStampForDate:[CalendarUtilities getLongDateFormatForDate:approvalDetail.approvedOnDate]]];
    
}


@end
