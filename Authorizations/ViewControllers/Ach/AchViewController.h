//
//  AchViewController.h
//  Authorizations
//
//  Created by Casey Egan on 1/26/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationsBaseViewController.h"
#import "PullToRefreshView.h"
#import "ALToolbar.h"
#import "Reachability.h"
#import "CustomAchTableViewCell.h"

@interface AchViewController : AuthorizationsBaseViewController <ALToolbarDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate, PullToRefreshViewDelegate>{
    
    Reachability* internetReachable;
    Reachability* hostReachable;
    
}

//- (void) approveSelectedItems:(NSMutableArray *) approvedItems;




@end



