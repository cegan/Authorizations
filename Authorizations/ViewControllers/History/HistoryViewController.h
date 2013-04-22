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


@interface HistoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ALToolbarDelegate>

@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) UIRefreshControl *refreshControl;


@property (weak, nonatomic) IBOutlet UITableView *historyTable;
@property (nonatomic, retain) UISearchBar *historySearch;
@property (nonatomic, retain) ALToolbarItem *sortToolbarItem;
@property (nonatomic,retain) ALToolbar *historyToolbar;





@end
