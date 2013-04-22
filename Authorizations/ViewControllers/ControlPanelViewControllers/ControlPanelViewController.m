//
//  ControlPanelViewController.m
//  Authorizations
//
//  Created by Casey Egan on 6/20/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ControlPanelViewController.h"
#import "ArchiveUtilities.h"
#import "SearchUtilities.h"
#import "Constants.h"
#import "ApprovalDetailBase.h"
#import "AchDetail.h"
#import "CheckDetail.h"
#import "WireDetail.h"
#import "DetailTableViewCell.h"

@interface ControlPanelViewController ()

- (void) setCancelButtonAnimated:(BOOL)animated;
- (void) performSearchWithCriteria:(NSString *)criteria;
- (void) setTitleForControlPanel:(NSString *)title;
- (void) updateSearchBarWithText:(NSString *)searchBarText;
- (void) setDoneButton;
- (void) installUserInterface;
- (void) setBackgroundForRootView;
- (void) clearTableData;
- (void) reloadTableData;
- (void) setControlPanelTableView;
- (void) hideDoneButton;
- (void) setDelegates;

@end


@implementation ControlPanelViewController

@synthesize searchResultsList           = _searchResultsList;
@synthesize doneButton                  = _doneButton;
@synthesize cancelButton                = _cancelButton;
@synthesize searchBar                   = _searchBar;
@synthesize controlPanelTableView       = _controlPanelTableView;
@synthesize titleLabel                  = _titleLabel;



- (IBAction) onCancelButtonTouch:(id)sender {
    
    [self clearTableData];
    [self setDoneButton];
    [self updateSearchBarWithText:@"Search Authorizations"];
    [self.searchBar resignFirstResponder];
    
    
    
    for (UIView *subview in self.searchBar.subviews) {
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            
            UIView *bg = [[UIView alloc] initWithFrame:subview.frame];
            bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rootBackground.png"]];
            [self.searchBar insertSubview:bg aboveSubview:subview];
            [subview removeFromSuperview];
            break;
        }
    }
}




- (IBAction) onDoneButtonTouch:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userClosedControlPanelNotification" object:nil];
}


- (void) installUserInterface{
    
    [self setDoneButton];
    [self setBackgroundForRootView];
    [self setControlPanelTableView];
    
}

- (void) updateSearchBarWithText:(NSString *)searchBarText{
    
    self.searchBar.text = searchBarText;
}

- (void) reloadTableData{
    
    [_controlPanelTableView reloadData];
}

- (void) clearTableData{
    
    _searchResultsList = nil;
    [self reloadTableData];
}

- (void) setBackgroundForRootView{
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"controlPanelRootBackground.png"]];
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];    
}

- (void) setDelegates{
    
    self.searchBar.delegate = self;
    _controlPanelTableView.delegate = self;
    _controlPanelTableView.dataSource = self;
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [self setCancelButtonAnimated:YES];
    [self hideDoneButton];
    self.searchBar.text = @"";
    
    _titleLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchTitle.png"]];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self performSearchWithCriteria:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self performSearchWithCriteria:searchText];
}

- (void) performSearchWithCriteria:(NSString *)criteria{
    
    _searchResultsList = [SearchUtilities searchAllHistoricalItemsContainingText:self.searchBar.text];
    [_controlPanelTableView reloadData];
}

- (void) hideDoneButton{
    
    self.navigationItem.leftBarButtonItem=nil;
}

- (void) setDoneButton{
    
    UIButton *customButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    customButtonView.frame = CGRectMake(5, 5, 55, 30);
    [customButtonView addTarget:self action:@selector(onDoneButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [customButtonView setBackgroundImage: [UIImage imageNamed:@"DoneBrown@2x.png"] forState:UIControlStateNormal];
    [_doneButton setCustomView:customButtonView];
    
    self.navigationItem.leftBarButtonItem = _doneButton;

}

- (void) setControlPanelTableView{
    
    _controlPanelTableView.layer.borderColor     = BROWN_BORDER_COLOR_HALF_ALPHA;
    _controlPanelTableView.separatorColor        = BROWN_SEPERATOR_COLOR_HALF_ALPHA;
    _controlPanelTableView.layer.cornerRadius    = 5;
    _controlPanelTableView.layer.borderWidth     = 1.0;
    _controlPanelTableView.backgroundColor       = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    _controlPanelTableView.separatorStyle        = UITableViewCellSeparatorStyleSingleLine;
}

- (void) setCancelButtonAnimated:(BOOL)animated{
    
    UIButton *customButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    customButtonView.frame = CGRectMake(5, 5, 55, 30);
    [customButtonView addTarget:self action:@selector(onCancelButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [customButtonView setBackgroundImage: [UIImage imageNamed:@"CancelBrown@2x.png"] forState:UIControlStateNormal];
    [_cancelButton setCustomView:customButtonView];
    

    [UIView animateWithDuration:0.200 animations:^{
        
       // _cancelButton.alpha = 1.0;
       // _cancelButton.hidden = NO;
    }];
}

- (void) setTitleForControlPanel:(NSString *)title{
    
    _titleLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListsTitle.png"]];
    
}

- (void) viewDidLoad{
    
    [self installUserInterface];
    [self setDelegates];
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    
    for (UIView *subview in self.searchBar.subviews) {
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            
            UIView *bg = [[UIView alloc] initWithFrame:subview.frame];
            bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rooViewBackground.png"]];
            [self.searchBar insertSubview:bg aboveSubview:subview];
            [subview removeFromSuperview];
            break;
        }
    }   
}

- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"History";
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if(_searchResultsList.count > 0){
        
        return kTableViewSectionHeaderHeightVisible;
    }
    
    return kTableViewSectionHeaderHeightHidden;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)aTableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    return _searchResultsList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"SearchResultCellIdentifier";
    
    DetailTableViewCell *cell = (DetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    ApprovalDetailBase *detail = [_searchResultsList objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        
        NSArray *customAchTableCellView = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil];
        
        cell = [customAchTableCellView objectAtIndex:0];
    }
    
    
    if([detail isKindOfClass:[AchDetail class]]) {
        
        cell.fieldValue.text = @"Ach";
    }
    else if ([detail isKindOfClass:[CheckDetail class]]){
        
        cell.fieldValue.text = @"Check";
    }
    else if ([detail isKindOfClass:[WireDetail class]]){
        
        cell.fieldValue.text = @"wire";
    }
    
    
    cell.fieldName.text = detail.name;
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DetailLabelBackground.png"]];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    UILabel * headerLabel       = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque          = NO;
    headerLabel.textColor       = [UIColor whiteColor];
    headerLabel.font            = [UIFont boldSystemFontOfSize:14];
    headerLabel.frame           = CGRectMake(5, 0, 300.0, 20.0);
    
    headerLabel.text            = @"History";
    [headerView addSubview:headerLabel];
    
    if (section == 0)
        headerView.backgroundColor = RED_TEXT_COLOR ;
    
    
    return headerView;
    
}

@end
