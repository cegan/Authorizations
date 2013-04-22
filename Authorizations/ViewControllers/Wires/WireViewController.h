//
//  WireViewController.h
//  Authorizations
//
//  Created by Casey Egan on 5/11/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationsBaseViewController.h"
#import "PullToRefreshView.h"
#import "ALToolbar.h"



@interface WireViewController : AuthorizationsBaseViewController<ALToolbarDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,PullToRefreshViewDelegate>{
    
    
}

- (void) approveSelectedItems:(NSMutableArray *) approvedItems;

@end
