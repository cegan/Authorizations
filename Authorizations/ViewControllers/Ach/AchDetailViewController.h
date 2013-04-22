//
//  AchDetailViewController.h
//  Authorizations
//
//  Created by Casey Egan on 5/14/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchDetail.h"
#import "NotesViewController.h"
#import "AuthorizationBaseDetailViewController.h"



@interface AchDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
    
@property (strong, nonatomic) ApprovalDetailBase *detail;
@property (strong, nonatomic) NotesViewController *noteView;
@property (strong, nonatomic) UIButton *ApproveAchButton;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;


@end
