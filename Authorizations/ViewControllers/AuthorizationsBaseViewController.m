//
//  AuthorizationsBaseViewController.m
//  Authorizations
//
//  Created by Casey Egan on 3/27/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "AuthorizationsBaseViewController.h"
#import "CustomAchTableViewCell.h"
#import "AuthorizationUIUtilities.h"
#import "AuthorizationService.h"
#import "ALToolbar.h"
#import "Constants.h"

@interface AuthorizationsBaseViewController ()

@end

@implementation AuthorizationsBaseViewController


@synthesize approvalToolbar = _approvalToolbar;


- (void) processSuccessfulApprovals:(NSArray *) successfulApprovals ForType:(NSString *) type{
    
    if(successfulApprovals.count > 0){
        
        [self updateApprovalDateTimeForItems:successfulApprovals];
        [self archiveApprovedItems:successfulApprovals withKey:kAchDataKey];
        
        [UIView animateWithDuration:0.0 delay:0.5f options:nil
         
                         animations:^{
                             
                             [self removeApprovedItems:successfulApprovals];
                         }
         
                         completion:^(BOOL finished){
                             
                             if([type isEqualToString:kNewAchAuthorizationReceipt] ||
                                [type isEqualToString:kNewCheckAuthorizationReceipt] ||
                                [type isEqualToString:kNewWireAuthorizationReceipt]){
                                 
                                 [AuthorizationUIUtilities showModalApprovalSuccessInView:self.view];
                             }
                         }
         ];
    }
    
}

- (void) processApprovalReceiptsForFailedItems:(NSArray *) failedItems{
    
    if(failedItems.count > 0){
        
        [self updateFailedItemsStatus:failedItems];
        
    
        for (ApprovalDetailBase *detail in failedItems){
            
            NSIndexPath *indexPath       = [NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:detail] inSection:0];
            CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            [cell animateCellStatusIndicatorEror];
            
        }
        
        [AuthorizationUIUtilities showModalApprovalErrorInView:self.view];
    }
}

- (void) deleteAuthorizationItems:(NSArray *) itemsToDelete{
    
    NSMutableArray *cellIndicesToBeDeleted  = [[NSMutableArray alloc] init];
    NSArray *items = itemsToDelete;
    
    for (ApprovalDetailBase *detail in items){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:detail] inSection:0];
        [cellIndicesToBeDeleted addObject:indexPath];
    }
    
    [self.authorizationList removeObjectsInArray:items];
    [self.tableView deleteRowsAtIndexPaths:cellIndicesToBeDeleted withRowAnimation:UITableViewRowAnimationRight];
}

- (void) updateItemsStatusIndicatorAnimated:(NSArray *) items{
    
    for (ApprovalDetailBase *detail in items){
        
        NSIndexPath *indexPath       = [NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:detail] inSection:0];
        CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        
        if(detail.isSelected){
            
            cell.isPendingApproval = YES;
            [cell animateCellStatusIndicator:YES];
        }
    }
}

- (void) beginTableViewEdit{
    
    if(!self.isEditing){
        
        self.isEditing = YES;
        
        [self setCancelButton];
        [self animateVisibleCells:self.tableView.visibleCells forEditing:YES];
    }
}

- (void) endTableViewEdit{
    
    if(self.isEditing){
        
        self.isEditing = NO;
        
        [self setEditButton];
        [self animateVisibleCells:self.tableView.visibleCells forEditing:NO];
        [self setItemsSelected:NO];
    }
}

