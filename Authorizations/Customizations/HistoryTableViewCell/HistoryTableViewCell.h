//
//  HistoryTableViewCell.h
//  Authorizations
//
//  Created by Casey Egan on 2/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringUtilities.h"
#import "AuthorizationUIUtilities.h"
#import "Constants.h"
#import "AchDetail.h"

@interface HistoryTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, assign) BOOL isApproved;


- (void) bindDetails:(ApprovalDetailBase *)approvalDetail;

@end
