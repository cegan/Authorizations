//
//  ControlPanel.h
//  Authorizations
//
//  Created by Casey Egan on 1/26/13.
//  Copyright (c) 2013 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlPanel : UIViewController <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) NSArray *searchResultsList;
@property (weak, nonatomic) IBOutlet UISearchBar *AuthorizationsSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *AuthorizationsTable;

@end
