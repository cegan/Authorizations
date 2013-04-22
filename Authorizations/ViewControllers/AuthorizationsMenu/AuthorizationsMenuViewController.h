//
//  AuthorizationsMenuViewController.h
//  Authorizations
//
//  Created by Casey Egan on 1/27/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

@interface AuthorizationsMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) MFSideMenu *sideMenu;
@property (weak, nonatomic) IBOutlet UIView *userInformationView;
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTitle;


- (void) refreshMenu;

@end
