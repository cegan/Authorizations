//
//  CustomAchTableViewCell.h
//  Authorizations
//
//  Created by Casey Egan on 5/14/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchDetail.h"


@interface CustomAchTableViewCell : UITableViewCell{
    

    
}




@property (nonatomic, weak) IBOutlet UILabel            *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel          *detailsLabel;
@property (nonatomic, weak) IBOutlet UILabel            *amountLabel;
@property (nonatomic, weak) IBOutlet UIImageView        *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UIImageView        *unSelectedAchImageView;
@property (weak, nonatomic) IBOutlet UIImageView        *unviewdIndicator;
@property (weak, nonatomic) IBOutlet UIImageView        *approvalStatusState;

@property (nonatomic, assign)   BOOL                    isSelected;
@property (nonatomic, assign)   BOOL                    isEditing;
@property (nonatomic, assign)   BOOL                    isApproved;
@property (nonatomic, assign)   BOOL                    isPendingApproval;
@property (nonatomic, assign)   BOOL                    hasApprovalErrors;





- (void) bindDetails:(AchDetail *)achDetail inEditingMode:(BOOL)isEditing;
- (void) animateCellStatusIndicatorEror;
- (void) animateCellStatusIndicator:(BOOL)isApproving;
- (void) animateCellUpdateWithDetails:(ApprovalDetailBase *) detail;
- (void) animateTableCellEditStart;
- (void) animateTableCellEditStop;
- (void) setCellsSelectedState:(BOOL)isSelected;


@end
