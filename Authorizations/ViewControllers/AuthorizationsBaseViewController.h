//
//  AuthorizationsBaseViewController.h
//  Authorizations
//
//  Created by Casey Egan on 3/27/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALToolbar.h"
#import "Reachability.h"
#import "ArchiveUtilities.h"
#import "AchDetail.h"

@interface AuthorizationsBaseViewController : UIViewController 

@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (nonatomic, retain) UITableView *tableView;
@property (weak, nonatomic) UIBarButtonItem *cancelButton;
@property (weak, nonatomic) UIBarButtonItem *editButton;
@property (nonatomic,retain) ALToolbar *approvalToolbar;
@property (nonatomic, assign) BOOL isEditing;

@property (nonatomic, retain) NSMutableArray *authorizationList;

- (void) setEditButton;
- (void) setCancelButton;
- (void) setToolBar;
- (void) beginTableViewEdit;
- (void) endTableViewEdit;
- (void) setItemsSelected:(BOOL)isSelected;
- (void) setTableViewProperties;
- (void) removeApprovedItems:(NSArray *) approvedItems;

- (void) animateVisibleCells:(NSArray *)visibleCells forEditing:(BOOL) isEditing;
- (void) archiveApprovedItems:(NSArray *) approvedItems withKey:(NSString *) key;
- (void) updateApprovalDateTimeForItems:(NSArray *) approvedItems;
- (void) updateFailedItemsStatus:(NSArray *) failedItems;
- (void) updateSelectedItemsToPendingStatus:(NSMutableArray *) items;
- (void) updateItemsStatusIndicatorAnimated:(NSArray *) items;
- (void) deleteAuthorizationItems:(NSArray *) itemsToDelete;
- (void) processSuccessfulApprovals:(NSArray *) successfulApprovals ForType:(NSString *) type;
- (void) processApprovalReceiptsForFailedItems:(NSArray *) failedItems;


- (int) getTotalNumberOfSelectedItems;
- (NSMutableArray *) getSelelectedItems;
- (NSArray *) getItemsToDelete:(NSString *) items;
- (NSArray *) getApprovedItems:(NSString *) approvedItems;
- (NSArray *) getFailedItems:(NSString *) failedItems;



@end
