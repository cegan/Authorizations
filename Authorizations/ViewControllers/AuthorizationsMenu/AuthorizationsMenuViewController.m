//
//  AuthorizationsMenuViewController.m
//  Authorizations
//
//  Created by Casey Egan on 1/27/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "AuthorizationsMenuViewController.h"
#import "MenuItemTableViewCell.h"
#import "BadgeInformation.h"
#import "ArchiveUtilities.h"
#import "AuthorizationUIUtilities.h"
#import "Constants.h"
#import "BadgeUpdater.h"
#import "Enums.h"

@interface AuthorizationsMenuViewController ()

- (void) setDelegates;
- (void) setUserInfoDetails;
- (void) setTableViewProperties;
- (void) registerNotificatons;

@end

@implementation AuthorizationsMenuViewController


@synthesize userInformationView = _userInformationView;
@synthesize menuTable           = _menuTable;
@synthesize userLabel           = _userLabel;
@synthesize userTitle           = _userTitle;



- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
       
    }
    return self;
}

- (void) receivedRemoteNotifaction:(NSNotification *)notification{
    
    [self.menuTable reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row <= 5){
    
        [[NSNotificationCenter defaultCenter] postNotificationName:kMenuItemSelected object:nil userInfo:[NSDictionary dictionaryWithObject:indexPath forKey:@"selectedIndex"]];
    }
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    [self setDelegates];
    [self setTableViewProperties];
    [self setUserInfoDetails];
    [self registerNotificatons];
}

- (void) registerNotificatons{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveManualRefreshtNotification:) name:@"didReceiveManualRefreshtNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewAuthorizationNotification:) name:@"didReceiveNewAuthorizationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthorizationReceiptNotification:) name:@"didReceiveAuthorizationReceiptNotification" object:nil];
}

- (void) didReceiveManualRefreshtNotification:(NSNotification *)notification{
    

    NSMutableDictionary *dict = [[notification userInfo] valueForKey:@"RefreshInfo"];
    
    NSString *type = [dict valueForKey:@"type"];
    NSString *count = [dict valueForKey:@"count"];
    

    if(![type isEqualToString:@""]){
        
        [BadgeUpdater updateBadgeValue:count forMenuItem:type];
    }

    [self refreshMenu];
}

- (void) didReceiveAuthorizationReceiptNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"authorizationReceipt"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if(![[newNotification valueForKey:kApprovalIdKey] isEqualToString:@""]){
        
        NSArray *items = [[newNotification valueForKey:kApprovalIdKey] componentsSeparatedByString:@","];
        
        [BadgeUpdater decrementBadgeForType:type withValue:items.count];
            
        [self refreshMenu];
    }
}

- (void) didReceiveNewAuthorizationNotification:(NSNotification *)notification{
    
    NSDictionary *newNotification = [[notification userInfo] valueForKey:@"NewAuthNotification"];
    NSString *type                = [newNotification valueForKey:@"Type"];
    
    if([type isEqualToString:kNewIncomingAchAuthorization]){
        
        [BadgeUpdater incrementBadgeValueForMenuItem:kNewIncomingAchAuthorization];
    }
    
    else if([type isEqualToString:kNewIncomingCheckAuthorization]){
        
        [BadgeUpdater incrementBadgeValueForMenuItem:kNewIncomingCheckAuthorization];
    }
    
    else if([type isEqualToString:kNewIncomingWireAuthorization]){
        
        [BadgeUpdater incrementBadgeValueForMenuItem:kNewIncomingWireAuthorization];
    }
    
    [self refreshMenu];
}

- (void) setTableViewProperties{
    
    self.menuTable.backgroundColor      = BROWN_MENU_BACKGROUND_COLOR_FULL_ALPHA;
    self.menuTable.separatorColor       = BROWN_MENU_SEPERATOR_COLOR_HALF_ALPHA;
}

