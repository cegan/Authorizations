//
//  ControlPanelViewController.h
//  Authorizations
//
//  Created by Casey Egan on 6/20/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlPanelViewController : UIViewController <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, retain) NSArray *searchResultsList;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *controlPanelTableView;
@property (strong, nonatomic) IBOutlet UIImageView *titleLabel;

@end
