//
//  WireDetailViewController.h
//  Authorizations
//
//  Created by Casey Egan on 6/10/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesViewController.h"
#import "AuthorizationBaseDetailViewController.h"
#import "DetailLabel.h"

@interface WireDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>


@property (strong, nonatomic) ApprovalDetailBase *detail;
@property (strong, nonatomic) NotesViewController *noteView;

@property (weak, nonatomic) IBOutlet UITableView *wireDetailsTableView;

@end
