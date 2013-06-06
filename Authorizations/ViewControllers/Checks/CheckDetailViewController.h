//
//  CheckDetailViewController.h
//  Authorizations
//
//  Created by Casey Egan on 6/10/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckDetail.h"
#import "NotesViewController.h"
#import "AuthorizationBaseDetailViewController.h"

@interface CheckDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> 


@property (weak, nonatomic) IBOutlet UITableView *checkDetailTableView;

@property (strong, nonatomic) ApprovalDetailBase *detail;
@property (strong, nonatomic) NotesViewController *noteView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;


@end
