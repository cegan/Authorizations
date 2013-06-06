//
//  HistoryViewController.m
//  Authorizations
//
//  Created by Casey Egan on 2/2/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "HistoryViewController.h"


@interface HistoryViewController ()

- (void) registerNotifications;
- (void) setTableViewProperties;
- (void) installToolBar;
- (void) setDelegates;
- (void) setDeleteButton;
- (void) initializeHistoryData;
- (void) reloadHistoryTable;
- (void) setHistorySearch;
- (void) enableHistoryControls:(BOOL) enabled;
- (void) displaySortingControl;
- (void) removeSortingControl;

@end

@implementation HistoryViewController

@synthesize results                 = _results;
@synthesize historyTable            = _historyTable;
@synthesize historySearch           = _historySearch;
@synthesize historyToolbar          = _historyToolbar;
@synthesize refreshControl          = _refreshControl;
@synthesize sortToolbarItem         = _sortToolbarItem;
@synthesize sortingControl          = _sortingControl;
@synthesize isSortingVisible        = _isSortingVisible;
@synthesize isKeyboardVisible       = _isKeyboardVisible;
@synthesize tapGesture              = _tapGesture;


- (IBAction) onDeleteButtonTouch:(id)sender {
    
    if([self isSortingVisible]){
        
        [self removeSortingControl];
    }
    if([self isKeyboardVisible]){
        
        [self.historySearch resignFirstResponder];
    }
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Delete History"];
    
    [sheet addButtonWithTitle:@"Delete" atIndex:0 block:^{
        
        [ArchiveUtilities deleteAllArchivedApprovals];
        _results = nil;
        [_historyTable reloadData];
        
        [self enableHistoryControls:NO];
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:self.view];
    
}


- (void) registerNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthorizationReceiptNotification:) name:@"didReceiveAuthorizationReceiptNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRefreshingAchHistory:) name:@"didFinishRefreshingAchHistory" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRefreshingCheckHistory:) name:@"didFinishRefreshingCheckHistory" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRefreshingWireHistory:) name:@"didFinishRefreshingWireHistory" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSorting:) name:@"didReceiveSorting" object:nil];
}

- (void) didReceiveSorting:(NSNotification *)notification{
    
    NSNumber *selectedSortIndex = [[notification userInfo] valueForKey:@"SlectedSortIndex"];
    
    [SortingUtilities sortHistoryItems:self.results ByType:[selectedSortIndex intValue]];
    
    [self.historyTable reloadData];
    [self removeSortingControl];
}

- (void) keyboardDidShow{
    
    self.isKeyboardVisible = YES;
}

- (void) keyboardDidHide{
    
    self.isKeyboardVisible = NO;
}

- (void) didReceiveAuthorizationReceiptNotification:(NSNotification *)notification{
    
    [self reloadHistoryTable];
}

- (void) didFinishRefreshingAchHistory:(NSNotification *)notification{
    
    NSData *response    = [[notification userInfo] valueForKey:@"didFinishRefreshingAchHistory"];
    NSArray *achHistory = [ParsingUtilities parseAchAuthorizationHistoryResults:response];
    
    if(achHistory){
        
        [ArchiveUtilities archiveApprovedItems:achHistory withKey:kAchDataKey];
    }
}

- (void) didFinishRefreshingCheckHistory:(NSNotification *)notification{
    
    NSData *response        = [[notification userInfo] valueForKey:@"didFinishRefreshingCheckHistory"];
    NSArray *checkHistory   = [ParsingUtilities parseCheckAuthorizationHistoryResults:response];
    
    if(checkHistory){
        
        [ArchiveUtilities archiveApprovedItems:checkHistory withKey:kCheckDataKey];
    }
}

- (void) didFinishRefreshingWireHistory:(NSNotification *)notification{
    
    NSData *response = [[notification userInfo] valueForKey:@"didFinishRefreshingWireHistory"];
    
    NSArray *wireHistory   = [ParsingUtilities parseWireAuthorizationHistoryResults:response];
    
    if(wireHistory){
        
        [ArchiveUtilities archiveApprovedItems:wireHistory withKey:kWireDataKey];
    }
    

    [self reloadHistoryTable];
    [self.refreshControl endRefreshing];
}

