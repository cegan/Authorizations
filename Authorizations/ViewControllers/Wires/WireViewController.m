//
//  WireViewController.m
//  Authorizations
//
//  Created by Casey Egan on 5/11/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//


#import "WireViewController.h"


@interface WireViewController()


- (void) setDelegates;
- (void) setRefreshControl;
- (void) setNavigationTitle;
- (void) registerNotifications;
- (void) processApprovals:(NSMutableArray *) itemsToApprove;
- (void) retrieveWireData;
- (void) approveSelectedItems:(NSMutableArray *) itemsToApprove;
- (void) insertNewWireAuthorization:(NSString *) itemstoInsert;
- (void) updateCellAtIndexPath:(NSIndexPath *) indexPath withData:(ApprovalDetailBase *) approval;

@end




@implementation WireViewController


@synthesize tableView           = _tableView;
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
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Approve Selected Wires"];
    
    [sheet addButtonWithTitle:@"Approve" atIndex:0 block:^{
        
        [self processApprovals:[self getSelelectedItems]];
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:self.view];
}


- (void) setNavigationTitle{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WiresRed.png"]];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AchDetail *achDetail         = [self.authorizationList objectAtIndex:indexPath.row];
    CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if(!achDetail.hasBeenViewed){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kAuthorizationItemSelected object:nil userInfo:[NSDictionary dictionaryWithObject:@"Check" forKey:@"authorizationType"]];
        
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
        
        WireDetailViewController *wireDetailViewController = [[[NSBundle mainBundle] loadNibNamed:@"WireDetailViewController" owner:self options:nil] objectAtIndex:0];
        
        wireDetailViewController.detail = achDetail;
        
        [self.navigationController pushViewController:wireDetailViewController animated:YES];
    }
}

- (void) setDelegates{
    
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.approvalToolbar.delegate = self;
}

- (void) setRefreshControl{
    
    self.refreshControl             = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor   = [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0];
    
    
    self.refreshControl.attributedTitle = [StringUtilities getRefreshControlAttributedStringWithValue:@"Pull To Refresh"];
    
    [self.refreshControl addTarget:self action:@selector(handleWireViewRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
}

- (void) registerNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wireApprovalRequested:) name:@"wireApprovalRequested" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDeleteNotification:) name:@"didReceiveDeleteNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveUpdateNotification:) name:@"didReceiveUpdateNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewAuthorizationNotification:) name:@"didReceiveNewAuthorizationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthorizationReceiptNotification:) name:@"didReceiveAuthorizationReceiptNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRefreshingWires:) name:@"didFinishRefreshingWires" object:nil];
}


- (void) didFinishRefreshingWires:(NSNotification *)notification{
    
    NSData *response = [[notification userInfo] valueForKey:@"didFinishRefreshingWires"];
    
    self.authorizationList = [ParsingUtilities parseWireAuthorizationResults:response];
    
    [self.tableView reloadData];
    
    
    [NotificationUtilities sendDataRefreshNotification:kNewIncomingWireAuthorization andCount:self.authorizationList.count];
    
    
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [StringUtilities getRefreshControlAttributedStringWithValue:@"Pull To Refresh"];
}

- (void) didReceiveDeleteNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"deleteAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kWireDelete]){
        
        NSString *itemsToDelete = [newNotification valueForKey:kApprovalIdKey];
        
        [self deleteAuthorizationItems:[self getItemsToDelete:itemsToDelete]];
    }
    
}

- (void) didReceiveUpdateNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"updateAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kUpdateWireAuthorization]){
        
        NSString *itemToUpdate = [newNotification valueForKey:kApprovalIdKey];
        
        ServiceResponse *response = [[[AuthorizationService alloc] init] getWireAuthorizationById:itemToUpdate];
        
        if(response.wasSuccessful){
            
            ApprovalDetailBase *approvalToUpdate = [_authorizationList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"iD == %@", itemToUpdate]].lastObject;
            
            [self updateCellAtIndexPath:[NSIndexPath indexPathForRow:[self.authorizationList indexOfObject:approvalToUpdate] inSection:0] withData:response.responseData.lastObject];
        }
    }
}

- (void) didReceiveNewAuthorizationNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"NewAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kNewIncomingWireAuthorization]){
        
        [BadgeUpdater incrementBadgeValueForMenuItem:kNewIncomingWireAuthorization];
        
        [self insertNewWireAuthorization:[newNotification valueForKey:kApprovalIdKey]];
    }
}

- (void) didReceiveAuthorizationReceiptNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"authorizationReceipt"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kNewWireAuthorizationReceipt]){
        
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

- (void) insertNewWireAuthorization:(NSString *) itemToInsert{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    ServiceResponse *serviceResponse = [[[AuthorizationService alloc] init] getWireAuthorizationById:itemToInsert];
    
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

- (void) retrieveWireData{
    
    [[[AuthorizationService alloc] init] getWireAuthorizationsAsyncWithCallback:@"didFinishRefreshingWires"];
}

- (void) wireApprovalRequested:(NSNotification *)notification{
    
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
    
    
    NSMutableArray *item = [[NSMutableArray alloc] initWithObjects:(AchDetail *)[[notification userInfo] valueForKey:@"detail"], nil];
    
    [self processApprovals:item];
}

- (void) handleWireViewRefresh:(UIRefreshControl *)sender{
    
    
    if([NetworkUtilities hasConnection]){
        
        self.refreshControl.attributedTitle = [StringUtilities getRefreshControlAttributedStringWithValue:@"Refreshing Wires"];
        [self retrieveWireData];
    }
    else{
        
        [AuthorizationUIUtilities showModalNetworkError:kNoInternetConnection InView:self.view];
        return;
    }
    
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    [self setNavigationTitle];
    [self setRefreshControl];
    [self setTableViewProperties];
    [self registerNotifications];
    [self setDelegates];
    [self retrieveWireData];
}

- (void) viewDidUnload {
    
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    
    if(!self.authorizationList){
        
        [self retrieveWireData];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self endTableViewEdit];
}

- (void) approveSelectedItems:(NSMutableArray *) itemsToApprove{
    
    [[[AuthorizationService alloc] init] authorizeWire:itemsToApprove AsAsync:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.authorizationList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kTableRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CustomAchTableViewCell *cell = (CustomAchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kWireCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomAchTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell bindDetails:[self.authorizationList objectAtIndex:indexPath.row] inEditingMode:self.isEditing];
    
    return cell;
}

@end
