//
//  AuthorizationBaseDetailViewController.h
//  Authorizations
//
//  Created by Casey Egan on 6/10/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchDetail.h"
#import "DetailLabel.h"
#import "NotesViewController.h"

@interface AuthorizationBaseDetailViewController : UIViewController


@property (strong, nonatomic) UIButton *ApproveAchButton;


@property (strong, nonatomic) ApprovalDetailBase *detail;
@property (strong, nonatomic) DetailLabel *notesDetail;
@property (strong, nonatomic) DetailLabel *nameDetail;
@property (strong, nonatomic) DetailLabel *amountDetail;
@property (strong, nonatomic) DetailLabel *accountDetail;
@property (strong, nonatomic) DetailLabel *dateDetail;
@property (strong, nonatomic) NotesViewController *noteView;


- (void)setImageForTitle:(UIImageView *) titleImage;
- (void)installViewProperties;


@end
