//
//  HistoryTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 2/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "AuthorizationUIUtilities.h"
#import "AchDetail.h"
#import "CheckDetail.h"
#import "WireDetail.h"
#import "CalendarUtilities.h"

@interface HistoryTableViewCell()



@end



@implementation HistoryTableViewCell


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
    
    UIImageView *dateTimeStamp      = [AuthorizationUIUtilities getApprovalDateTimeStampForDate:approvalDetail.approvedOnDate];
    UIImageView *approvalTypeStamp  = [AuthorizationUIUtilities getApprovalTypeStampWithText:[AuthorizationUIUtilities getLabelForAuthorizationType:approvalDetail] atPosition:                             dateTimeStamp.frame.size.width];
    
   
    [self addSubview:dateTimeStamp];
    [self addSubview:approvalTypeStamp];
    
}



@end
