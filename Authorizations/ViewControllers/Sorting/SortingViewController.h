//
//  SortingViewController.h
//  Authorizations
//
//  Created by Casey Egan on 5/4/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ArchiveUtilities.h"
#import "Constants.h"



@interface SortingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIImageView *sortingBackgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL selectedSortingIndex;


@end
