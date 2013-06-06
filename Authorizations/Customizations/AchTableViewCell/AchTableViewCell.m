//
//  CustomAchTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 5/14/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomAchTableViewCell.h"
#import "StringUtilities.h"
#import "AuthorizationUIUtilities.h"
#import "CustomColoredAccessory.h"
#import "Constants.h"

@interface CustomAchTableViewCell()

- (void) showTimeStamp:(AchDetail *) achDetail;
- (void) showErrorIndicator:(BOOL) hasErrors;
- (void) showHasBeenViewedIndicator:(BOOL) hasBeenViewed;

@end


#define kAmountLabelWidth                   81.0
#define kAmountLabelHeight                  21.0
#define kNameLabelWidth                     193.0
#define kNameLabelHeight                    20.0
#define kDetailLabelWidth                   203.0
#define kDetailLabelHeight                  21.0
#define kApproveCheckboxImageViewWidth      25.0
#define kApproveCheckboxImageViewHeight     25.0




 
@implementation CustomAchTableViewCell


@synthesize nameLabel                   = _nameLabel;
@synthesize detailsLabel                = _detailsLabel;
@synthesize amountLabel                 = _amountLabel;
@synthesize thumbnailImageView          = _thumbnailImageView;
@synthesize unSelectedAchImageView      = _unSelectedAchImageView;
@synthesize isSelected                  = _isSelected;
@synthesize isEditing                   = _isEditing;
@synthesize isApproved                  = _isApproved;
@synthesize isPendingApproval           = _isPendingApproval;
@synthesize hasApprovalErrors           = _hasApprovalErrors;
@synthesize unviewdIndicator            = _unviewdIndicator;
@synthesize approvalStatusState         = _approvalStatusState;



- (void) layoutSubviews {
    
    if(_isEditing){
        
        [self setCellToEditingState:YES];
        
    }
    else {
        
        [self setCellToEditingState:NO];
    }
    
    [super layoutSubviews];
}

- (void) showHasBeenViewedIndicator:(BOOL) hasBeenViewed{
    
    _unviewdIndicator.hidden = hasBeenViewed;
}

- (void) showPendingStatusIndicator:(BOOL) isPendingApproval{
    
    if(isPendingApproval){
        
        self.approvalStatusState.image = [UIImage imageNamed: @"cloud.png"];
    }
}

- (void) animateCellStatusIndicator:(BOOL)isApproving{
    
    self.approvalStatusState.image = [UIImage imageNamed: @"cloud.png"];
    self.approvalStatusState.alpha = 0.0;

    [UIView animateWithDuration:0.600f delay:0.0f options:nil
         
            animations:^{
                
                
                self.approvalStatusState.alpha = 1.0;
            }
         
            completion:^(BOOL finished){
                             
                                                          
            }
    ];
    
}

- (void) animateCellStatusIndicatorEror{
    
    self.approvalStatusState.image = [UIImage imageNamed: @"authorizationErrorIndicator.png"];
    self.approvalStatusState.alpha = 0.0;
    
    [UIView animateWithDuration:0.600f delay:0.0f options:nil
     
                     animations:^{
                         
                         self.approvalStatusState.alpha = 1.0;
                     }
     
                     completion:^(BOOL finished){
                         
                         
                     }
     ];
    
}

