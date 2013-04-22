//
//  AppDelegate.h
//  Authorizations
//
//  Created by Casey Egan on 1/26/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AchViewController.h"
#import "CheckViewController.h"
#import "WireViewController.h"
#import "HistoryViewController.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "AuthorizationsMenuViewController.h"
#import "AuthorizationService.h"
#import "MFSideMenu.h"
#import "BadgeUpdater.h"
#import "Enums.h"
#import <SystemConfiguration/SystemConfiguration.h>



@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,ALToolbarDelegate,UIActionSheetDelegate,CLLocationManagerDelegate>{
    
    Reachability* internetReachable;
    Reachability* hostReachable;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootNavigationController;
@property (strong, nonatomic) CLLocationManager *locationManager;


@property (strong, nonatomic) AuthorizationsMenuViewController *authorizationsMenuViewController;
@property (strong, nonatomic) AchViewController *achViewController;
@property (strong, nonatomic) CheckViewController *checkViewController;
@property (strong, nonatomic) WireViewController *wireViewController;
@property (strong, nonatomic) HistoryViewController *historyViewController;
@property (strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;


@end
