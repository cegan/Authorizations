//
//  CustomChecksTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 5/15/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "ChecksTableViewCell.h"
#import "StringUtilities.h"
#import "AuthorizationUIUtilities.h"
#import "Constants.h"


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

@implementation ChecksTableViewCell


@synthesize nameLabel                   = _nameLabel;
@synthesize detailsLabel                = _detailsLabel;
@synthesize amountLabel                 = _amountLabel;
@synthesize thumbnailImageView          = _thumbnailImageView;
@synthesize timeStamp                   = _timeStamp;
@synthesize errorIndicator              = _errorIndicator;
@synthesize unSelectedCheckView         = _unSelectedCheckView;
@synthesize isSelected                  = _isSelected;
@synthesize isEditing                   = _isEditing;
@synthesize isApproved                  = _isApproved;
@synthesize hasApprovalErrors           = _hasApprovalErrors;
@synthesize isPendingApproval           = _isPendingApproval;



- (void) layoutSubviews {
    
    _amountLabel.textColor = RED_TEXT_COLOR;
    
    if(_isEditing){
        
        [self setCellToEditingState:YES];
        
    }
    else {
        
        [self setCellToEditingState:NO];
    }
    
    [super layoutSubviews];
}

- (void) animateTableCellEditStart{
    
    [UIView animateWithDuration:0.300 animations:^{
        
        [self setCellToEditingState:YES];
        
    }];
    
    _unSelectedCheckView.hidden = NO;
    [self setCellsSelectedState:NO];
    [self setAccessoryType:UITableViewCellAccessoryNone];
}

- (void) animateTableCellEditStop{
    
    [UIView animateWithDuration:0.300 animations:^{
        
        [self setCellToEditingState:NO];
        
    }];
    
    _unSelectedCheckView.hidden = YES;
    [self setCellsSelectedState:NO];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void) animateCellStatusIndicatorEror{
    
//    self.approvalStatusState.image = [UIImage imageNamed: @"authorizationErrorIndicator.png"];
//    self.approvalStatusState.alpha = 0.0;
//    
//    [UIView animateWithDuration:0.600f delay:0.0f options:nil
//     
//                     animations:^{
//                         
//                         self.approvalStatusState.alpha = 1.0;
//                     }
//     
//                     completion:^(BOOL finished){
//                         
//                         
//                     }
//     ];
    
}

- (void) animateCellUpdateWithDetails:(CheckDetail *) detail{
    
    [self bindDetails:detail inEditingMode:NO];
    
    [UIView animateWithDuration:0.500f delay:0.0f options:nil
     
                     animations:^{
                         
                         [self fadeOutCellContents];
                     }
     
                     completion:^(BOOL finished){
                         
                         [self fadeInCellContents];
                     }
     ];
    
}

- (void) setCellToEditingState:(BOOL) isEditing{
    
    if(isEditing){
        
        _thumbnailImageView.alpha       = 1.0;
        _thumbnailImageView.frame       = CGRectMake(7,25,kApproveCheckboxImageViewWidth,kApproveCheckboxImageViewHeight);
        _timeStamp.frame                = CGRectMake(57,4,kArrivalTimeStampWidth,kArrivalTimeStampHeight);
        _amountLabel.frame              = CGRectMake(232,26,kAmountLabelWidth,kAmountLabelHeight);
        _nameLabel.frame                = CGRectMake(59,28,kNameLabelWidth,kNameLabelHeight);
        _detailsLabel.frame             = CGRectMake(59,51,kDetailLabelWidth,kDetailLabelHeight);
        _thumbnailImageView.hidden      = NO;
        self.accessoryType              = UITableViewCellAccessoryNone;
        
        
    }
    else {
        
        _thumbnailImageView.alpha       = 0.0;
        _thumbnailImageView.frame       = CGRectMake(0,25,kApproveCheckboxImageViewWidth,kApproveCheckboxImageViewHeight);
        _timeStamp.frame                = CGRectMake(33,4,kArrivalTimeStampWidth,kArrivalTimeStampHeight);
        _amountLabel.frame              = CGRectMake(207,26,kAmountLabelWidth,kAmountLabelHeight);
        _nameLabel.frame                = CGRectMake(34,28,kNameLabelWidth,kNameLabelHeight);
        _detailsLabel.frame             = CGRectMake(34,51,kDetailLabelWidth,kDetailLabelHeight);
        _thumbnailImageView.hidden      = YES;
        self.accessoryType              = UITableViewCellAccessoryDisclosureIndicator;
        
        if(_isApproved){
            
            _timeStamp.frame = CGRectMake(33,4,kApprovalTimeStampWidth,kApprovalTimeStampHeight);
        }
        else {
            
            _timeStamp.frame = CGRectMake(33,4,kArrivalTimeStampWidth,kArrivalTimeStampHeight);
        }
    }
}

- (void) setCellsSelectedState:(BOOL)isSelected{
    
    UIImage *image;
    
    if(isSelected){
        
        _isSelected = YES;
        image       = [UIImage imageNamed: @"BrownChecked@2x.png"];
        
        self.backgroundColor = [UIColor colorWithRed:250.00/255.0 green:232.00/255.00 blue:212.00/255.00 alpha:0.2];
        
    }
    else {
        
        _isSelected = NO;
        image       = [UIImage imageNamed: @"BrownUnChecked@2x.png"];
    }
    
    [_unSelectedCheckView setImage:image];
}

- (void) bindDetails:(CheckDetail *)checkDetail inEditingMode:(BOOL)isEditing{
    
    _nameLabel.text                = checkDetail.name;
    _detailsLabel.text             = checkDetail.accountNumber;
    _amountLabel.text              = [StringUtilities formatDoubleAsCurrency:checkDetail.amount];
    _isEditing                     = isEditing;
    _isApproved                    = checkDetail.isApproved;
    _amountLabel.textColor         = RED_TEXT_COLOR;
    
    
    [self showTimeStamp:checkDetail];
    [self setCellsSelectedState:checkDetail.isSelected];
    
}


- (void) showTimeStamp:(CheckDetail *) checkDetail{
    
    [_timeStamp removeFromSuperview];
    
    if(checkDetail.isApproved){
        
        _timeStamp = [AuthorizationUIUtilities getApprovalDateTimeStampForDate:checkDetail.approvedOnDate];
        
    }
    else {
        
        _timeStamp = [AuthorizationUIUtilities getArrivalStampForDate:checkDetail.arrivalDate];
    }
    
    [self addSubview:_timeStamp];
    
}

- (void) removeErrorIndicator{
    
    [_errorIndicator removeFromSuperview];
    
}

- (void) fadeOutCellContents{
    
    _thumbnailImageView.alpha       = 0.0;
    _timeStamp.alpha                = 0.0;
    _amountLabel.alpha              = 0.0;
   // _unviewdIndicator.alpha         = 0.0;
    _nameLabel.alpha                = 0.0;
    _detailsLabel.alpha             = 0.0;
  //  _approvalStatusState.alpha      = 0.0;
    self.accessoryType              = UITableViewCellAccessoryNone;
    
}

- (void) fadeInCellContents{
    
    _thumbnailImageView.alpha       = 1.0;
    _timeStamp.alpha                = 1.0;
    _amountLabel.alpha              = 1.0;
    //_unviewdIndicator.alpha         = 1.0;
    _nameLabel.alpha                = 1.0;
    _detailsLabel.alpha             = 1.0;
  //  _approvalStatusState.alpha      = 1.0;
    self.accessoryType              = UITableViewCellAccessoryNone;
    
}


@end
