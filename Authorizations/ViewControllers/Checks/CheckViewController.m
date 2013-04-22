//
//  CheckViewController.m
//  Authorizations
//
//  Created by Casey Egan on 5/11/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "ArchiveUtilities.h"
#import "CalendarUtilities.h"
#import "ChecksTableViewCell.h"
#import "CheckViewController.h"
#import "ALToolbar.h"
#import "CheckDetail.h"
#import "AuthorizationUIUtilities.h"
#import "NetworkUtilities.h"
#import "NotificationUtilities.h"
#import "CheckDetailViewController.h"
#import "AuthorizationService.h"
#import "BadgeUpdater.h"
#import "Constants.h"
#import "Enums.h"
#import "CustomAchTableViewCell.h"
#import "BlockActionSheet.h"

@interface CheckViewController()

- (void) setDelegates;
- (void) setPullToRefresh;
- (void) setNavigationTitle;
- (void) registerNotifications;
- (void) processApprovals:(NSMutableArray *) itemsToApprove;
- (void) retrieveCheckData;
- (void) approveSelectedItems:(NSMutableArray *) itemsToApprove;
- (void) insertNewCheckAuthorization:(NSString *) itemstoInsert;
- (void) updateCellAtIndexPath:(NSIndexPath *) indexPath withData:(ApprovalDetailBase *) approval;

@end

@implementation CheckViewController



@synthesize tableView           = _tableView;
@synthesize editButton          = _editButton;
@synthesize cancelButton        = _cancelButton;
@synthesize pullToRefresh       = _pullToRefresh;
@synthesize isEditing           = _isEditing;
@synthesize authorizationList   = _authorizationList;



- (IBAction) onEditCancelButtonTouch:(id)sender {
    
    [self endTableViewEdit];
}

- (IBAction) onEditButtonTouch:(id)sender {
    
    [self beginTableViewEdit];
}

- (IBAction) showApprovalActionSheet:(id)sender {
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Approve Selected Checks"];
    
    [sheet addButtonWithTitle:@"Approve" atIndex:0 block:^{
        
        [self processApprovals:[self getSelelectedItems]];
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:self.view];
}


- (void) setNavigationTitle{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChecksRed.png"]];
}

- (void) setPullToRefresh{
    
    self.pullToRefresh = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.tableView];
    self.pullToRefresh.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:self.pullToRefresh];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ApprovalDetailBase *checkDetail         = [self.authorizationList objectAtIndex:indexPath.row];
    CustomAchTableViewCell *cell               = (CustomAchTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if(!checkDetail.hasBeenViewed){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kAuthorizationItemSelected object:nil userInfo:[NSDictionary dictionaryWithObject:@"Check" forKey:@"authorizationType"]];
        
        checkDetail.hasBeenViewed      = YES;
    }
    
    
    
    if(self.isEditing){
        
        checkDetail.hasBeenViewed = NO;
        
        if(cell.isSelected){
            
            checkDetail.isSelected = NO;
            [cell setCellsSelectedState:NO];
        }
        else {
            
            checkDetail.isSelected = YES;
            [cell setCellsSelectedState:YES];
        }
    }
    else {
        
        CheckDetailViewController *checkDetailViewController = [[[NSBundle mainBundle] loadNibNamed:@"CheckDetailViewController" owner:self options:nil] objectAtIndex:0];
        
        checkDetailViewController.detail = checkDetail;
        
        [self.navigationController pushViewController:checkDetailViewController animated:YES];
    }
}

- (void) setDelegates{
    
    self.pullToRefresh.delegate = self;
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.approvalToolbar.delegate = self;
}

- (void) registerNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkApprovalRequested:) name:@"checkApprovalRequested" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDeleteNotification:) name:@"didReceiveDeleteNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveUpdateNotification:) name:@"didReceiveUpdateNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewAuthorizationNotification:) name:@"didReceiveNewAuthorizationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthorizationReceiptNotification:) name:@"didReceiveAuthorizationReceiptNotification" object:nil];
}

- (void) didReceiveDeleteNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"deleteAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kCheckDelete]){
        
        NSString *itemsToDelete = [newNotification valueForKey:kApprovalIdKey];
        
        [self deleteAuthorizationItems:[self getItemsToDelete:itemsToDelete]];
    }
    
}

- (void) didReceiveUpdateNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"updateAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kUpdateCheckAuthorization]){
        
        NSString *itemToUpdate = [newNotification valueForKey:kApprovalIdKey];
        
        ServiceResponse *response = [[[AuthorizationService alloc] init] getCheckAuthorizationById:itemToUpdate];
        
        if(response.wasSuccessful){
            
            ApprovalDetailBase *approvalToUpdate = [_authorizationList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"iD == %@", itemToUpdate]].lastObject;
            
            [self updateCellAtIndexPath:[NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:approvalToUpdate] inSection:0] withData:response.responseData.lastObject];
        }
    }
}

- (void) didReceiveNewAuthorizationNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"NewAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kNewIncomingCheckAuthorization]){
        
        [BadgeUpdater incrementBadgeValueForMenuItem:kNewIncomingCheckAuthorization];
        
        [self insertNewCheckAuthorization:[newNotification valueForKey:kApprovalIdKey]];
    }
}

- (void) didReceiveAuthorizationReceiptNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"authorizationReceipt"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kNewCheckAuthorizationReceipt]){
        
        NSArray *approvedItemsList = [self getApprovedItems:[newNotification valueForKey:kApprovalIdKey]];
        NSArray *failedItemsList   = [self getFailedItems:[newNotification valueForKey:kFailedIdKey]];
        
        [self processSuccessfulApprovals:approvedItemsList ForType:type];
        [self processApprovalReceiptsForFailedItems:failedItemsList];
    }
}

- (void) toolbar:(ALToolbar *)toolbar didSelectButtonAtIndex:(NSInteger)index{
    
    if(self.isEditing){
        
        if([self getTotalNumberOfSelectedItems] > 0){
            
            if([NetworkUtilities hasConnection]){
                
                if(![NetworkUtilities isRemoteHostReachable]){
                    
                    [AuthorizationUIUtilities showModalNetworkError:kAuthorizationServiceNotReachable InView:self.view];
                    return;
                }
            }
            else{
                
                [AuthorizationUIUtilities showModalNetworkError:kNoInternetConnection InView:self.view];
                return;
            }
            
            
            [self showApprovalActionSheet:self];
        }
    }
}

- (void) insertNewCheckAuthorization:(NSString *) itemToInsert{
    

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    ServiceResponse *serviceResponse = [[[AuthorizationService alloc] init] getCheckAuthorizationById:itemToInsert];
    [tempArray addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    [_authorizationList insertObject:[serviceResponse.responseData objectAtIndex:0] atIndex:0];
    
    [[self tableView] beginUpdates];
    [[self tableView] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationLeft];
    [[self tableView] endUpdates];
    
}

- (void) updateCellAtIndexPath:(NSIndexPath *) indexPath withData:(ApprovalDetailBase *) updatedApproval{
    
    CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    [cell animateCellUpdateWithDetails:updatedApproval];
    [_authorizationList replaceObjectAtIndex:indexPath.row withObject:updatedApproval];
}

- (void) processApprovals:(NSMutableArray *) itemsToApprove{
    
    [self updateSelectedItemsToPendingStatus:itemsToApprove];
    [self updateItemsStatusIndicatorAnimated:itemsToApprove];
    [self approveSelectedItems:itemsToApprove];
    [self endTableViewEdit];
}

- (void) retrieveCheckData{
    
    ServiceResponse *serviceResponse = [[[AuthorizationService alloc] init] getCheckAuthorizations];
    
    
    if(serviceResponse.wasSuccessful){
        
        self.authorizationList = serviceResponse.responseData;
        [NotificationUtilities sendDataRefreshNotification:kNewIncomingCheckAuthorization andCount:self.authorizationList.count];
    }
    else{
        
        //display error?
    }
}

- (void) checkApprovalRequested:(NSNotification *)notification{
    
    if([NetworkUtilities hasConnection]){
        
        if(![NetworkUtilities isRemoteHostReachable]){
            
            [AuthorizationUIUtilities showModalNetworkError:kAuthorizationServiceNotReachable InView:self.view];
            [self.pullToRefresh finishedLoading];
            return;
        }
    }
    else{
        
        [AuthorizationUIUtilities showModalNetworkError:kNoInternetConnection InView:self.view];
        [self.pullToRefresh finishedLoading];
        return;
    }
    
    
    NSMutableArray *item = [[NSMutableArray alloc] initWithObjects:(AchDetail *)[[notification userInfo] valueForKey:@"detail"], nil];
    
    [self processApprovals:item];
}

- (void) pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;{
    
    if([NetworkUtilities hasConnection]){
        
        if(![NetworkUtilities isRemoteHostReachable]){
            
            [AuthorizationUIUtilities showModalNetworkError:kAuthorizationServiceNotReachable InView:self.view];
            [self.pullToRefresh finishedLoading];
            return;
        }
    }
    else{
        
        [AuthorizationUIUtilities showModalNetworkError:kNoInternetConnection InView:self.view];
        [self.pullToRefresh finishedLoading];
        return;
    }
    
    
    [self reloadTableData];
    
}

- (void) reloadTableData{
    
    [self retrieveCheckData];
    [self.tableView reloadData];
    [self.pullToRefresh finishedLoading];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveManualRefreshtNotification"
                                                        object:nil
                                                      userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%i", self.authorizationList.count] forKey:@"count"]];
    
    
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    [self setPullToRefresh];
    [self setNavigationTitle];
    [self setTableViewProperties];
    [self registerNotifications];
    [self setDelegates];
    [self retrieveCheckData];
}

- (void) viewDidUnload {
    
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    
    
    
}

- (void) approveSelectedItems:(NSMutableArray *) itemsToApprove{
    
    [[[AuthorizationService alloc] init] authorizeCheck:itemsToApprove AsAsync:YES];
}

- (NSArray *) getErrorItems:(NSNotification *) notification{
    
    
    NSMutableArray *failedItems  = [[NSMutableArray alloc] init];
    NSArray *items               = [[[notification userInfo] valueForKey:@"failedItems"] componentsSeparatedByString:@","];
    
    for (NSString *item in items){
        
        for (ApprovalDetailBase *detail in self.authorizationList){
            
            if(item == detail.iD){
                
                detail.isApproved = NO;
                detail.hasApprovalErrors = YES;
                [failedItems addObject:detail];
            }
        }
    }
    
    return failedItems;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.authorizationList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kTableRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"CheckCellIdentifier";
    
     CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomAchTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell bindDetails:[self.authorizationList objectAtIndex:indexPath.row] inEditingMode:self.isEditing];
    
    
    return cell;
}


@end
