//
//  HistoryViewController.m
//  Authorizations
//
//  Created by Casey Egan on 2/2/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryDetailViewController.h"
#import "HistoryTableViewCell.h"
#import "AuthorizationUIUtilities.h"
#import "AuthorizationService.h"
#import "ArchiveUtilities.h"
#import "Enums.h"
#import "Constants.h"
#import "ALToolbar.h"
#import "BlockActionSheet.h"

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

@end

@implementation HistoryViewController

@synthesize results         = _results;
@synthesize historyTable    = _historyTable;
@synthesize historySearch   = _historySearch;
@synthesize historyToolbar  = _historyToolbar;
@synthesize refreshControl  = _refreshControl;
@synthesize sortToolbarItem = _sortToolbarItem;


- (IBAction) onDeleteButtonTouch:(id)sender {
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthorizationReceiptNotification:) name:@"didReceiveAuthorizationReceiptNotification" object:nil];
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

- (void) didReceiveAuthorizationReceiptNotification:(NSNotification *)notification{
    
    [self reloadHistoryTable];
}

- (void) initializeHistoryData{
    
    _results = [ArchiveUtilities getAllHistoricalItems];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"arrivalDate" ascending:FALSE];
    [_results sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];   
}

- (void) setTableViewProperties{
    
    _historyTable.backgroundColor      = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    _historyTable.separatorColor       = BROWN_SEPERATOR_COLOR_HALF_ALPHA;
}

- (void) handleRefresh{
    
    NSArray *achHistory     = [[[AuthorizationService alloc] init] getAchAuthorizationHistory];
    NSArray *checkHistory   = [[[AuthorizationService alloc] init] getCheckAuthorizationHistory];
    NSArray *wireHistory    = [[[AuthorizationService alloc] init] getWireAuthorizationHistory];
    
    [ArchiveUtilities deleteAllArchivedApprovals];
    [ArchiveUtilities archiveApprovedItems:achHistory withKey:kAchDataKey];
    [ArchiveUtilities archiveApprovedItems:checkHistory withKey:kCheckDataKey];
    [ArchiveUtilities archiveApprovedItems:wireHistory withKey:kWireDataKey];
    
    [self reloadHistoryTable];
    
    [self.refreshControl endRefreshing];
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
    
    _historySearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    _historySearch.barStyle=UIBarStyleBlackTranslucent;
    _historySearch.showsCancelButton=NO;
    _historySearch.autocorrectionType=UITextAutocorrectionTypeNo;
    _historySearch.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _historySearch.delegate=self;
    _historyTable.tableHeaderView=_historySearch;
    
    
    UITextField *searchField = [_historySearch valueForKey:@"_searchField"];
    searchField.textColor = BROWN_TEXT_COLOR;
    
    _historySearch.text = @"Search Authorizations";
}

- (void) setHistoryRefreshControl{
    
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0];
    
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0] range:NSMakeRange(0,15)];
    
    
    _refreshControl.attributedTitle = string;
    
    [_refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    [self.historyTable addSubview:_refreshControl];
    
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_historySearch resignFirstResponder];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    if([searchText isEqualToString:@""]){
        
        [searchBar performSelector: @selector(resignFirstResponder)
                        withObject: nil
                        afterDelay: 0.1];
        
        _results = [ArchiveUtilities getAllHistoricalItems];

    }
    else{
        
        _results = [SearchUtilities searchAllHistoricalItemsContainingText:searchText];
    }
    
    [_historyTable reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ApprovalDetailBase *detail = [self.results objectAtIndex:indexPath.row];
    
    HistoryDetailViewController *historyDetailViewController = [[[NSBundle mainBundle] loadNibNamed:@"HistoryDetailViewController" owner:self options:nil] objectAtIndex:0];
    
    historyDetailViewController.detail = detail;
    
    [self.navigationController pushViewController:historyDetailViewController animated:YES];
}

- (void) reloadHistoryTable{
    
    [self initializeHistoryData];
    [_historyTable reloadData];
    
    if(_results.count > 0){
        
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
    [self setHistoryRefreshControl];
    [self setTableViewProperties];
    [self setHistorySearch];
    [self registerNotifications];
    
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HistoryRed.png"]];
    _historySearch.tintColor = BROWN_MENU_BACKGROUND_COLOR_FULL_ALPHA;
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self reloadHistoryTable];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.historySearch resignFirstResponder];
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