- (void) initializeHistoryData{
    
    self.results = [ArchiveUtilities getAllHistoricalItems];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"arrivalDate" ascending:FALSE];
    [self.results sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (void) setTableViewProperties{
    
    self.historyTable.contentOffset        =  CGPointMake(0, 44);
    self.historyTable.backgroundColor      = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    self.historyTable.separatorColor       = BROWN_SEPERATOR_COLOR_HALF_ALPHA;
}

- (void) handleManualRefresh{
    
    [ArchiveUtilities deleteAllArchivedApprovals];
    
    [[[AuthorizationService alloc] init] getAuthorizationHistoryAsync];
}

- (void) setDelegates{
    
    self.historySearch.delegate    = self;
    self.historyTable.delegate     = self;
    self.historyTable.dataSource   = self;
}

- (void) setDeleteButton{
    
    UIBarButtonItem *placeHolder = [[UIBarButtonItem alloc] init];
    
    UIButton *customButtonView  = [UIButton buttonWithType:UIButtonTypeCustom];
    customButtonView.frame      = CGRectMake(0, 0, 55, 30);
    [customButtonView addTarget:self action:@selector(onDeleteButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [customButtonView setBackgroundImage: [UIImage imageNamed:@"DeleteBrown@2x.png"] forState:UIControlStateNormal];
    
    [placeHolder setCustomView:customButtonView];
    
    self.navigationItem.rightBarButtonItem = placeHolder;
}

- (void) setHistorySearch{
    
    self.historySearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    self.historySearch.tintColor = BROWN_MENU_BACKGROUND_COLOR_FULL_ALPHA;
    self.historySearch.barStyle=UIBarStyleBlackTranslucent;
    self.historySearch.showsCancelButton=NO;
    self.historySearch.autocorrectionType=UITextAutocorrectionTypeNo;
    self.historySearch.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.historySearch.delegate=self;
    self.historyTable.tableHeaderView=_historySearch;
    
    UITextField *searchField = [_historySearch valueForKey:@"_searchField"];
    searchField.textColor = BROWN_TEXT_COLOR;
    
    _historySearch.text = @"Search Authorizations";
}

- (void) setGestureRecognizers{
    
    self.tapGesture = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleTapGesture:)];
    
    
    self.tapGesture.cancelsTouchesInView = NO;
    self.tapGesture.delegate = self;
    
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void) setHistoryRefreshControl{
    
    self.refreshControl           = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0];
    
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0] range:NSMakeRange(0,15)];
    
    
    self.refreshControl.attributedTitle = string;
    
    [self.refreshControl addTarget:self action:@selector(handleManualRefresh) forControlEvents:UIControlEventValueChanged];
    [self.historyTable addSubview:self.refreshControl];
    
}

- (void) displaySortingControl{
    
    self.isSortingVisible           = YES;
    self.sortingControl             = [[[NSBundle mainBundle] loadNibNamed:@"SortingViewController" owner:self options:nil] objectAtIndex:0];
    self.sortingControl.view.alpha  = 0.0;
    self.sortingControl.view.frame  = CGRectMake(60, 315, 250, 150);
    
    [UIView animateWithDuration:0.400 animations:^{
        
        self.sortingControl.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.0];
        self.sortingControl.view.alpha = 1.0;
        
        [self.view addSubview:self.sortingControl.view];
        
    }];
}