- (void) setUserInfoDetails{
    
    UserInformation *userInfo = [ArchiveUtilities getArchivedUserInformation];
    
    [_userLabel setFont:[[UIFont fontWithName:@"HelveticaNeue-Bold" size:17] init]];
    [_userTitle setFont:[[UIFont fontWithName:@"HelveticaNeue-Bold" size:9] init]];
    
    _userInformationView.backgroundColor = BROWN_MENU_BACKGROUND_COLOR_FULL_ALPHA;
    _userLabel.backgroundColor           = [UIColor clearColor];
    _userLabel.textColor                 = RED_TEXT_COLOR;
    
    _userLabel.text                      = [NSString stringWithFormat: @"%@%@%@", userInfo.nameFirst,  @" ", userInfo.nameLast];
    _userTitle.text  = userInfo.title;
    _userTitle.textColor = BROWN_TEXT_COLOR;
    
}

- (void) setDelegates{
    
    self.menuTable.delegate     = self;
    self.menuTable.dataSource   = self;
}

- (void) refreshMenu{
    
    [_menuTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kAuthorizationsMenuRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"MyCustomCellIdentifier";
    
    BadgeInformation *notification = [ArchiveUtilities unArchiveNotificationWithKey:kUnviewedNotifications];
    
    MenuItemTableViewCell *cell = (MenuItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuItemTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    switch (indexPath.row) {
            
        case kAchMenuItem:
            cell.menuItemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5,14,30,16)];
            [cell.menuItemIcon setImage: [UIImage imageNamed: @"currency.png"]];
            [cell.menuItemImageLabel setImage: [UIImage imageNamed: @"menuItemAch.png"]];
            [cell addSubview:cell.menuItemIcon];
            
            if(notification.pendingAchCount > 0){
                
                [cell addSubview:[AuthorizationUIUtilities getBadgeImageWithCount:notification.pendingAchCount]];
            }
            break;
            
        case kCheckMenuItem:
            cell.menuItemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5,14,30,16)];
            [cell.menuItemIcon setImage: [UIImage imageNamed: @"currency.png"]];
            [cell.menuItemImageLabel setImage: [UIImage imageNamed: @"menuItemChecks.png"]];
            [cell addSubview:cell.menuItemIcon];
            
            if(notification.pendingCheckCount > 0){
                
                [cell addSubview:[AuthorizationUIUtilities getBadgeImageWithCount:notification.pendingCheckCount]];
            }
            break;
            
        case kWireMenuItem:
            cell.menuItemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5,14,30,16)];
            [cell.menuItemIcon setImage: [UIImage imageNamed: @"currency.png"]];
            [cell.menuItemImageLabel setImage: [UIImage imageNamed: @"menuItemWires.png"]];
            [cell addSubview:cell.menuItemIcon];
            
            if(notification.pendingWireCount > 0){
                
                [cell addSubview:[AuthorizationUIUtilities getBadgeImageWithCount:notification.pendingWireCount]];
            }
            break;
            
        case kHistoryMenuItem:
            cell.menuItemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5,8,25,25)];
            [cell.menuItemIcon setImage: [UIImage imageNamed: @"historyIcon.png"]];
            [cell.menuItemImageLabel setImage: [UIImage imageNamed: @"menuItemHistory.png"]];
            [cell addSubview:cell.menuItemIcon];
            break;
            
        case kSettingsMenuItem:
            cell.menuItemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5,9,23,23)];
            [cell.menuItemIcon setImage: [UIImage imageNamed: @"settings.png"]];
            [cell.menuItemImageLabel setImage: [UIImage imageNamed: @"menuItemSettings.png"]];
            [cell addSubview:cell.menuItemIcon];
            break;
            
        case kLogoutMenuItem:
            cell.menuItemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5,8,25,25)];
            [cell.menuItemIcon setImage: [UIImage imageNamed: @"menuLogout.png"]];
            [cell.menuItemImageLabel setImage: [UIImage imageNamed: @"menuItemLogoutLabel.png"]];
            [cell addSubview:cell.menuItemIcon];
            break;
            
        default:
            cell.textLabel.text = @" ";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    UILabel *headerLabel        = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque          = NO;
    headerLabel.textColor       = [UIColor whiteColor];
    headerLabel.font            = [UIFont boldSystemFontOfSize:14];
    headerLabel.frame           = CGRectMake(5, 0, 300.0, 20.0);
    
    headerLabel.text            = @"Authorizations Menu";
    [headerView addSubview:headerLabel];
    
    if (section == 0)
        headerView.backgroundColor = BROWN_SEPERATOR_COLOR_HALF_ALPHA;
    
    
    return headerView;
    
}



@end
