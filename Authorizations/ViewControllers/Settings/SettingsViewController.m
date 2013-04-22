//
//  SettingsViewController.m
//  Authorizations
//
//  Created by Casey Egan on 2/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SettingsViewController.h"
#import "AuthorizationUIUtilities.h"
#import "AuthorizationService.h"
#import "Constants.h"

@interface SettingsViewController ()

- (void) setUserInterfaceProperties;
- (void) setDelegates;


@end

@implementation SettingsViewController

@synthesize settingsTable = _settingsTable;


- (IBAction) onRestButtonTouch:(id)sender {
    
    AuthorizationService *service = [[AuthorizationService alloc] init];
    
    [service resetUserData:@""];
}

- (void) setUserInterfaceProperties{
    
    [self.view addSubview:[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailViewBackground.png"]]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SettingsTitle.png"]];
    
    
    [_settingsTable setBackgroundView:nil];
    [_settingsTable setBackgroundView:[[UIView alloc] init]];
    [_settingsTable setBackgroundColor:UIColor.clearColor];
    
    _settingsTable.layer.borderColor     = [UIColor clearColor].CGColor;
    _settingsTable.layer.cornerRadius    = 5;
    _settingsTable.layer.borderWidth     = 1.0;
    _settingsTable.separatorColor        = [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0];
    _settingsTable.separatorStyle        = UITableViewCellSeparatorStyleSingleLineEtched;
}

- (void) setDelegates{
    
    self.settingsTable.delegate     = self;
    self.settingsTable.dataSource   = self;
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self setDelegates];
    [self setUserInterfaceProperties];
}


- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return @"Enable Geo Fence to receive a notification if you exit the building with pending approvals.";
    }
    
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"SettingsCellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] init];
    }
    
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [resetButton setFrame:CGRectMake(0, 0, 80, 30)];
    [resetButton addTarget:self action:@selector(onRestButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
 
    switch (indexPath.row) {
            
        case 0:
            cell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.textLabel.textColor = RED_TEXT_COLOR;
            cell.textLabel.font = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] init];
            cell.textLabel.text = @"Enable Geo Fence";
            break;
            
        case 1:
            cell.accessoryView = resetButton;
            cell.textLabel.textColor = RED_TEXT_COLOR;
            cell.textLabel.font = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] init];
            cell.textLabel.text = @"Reset Data";
            break;
            
    }
 
    
    return cell;
}

@end
