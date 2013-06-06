//
//  AchViewController.m
//  Authorizations
//
//  Created by Casey Egan on 5/11/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//


#import "AchViewController.h"


@interface AchViewController()

- (void) setDelegates;
- (void) setNavigationTitle;
- (void) setRefreshControl;
- (void) registerNotifications;
- (void) processApprovals:(NSMutableArray *) itemsToApprove;
- (void) retrieveAchData;
- (void) approveSelectedItems:(NSMutableArray *) itemsToApprove;
- (void) insertNewAchAuthorization:(NSString *) itemstoInsert;
- (void) updateCellAtIndexPath:(NSIndexPath *) indexPath withData:(ApprovalDetailBase *) approval;

@end


@implementation AchViewController


@synthesize tableView           = _tableView;
@synthesize refreshControl      = _refreshControl;
@synthesize editButton          = _editButton;
@synthesize cancelButton        = _cancelButton;
@synthesize isEditing           = _isEditing;
@synthesize authorizationList   = _authorizationList;


- (IBAction) onEditCancelButtonTouch:(id)sender {
    
    [self endTableViewEdit];
}
- (IBAction) onEditButtonTouch:(id)sender {
   
    [self beginTableViewEdit];
}
- (IBAction) showApprovalActionSheet:(id)sender {
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Approve Selected Ach's"];
    
    [sheet addButtonWithTitle:@"Approve" atIndex:0 block:^{
        
        [self processApprovals:[self getSelelectedItems]];
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:self.view];
}



- (void) registerNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLeaveRegion:) name:@"userDidLeaveRegion" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(achApprovalRequested:) name:@"achApprovalRequested" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDeleteNotification:) name:@"didReceiveDeleteNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveUpdateNotification:) name:@"didReceiveUpdateNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewAuthorizationNotification:) name:@"didReceiveNewAuthorizationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthorizationReceiptNotification:) name:@"didReceiveAuthorizationReceiptNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRefreshingAchs:) name:@"didFinishRefreshingAchs" object:nil];
}

- (void) setDelegates{
    
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.approvalToolbar.delegate = self;
}

- (void) setNavigationTitle{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AchNavigationTitleRed.png"]];
}

- (void) setRefreshControl{
    
    self.refreshControl             = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor   = [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0];
    

    self.refreshControl.attributedTitle = [StringUtilities getRefreshControlAttributedStringWithValue:@"Pull To Refresh"];
    
    [_refreshControl addTarget:self action:@selector(handleAchViewRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
}

- (void) userDidLeaveRegion{
    
    if(_authorizationList.count > 0){
        
        [AuthorizationUIUtilities showLocalNotification:@"There are remaining ACH's that still need to be approved" messageAction:@"Pending Ach's"];
    }
}

- (void) didFinishRefreshingAchs:(NSNotification *)notification{
    
    NSData *response = [[notification userInfo] valueForKey:@"didFinishRefreshingAchs"];
    
    self.authorizationList = [ParsingUtilities parseAchAuthorizationResults:response];
    
    [self.tableView reloadData];
    

    [NotificationUtilities sendDataRefreshNotification:kNewIncomingAchAuthorization andCount:self.authorizationList.count];
    
    
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [StringUtilities getRefreshControlAttributedStringWithValue:@"Pull To Refresh"];
}

- (void) didReceiveDeleteNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"deleteAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kAchDelete]){
        
        NSString *itemsToDelete = [newNotification valueForKey:kApprovalIdKey];
        
        [self deleteAuthorizationItems:[self getItemsToDelete:itemsToDelete]];
    }
}

- (void) didReceiveUpdateNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"updateAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kUpdateAchAuthorization]){
        
        NSString *itemToUpdate = [newNotification valueForKey:kApprovalIdKey];
        
        ServiceResponse *response = [[[AuthorizationService alloc] init] getAchAuthorizationById:itemToUpdate];
        
        if(response.wasSuccessful){
            
            ApprovalDetailBase *approvalToUpdate = [_authorizationList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"iD == %@", itemToUpdate]].lastObject;
            
            [self updateCellAtIndexPath:[NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:approvalToUpdate] inSection:0] withData:response.responseData.lastObject];
        }
    }
}

- (void) didReceiveNewAuthorizationNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"NewAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
        
    if([type isEqualToString:kNewIncomingAchAuthorization]){
        
        ServiceResponse *serviceResponse = [[[AuthorizationService alloc] init] getAchAuthorizationById:[newNotification valueForKey:kApprovalIdKey]];
        
        [self insertNewAchAuthorization:[serviceResponse.responseData objectAtIndex:0]];
    }
}

- (void) didReceiveAuthorizationReceiptNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"authorizationReceipt"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    
    if([type isEqualToString:kNewAchAuthorizationReceipt] || [type isEqualToString:kNewAchAuthorizationSilentReceipt]){
        
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

- (void) insertNewAchAuthorization:(ApprovalDetailBase *) itemToInsert{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];

    [tempArray addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    [_authorizationList insertObject:itemToInsert atIndex:0];
    
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

- (void) retrieveAchData{
    
    [[[AuthorizationService alloc] init] getAchAuthorizationsAsyncWithCallBack:@"didFinishRefreshingAchs"];
}

- (void) achApprovalRequested:(NSNotification *)notification{
    

    if([NetworkUtilities hasConnection]){
        
        NSMutableArray *item = [[NSMutableArray alloc] initWithObjects:(AchDetail *)[[notification userInfo] valueForKey:@"detail"], nil];
        [self processApprovals:item];
    }
    else{
        
        [AuthorizationUIUtilities showModalNetworkError:kNoInternetConnection InView:self.view];
        return;
    }    
}

- (void) handleAchViewRefresh:(UIRefreshControl *)sender{
    
    
    if([NetworkUtilities hasConnection]){
        
        self.refreshControl.attributedTitle = [StringUtilities getRefreshControlAttributedStringWithValue:@"Refreshing Ach's"];
        [self reloadTableData];
    }
    else{
        
        [AuthorizationUIUtilities showModalNetworkError:kNoInternetConnection InView:self.view];
        [self.refreshControl endRefreshing];
        return;
    }

}

- (void) reloadTableData{
    
    [self retrieveAchData];
 }

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    [self setDelegates];
    [self setRefreshControl];
    [self setNavigationTitle];
    [self setTableViewProperties];
    [self registerNotifications];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    if(!self.authorizationList){
        
        NSData *responseData   = [[[AuthorizationService alloc] init] getAchAuthorizationsAsAsync:NO withCallBack:nil];
        self.authorizationList = [ParsingUtilities parseAchAuthorizationResults:responseData];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self endTableViewEdit];
}

- (void) viewDidUnload {
    
    [self setTableView:nil];
    [super viewDidUnload];
}



- (void) approveSelectedItems:(NSMutableArray *) itemsToApprove{
    
    [[[AuthorizationService alloc] init] authorizeAch:itemsToApprove AsAsync:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AchDetail *achDetail         = [self.authorizationList objectAtIndex:indexPath.row];
    CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if(!achDetail.hasBeenViewed){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kAuthorizationItemSelected object:nil userInfo:[NSDictionary dictionaryWithObject:@"Ach" forKey:@"authorizationType"]];
        
        achDetail.hasBeenViewed      = YES;
        cell.unviewdIndicator.hidden = YES;
    }
    
    
    if(self.isEditing){
        
        achDetail.hasBeenViewed = NO;
        
        if(cell.isSelected){
            
            achDetail.isSelected = NO;
            [cell setCellsSelectedState:NO];
        }
        else {
            
            achDetail.isSelected = YES;
            [cell setCellsSelectedState:YES];
        }
    }
    else {
        
        AchDetailViewController *achDetailViewController = [[[NSBundle mainBundle] loadNibNamed:@"AchDetailViewController" owner:self options:nil] objectAtIndex:0];
        
        achDetailViewController.detail = achDetail;
        
        [self.navigationController pushViewController:achDetailViewController animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.authorizationList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kTableRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kAchCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomAchTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell bindDetails:[self.authorizationList objectAtIndex:indexPath.row] inEditingMode:self.isEditing];
    
    
    return cell;
}


@end
