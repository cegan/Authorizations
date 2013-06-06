//
//  CheckViewController.h
//  Authorizations
//
//  Created by Casey Egan on 5/11/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationsBaseViewController.h"
#import "ALToolbar.h"
#import "Reachability.h"


@interface CheckViewController : AuthorizationsBaseViewController <ALToolbarDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    Reachability* internetReachable;
    Reachability* hostReachable;
        
}


- (void) approveSelectedItems:(NSMutableArray *) approvedItems;


@end
