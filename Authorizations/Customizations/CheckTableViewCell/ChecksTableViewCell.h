//
//  CustomChecksTableViewCell.h
//  Authorizations
//
//  Created by Casey Egan on 5/15/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckDetail.h"

@interface ChecksTableViewCell : UITableViewCell

@property (nonatomic, weak)     IBOutlet UILabel        *nameLabel;
@property (strong, nonatomic)   IBOutlet UILabel        *detailsLabel;

@property (nonatomic, weak)     IBOutlet UILabel        *amountLabel;
@property (nonatomic, weak)     IBOutlet UIImageView    *thumbnailImageView;
@property (nonatomic, weak)     IBOutlet UIImageView    *unSelectedCheckView;
@property (nonatomic, weak)     UIImageView             *timeStamp;
@property (nonatomic, strong)   UIImageView             *errorIndicator;

@property (nonatomic, assign)   BOOL                  isSelected;
@property (nonatomic, assign)   BOOL                  isEditing;
@property (nonatomic, assign)   BOOL                  isApproved;
@property (nonatomic, assign)   BOOL                  isPendingApproval;
@property (nonatomic, assign)   BOOL                  hasApprovalErrors;


- (void) bindDetails:(CheckDetail *)achDetail inEditingMode:(BOOL)isEditing;
- (void) animateCellStatusIndicatorEror;
- (void) animateTableCellEditStart;
- (void) animateTableCellEditStop;
- (void) animateCellStatusIndicator:(BOOL)isApproving;
- (void) animateCellUpdateWithDetails:(ApprovalDetailBase *) detail;
- (void) setCellsSelectedState:(BOOL)isSelected;
- (void) removeErrorIndicator;
- (void) fadeOutCellContents;
- (void) fadeInCellContents;

@end
