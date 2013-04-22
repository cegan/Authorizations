//
//  SettingsViewController.h
//  Authorizations
//
//  Created by Casey Egan on 2/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;



@end