- (void) removeSortingControl{

    self.isSortingVisible = NO;
    
    [UIView animateWithDuration:0.300 animations:^{
        
        self.sortingControl.view.alpha = 0.0;
            
    }];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_historySearch resignFirstResponder];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    if([searchText isEqualToString:@""]){
        
        [searchBar performSelector: @selector(resignFirstResponder)
                        withObject: nil
                        afterDelay: 0.1];
        
        self.results = [ArchiveUtilities getAllHistoricalItems];

    }
    else{
        
        self.results = [SearchUtilities searchAllHistoricalItemsContainingText:searchText];
    }
    
    [self.historyTable reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self removeSortingControl];
    
    ApprovalDetailBase *detail = [self.results objectAtIndex:indexPath.row];
    
    HistoryDetailViewController *historyDetailViewController = [[[NSBundle mainBundle] loadNibNamed:@"HistoryDetailViewController" owner:self options:nil] objectAtIndex:0];
    
    historyDetailViewController.detail = detail;
    
    [self.navigationController pushViewController:historyDetailViewController animated:YES];
}

- (void) reloadHistoryTable{
    
    [self initializeHistoryData];
    [self.historyTable reloadData];
    
    if(self.results.count > 0){
        
        [self enableHistoryControls:YES];
    }
    else{
        
        [self enableHistoryControls:NO];
    }
}


- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self reloadHistoryTable];
    [self setDelegates];
    [self installToolBar];
    [self setDeleteButton];
    [self setGestureRecognizers];
    [self setHistoryRefreshControl];
    [self setTableViewProperties];
    [self setHistorySearch];
    [self registerNotifications];
    
    self.sortingControl.view.tag = 200;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HistoryRed.png"]];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self reloadHistoryTable];
}


- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    NSLog(@"Class is: %@", NSStringFromClass([touch.view class]));
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        
        return NO;
    }
    
    if ([touch.view isDescendantOfView:self.historyTable]) {
        
        if([self isSortingVisible]){
            
            [self removeSortingControl];
            self.tapGesture.cancelsTouchesInView = YES;
            return YES;
        }
        else if([self isKeyboardVisible]){
            
            [self.historySearch resignFirstResponder];
            self.tapGesture.cancelsTouchesInView = YES;
            return YES;
        }
        
        self.tapGesture.cancelsTouchesInView = NO;
        return YES;
    }
    else{
        
        self.tapGesture.cancelsTouchesInView = NO;
    }
    

    return YES;
}

- (void) handleTapGesture:(UITapGestureRecognizer *) sender {
    

    if(self.isKeyboardVisible){
        
        [self.historySearch resignFirstResponder];
    }
}

- (void) toolbar:(ALToolbar *)toolbar didSelectButtonAtIndex:(NSInteger)index{
    
    if(!self.isSortingVisible){
        
        [self displaySortingControl];
    }
    else{
        
        [self removeSortingControl];
    }
}

- (void) installToolBar{
    
    _historyToolbar = [[ALToolbar alloc] initWithFrame:CGRectMake(0, 460, 320, 44)];
    
    [_historyToolbar setBackgroundImage:@"historyToolbar.png"];
    [_historyToolbar setBackgroundColor:[UIColor clearColor]];
    [_historyToolbar setBackgroundContentMode:UIViewContentModeBottom];
    [_historyToolbar setDelegate:self];
    [_historyToolbar setAnimatingDirection:ALToolbarAnimationDirectionBottom];
    [_historyToolbar setLayoutMode:ALToolbarButtonsLayoutModeManual];
    
    self.sortToolbarItem =[[ALToolbarItem alloc]initWithFrame:CGRectMake(257, 8, 60, 30)];
    [self.sortToolbarItem setImage:[UIImage imageNamed:@"SortBrown.png"] forState:UIControlStateNormal];
    
    [_historyToolbar setItems:[NSArray arrayWithObjects:self.sortToolbarItem, nil]];
    
    
    [self.view addSubview:_historyToolbar];
}

- (void) enableHistoryControls:(BOOL) enabled{
    
    self.navigationItem.rightBarButtonItem.enabled = enabled;
    self.sortToolbarItem.enabled                   = enabled;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _results.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kTableRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"HistoryCellIdentifier";
    
    ApprovalDetailBase *detail = [self.results objectAtIndex:indexPath.row];
    
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell bindDetails:detail];
    
    
    return cell;

}


@end