- (void) setEditButton{
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] init];
    
    UIButton *customButtonView  = [UIButton buttonWithType:UIButtonTypeCustom];
    customButtonView.frame      = CGRectMake(0, 0, 55, 30);
    [customButtonView addTarget:self action:@selector(onEditButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [customButtonView setBackgroundImage: [UIImage imageNamed:@"EditBrown@2x.png"] forState:UIControlStateNormal];
    
    [editButton setCustomView:customButtonView];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
}

- (void) setCancelButton{
    
    UIBarButtonItem *placeHolder = [[UIBarButtonItem alloc] init];
    
    UIButton *customButtonView  = [UIButton buttonWithType:UIButtonTypeCustom];
    customButtonView.frame      = CGRectMake(0, 0, 55, 30);
    [customButtonView addTarget:self action:@selector(onEditCancelButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [customButtonView setBackgroundImage: [UIImage imageNamed:@"CancelBrown@2x.png"] forState:UIControlStateNormal];
    
    [placeHolder setCustomView:customButtonView];
    
    self.navigationItem.rightBarButtonItem = placeHolder;
}

- (void) setToolBar{
    
    _approvalToolbar = [[ALToolbar alloc] initWithFrame:CGRectMake(0, 450, 320, 56.5)];
    
    _approvalToolbar.tag = 1;
    [_approvalToolbar setBackgroundImage:@"uitoolbar.png"];
    [_approvalToolbar setBackgroundColor:[UIColor clearColor]];
    [_approvalToolbar setBackgroundContentMode:UIViewContentModeBottom];
    [_approvalToolbar setShowAnimatingDuration:0.3f];
    [_approvalToolbar setHideAnimatingDuration:0.3f];
    [_approvalToolbar setButtonsPadding:123];
    [_approvalToolbar setAnimatingDirection:ALToolbarAnimationDirectionBottom];
    [_approvalToolbar setLayoutMode:ALToolbarButtonsLayoutModeAutoCenterHorizontal];
    
    ALToolbarItem *item1=[[ALToolbarItem alloc]initWithFrame:CGRectMake(75, 5, 75, 55)];
    [item1 setImage:[UIImage imageNamed:@"approveButtonActive2.png"] forState:UIControlStateNormal];
    [item1 setImage:[UIImage imageNamed:@"approveButtonDisabled.png"] forState:UIControlStateDisabled];
    
    [_approvalToolbar setItems:[NSArray arrayWithObjects:item1, nil]];
    
    [self.view addSubview:_approvalToolbar];
}

- (void) setTableViewProperties{
    
    self.tableView.backgroundColor      = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    self.tableView.separatorColor       = BROWN_SEPERATOR_COLOR_HALF_ALPHA;
}

- (void) animateVisibleCells:(NSArray *)visibleCells forEditing:(BOOL) isEditing{
    
    for (CustomAchTableViewCell *cell in visibleCells) {
        
        cell.isEditing = isEditing;
        
        if(isEditing){
            
            [(CustomAchTableViewCell *)cell animateTableCellEditStart];
        }
        else {
            
            [(CustomAchTableViewCell *)cell animateTableCellEditStop];
        }
    }
}

- (void) setItemsSelected:(BOOL)isSelected{
    
    for (AchDetail *detail in self.authorizationList) {
        
        detail.isSelected = isSelected;
    }
}

- (void) archiveApprovedItems:(NSArray *) approvedItems withKey:(NSString *) key{
    
    [ArchiveUtilities archiveApprovedItems:approvedItems withKey:key];
    
}

- (void) updateApprovalDateTimeForItems:(NSArray *) approvedItems{
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    for (ApprovalDetailBase *detail in approvedItems){
        
        detail.isApproved     = YES;
        detail.approvedOnDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:[[NSDate alloc] init]]];
    }
}

- (void) updateFailedItemsStatus:(NSArray *) failedItems{
    
    for (ApprovalDetailBase *detail in failedItems){
        
        detail.isPendingApproval = NO;
        detail.hasApprovalErrors = YES;
    }
}

- (void) updateSelectedItemsToPendingStatus:(NSMutableArray *) items{
    
    for (ApprovalDetailBase *detail in items){
        
        detail.isPendingApproval = YES;
    }
}

- (void) removeApprovedItems:(NSArray *) approvedItems{
    
    NSMutableArray *cellIndicesToBeDeleted  = [[NSMutableArray alloc] init];
    NSArray *itemsToArchive                 = approvedItems;
    
    for (ApprovalDetailBase *detail in itemsToArchive){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:detail] inSection:0];
        [cellIndicesToBeDeleted addObject:indexPath];
    }
    
    [self.authorizationList removeObjectsInArray:itemsToArchive];
    [self.tableView deleteRowsAtIndexPaths:cellIndicesToBeDeleted withRowAnimation:UITableViewRowAnimationRight];
    
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self setEditButton];
    [self setToolBar];
    [self setTableViewProperties];
}

- (int) getTotalNumberOfSelectedItems{
    
    return self.getSelelectedItems.count;
}

- (NSMutableArray *) getSelelectedItems{
    
    NSMutableArray *selectedItems = [[NSMutableArray alloc] init];
    
    for (ApprovalDetailBase *detail in self.authorizationList){
        
        if(detail.isSelected){
            
            [selectedItems addObject:detail];
        }
    }
    
    return selectedItems;
}

- (NSArray *) getItemsToDelete:(NSString *) items{
    
    
    NSMutableArray *itemsToDelete  = [[NSMutableArray alloc] init];
    NSArray *d                     = [items componentsSeparatedByString:@","];
    
    for (NSString *item in d){
        
        NSArray *filtered = [self.authorizationList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"iD == %@", item]];
        
        [itemsToDelete addObjectsFromArray:filtered];
    }
    
    return itemsToDelete;
}

- (NSArray *) getApprovedItems:(NSString *) approvedItems{
    
    
    NSMutableArray *itemsToArchive  = [[NSMutableArray alloc] init];
    NSArray *items                  = [approvedItems componentsSeparatedByString:@","];
    
    for (NSString *item in items){
        
        NSArray *filtered = [self.authorizationList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"iD == %@", item]];
        
        [itemsToArchive addObjectsFromArray:filtered];
        
    }
    
    return itemsToArchive;
}

- (NSArray *) getFailedItems:(NSString *) failedItems{
    
    NSMutableArray *failedItemsList  = [[NSMutableArray alloc] init];
    NSArray *items                   = [failedItems componentsSeparatedByString:@","];
    
    for (NSString *item in items){
        
        NSArray *filtered = [self.authorizationList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"iD == %@", item]];
        
        [failedItemsList addObjectsFromArray:filtered];
        
    }
    
    return failedItemsList;
}


@end
