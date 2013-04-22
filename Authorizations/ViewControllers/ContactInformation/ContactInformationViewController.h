//
//  ContactInformationViewController.h
//  Authorizations
//
//  Created by Casey Egan on 4/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "ContactInformation.h"
#import "DetailTableViewCell.h"
#import "AuthorizationUIUtilities.h"
#import "Constants.h"
#import "Enums.h"


@interface ContactInformationViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UIButton *contactCustomer;
@property (weak, nonatomic) IBOutlet UITableView *contactInfoTable;
@property (nonatomic,retain) ContactInformation *contactInformation;

@end
