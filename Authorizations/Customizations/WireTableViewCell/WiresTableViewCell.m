//
//  CustomWiresTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 5/15/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "WiresTableViewCell.h"

#define kAmountLabelWidth                   81.0
#define kAmountLabelHeight                  21.0
#define kNameLabelWidth                     193.0
#define kNameLabelHeight                    20.0
#define kDetailLabelWidth                   203.0
#define kDetailLabelHeight                  21.0
#define kApproveCheckboxImageViewWidth      25.0
#define kApproveCheckboxImageViewHeight     25.0
#define kArrivalTimeStampWidth              50.0
#define kArrivalTimeStampHeight             22.0

@implementation WiresTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
