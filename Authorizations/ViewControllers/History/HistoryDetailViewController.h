//
//  HistoryDetailViewController.h
//  Authorizations
//
//  Created by Casey Egan on 3/24/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApprovalDetailBase.h"
#import "NotesViewController.h"

@interface HistoryDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>



@property (strong, nonatomic) ApprovalDetailBase *detail;
@property (weak, nonatomic) IBOutlet UITableView *historyDetail;
@property (strong, nonatomic) NotesViewController *noteView;

@end
