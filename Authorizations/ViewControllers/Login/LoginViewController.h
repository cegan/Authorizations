//
//  LoginViewController.h
//  Authorizations
//
//  Created by Casey Egan on 2/11/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "ArchiveUtilities.h"
#import "NetworkUtilities.h"
#import "AuthorizationUIUtilities.h"
#import "AuthorizationService.h"
#import "UserInformation.h"
#import "Constants.h"
#import "Enums.h"
#import "BlockActionSheet.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UIActivityIndicatorView *activityIndicator;
}

@property (weak, nonatomic) UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITableView *loginTable;
@property (retain, nonatomic) UITextField *userNameTF;
@property (retain, nonatomic) UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UILabel *footerLabel;



@end
