//
//  WireViewController.h
//  Authorizations
//
//  Created by Casey Egan on 5/11/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationsBaseViewController.h"
#import "ALToolbar.h"
#import "WireDetailViewController.h"
#import "CustomAchTableViewCell.h"
#import "WireDetail.h"
#import "StringUtilities.h"
#import "AuthorizationUIUtilities.h"
#import "ParsingUtilities.h"
#import "ArchiveUtilities.h"
#import "CalendarUtilities.h"
#import "NetworkUtilities.h"
#import "NotificationUtilities.h"
#import "AuthorizationService.h"
#import "Constants.h"
#import "Enums.h"
#import "BadgeUpdater.h"
#import "BlockActionSheet.h"



@interface WireViewController : AuthorizationsBaseViewController<ALToolbarDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    
    
}

- (void) approveSelectedItems:(NSMutableArray *) approvedItems;

@end
