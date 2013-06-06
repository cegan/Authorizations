//
//  HistoryViewController.h
//  Authorizations
//
//  Created by Casey Egan on 2/2/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ArchiveUtilities.h"
#import "SearchUtilities.h"
#import "CustomAchTableViewCell.h"
#import "ALToolbar.h"
#import "HistoryDetailViewController.h"
#import "HistoryTableViewCell.h"
#import "CheckDetail.h"
#import "WireDetail.h"
#import "AuthorizationUIUtilities.h"
#import "AuthorizationService.h"
#import "Enums.h"
#import "BlockActionSheet.h"
#import "SortingViewController.h"
#import "ParsingUtilities.h"
#import "SortingUtilities.h"


@interface HistoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate,ALToolbarDelegate>


@property (nonatomic, assign) BOOL isSortingVisible;
@property (nonatomic, assign) BOOL isKeyboardVisible;

@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (nonatomic, retain) SortingViewController *sortingControl;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;


@property (weak, nonatomic) IBOutlet UITableView *historyTable;
@property (nonatomic, retain) UISearchBar *historySearch;
@property (nonatomic, retain) ALToolbarItem *sortToolbarItem;
@property (nonatomic,retain) ALToolbar *historyToolbar;

@end