- (void) animateCellUpdateWithDetails:(AchDetail *) detail{
    
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

- (void) animateTableCellEditStart{
    
    [UIView animateWithDuration:0.300 animations:^{
        
        [self setCellToEditingState:YES];
        
    }];
    
    _thumbnailImageView.hidden = NO;
    [self setCellsSelectedState:NO];
    [self setAccessoryType:UITableViewCellAccessoryNone];
}

- (void) animateTableCellEditStop{
    
    [UIView animateWithDuration:0.300 animations:^{
        
        [self setCellToEditingState:NO];
       
    }];
    
    _thumbnailImageView.hidden = YES;
    [self setCellsSelectedState:NO];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void) setCellToEditingState:(BOOL) isEditing{
    
    
    if(isEditing){
        
        UIImageView *timeStamp          = (UIImageView*)[self viewWithTag:100];
        
        timeStamp.frame                 = CGRectMake(57,6,timeStamp.frame.size.width,timeStamp.frame.size.height);
        
        _thumbnailImageView.alpha       = 1.0;
        _thumbnailImageView.frame       = CGRectMake(7,25,kApproveCheckboxImageViewWidth,kApproveCheckboxImageViewHeight);
        _amountLabel.frame              = CGRectMake(232,26,kAmountLabelWidth,kAmountLabelHeight);
        _unviewdIndicator.frame         = CGRectMake(47,36,6,6);
        _nameLabel.frame                = CGRectMake(59,28,kNameLabelWidth,kNameLabelHeight);
        _detailsLabel.frame             = CGRectMake(59,51,kDetailLabelWidth,kDetailLabelHeight);
        _thumbnailImageView.hidden      = NO;
        self.accessoryView.frame        = CGRectMake(350,26,self.accessoryView.frame.size.width,self.accessoryView.frame.size.height);
       
    }
    else {
        
        
        UIImageView *timeStamp          = (UIImageView*)[self viewWithTag:100];
        
        timeStamp.frame                = CGRectMake(33,6,timeStamp.frame.size.width,timeStamp.frame.size.height);
        
        _thumbnailImageView.alpha       = 0.0;
        _thumbnailImageView.frame       = CGRectMake(0,25,kApproveCheckboxImageViewWidth,kApproveCheckboxImageViewHeight);
        _amountLabel.frame              = CGRectMake(207,26,kAmountLabelWidth,kAmountLabelHeight);
        _unviewdIndicator.frame         = CGRectMake(22,36,6,6);
        _nameLabel.frame                = CGRectMake(34,28,kNameLabelWidth,kNameLabelHeight);
        _detailsLabel.frame             = CGRectMake(34,51,kDetailLabelWidth,kDetailLabelHeight);
        _thumbnailImageView.hidden      = YES;
        
        self.accessoryView.frame = CGRectMake(150,26,self.accessoryView.frame.size.width,self.accessoryView.frame.size.height);
    }
}

- (void) setCellsSelectedState:(BOOL)isSelected{
    
    UIImage *image;
    
    _isSelected = isSelected;
    
    if(isSelected){
        
        image = [UIImage imageNamed: @"BrownChecked@2x.png"];
    }
    else {

        image = [UIImage imageNamed: @"BrownUnChecked@2x.png"];
    }
    
    [_thumbnailImageView setImage:image];
}

- (void) bindDetails:(AchDetail *)achDetail inEditingMode:(BOOL)isEditing{
    
    _nameLabel.text                = achDetail.name;
    _detailsLabel.text             = achDetail.accountNumber;
    _amountLabel.text              = [StringUtilities formatDoubleAsCurrency:achDetail.amount];
    _isEditing                     = isEditing;
    _amountLabel.textColor         = RED_TEXT_COLOR;
    
    [self showPendingStatusIndicator:achDetail.isPendingApproval];
    [self showHasBeenViewedIndicator:achDetail.hasBeenViewed];
    [self showErrorIndicator:achDetail.hasApprovalErrors];
    [self showTimeStamp:achDetail];
    [self setCellsSelectedState:achDetail.isSelected];
        
    self.accessoryView = [CustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0]];
}

- (void) showTimeStamp:(AchDetail *) achDetail{
    
    [self addSubview:[AuthorizationUIUtilities getArrivalStampForDate:achDetail.arrivalDate]];
}

- (void) showErrorIndicator:(BOOL) shouldShowErrorIndicator{
    
    if(shouldShowErrorIndicator){
        
        self.approvalStatusState.image = [UIImage imageNamed: @"authorizationErrorIndicator.pnf"];
        self.approvalStatusState.alpha = 1.0;
        
    }
}

- (void) fadeOutCellContents{
    
    UIImageView *timeStamp          = (UIImageView*)[self viewWithTag:100];
    timeStamp.alpha                 = 0.0;
    
    _thumbnailImageView.alpha       = 0.0;
    _amountLabel.alpha              = 0.0;
    _unviewdIndicator.alpha         = 0.0;
    _nameLabel.alpha                = 0.0;
    _detailsLabel.alpha             = 0.0;
    _approvalStatusState.alpha      = 0.0;
    self.accessoryType              = UITableViewCellAccessoryNone;
    
}

- (void) fadeInCellContents{
    
    UIImageView *timeStamp          = (UIImageView*)[self viewWithTag:100];
    timeStamp.alpha                 = 1.0;
    
    _thumbnailImageView.alpha       = 1.0;
    _amountLabel.alpha              = 1.0;
    _unviewdIndicator.alpha         = 1.0;
    _nameLabel.alpha                = 1.0;
    _detailsLabel.alpha             = 1.0;
    _approvalStatusState.alpha      = 1.0;
    self.accessoryType              = UITableViewCellAccessoryNone;
    
}



@end
