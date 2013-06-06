//
//  AppDelegate.m
//  Authorizations
//
//  Created by Casey Egan on 1/26/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "AuthorizationUIUtilities.h"
#import "NetworkUtilities.h"
#import "LocationUtilities.h"
#import "BlockActionSheet.h"


@implementation AppDelegate

@synthesize locationManager                     = _locationManager;
@synthesize authorizationsMenuViewController    = _authorizationsMenuViewController;
@synthesize achViewController                   = _achViewController;
@synthesize checkViewController                 = _checkViewController;
@synthesize wireViewController                  = _wireViewController;
@synthesize historyViewController               = _historyViewController;
@synthesize settingsViewController              = _settingsViewController;
@synthesize loginViewController                 = _loginViewController;



- (MFSideMenu *) sideMenu {
    
    _authorizationsMenuViewController = [[[NSBundle mainBundle] loadNibNamed:@"AuthorizationsMenuViewController" owner:self options:nil] objectAtIndex:0];
    
    MFSideMenuOptions options = MFSideMenuOptionMenuButtonEnabled|MFSideMenuOptionBackButtonEnabled|MFSideMenuOptionShadowEnabled;
    MFSideMenuPanMode panMode = MFSideMenuPanModeNavigationBar|MFSideMenuPanModeNavigationController;
    
    MFSideMenu *sideMenu      = [MFSideMenu menuWithNavigationController:self.rootNavigationController
                                                 sideMenuController:_authorizationsMenuViewController
                                                           location:MFSideMenuLocationLeft
                                                            options:options
                                                            panMode:panMode];
    
    _authorizationsMenuViewController.sideMenu = sideMenu;
    
    return sideMenu;
}

- (void) application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)_deviceToken{
    

	NSLog(@"My token is: %@", _deviceToken);
    
    NSString* deviceToken = [[[[_deviceToken description]
                               stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                               stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    [ArchiveUtilities archiveUserDeviceToken:deviceToken];
 }

- (void) application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    
    NSLog(@"Failed to get token, error: %@", error);
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self registerNotifications];
    [self initializeLocationManager];
   
    if([NetworkUtilities hasConnection]){
        
        //[self isUserLoggedIn]
        if(NO){
            
            [self presentApplication];
        }
        else{
            
            [self presentLogin];
        }
    }
        
    return YES;
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *) payLoad {
    
    NSString *type = [payLoad valueForKey:@"Type"];
    
   
    if([self isIncomingAuthorizationReceipt:type]){

            [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveAuthorizationReceiptNotification"
                                                  object:nil
                                                  userInfo:[NSDictionary dictionaryWithObject:payLoad forKey:@"authorizationReceipt"]];
    }
    
    else if ([self isIncomingDeleteNotification:type]){
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveDeleteNotification"
                                                            object:nil
                                                            userInfo:[NSDictionary dictionaryWithObject:payLoad forKey:@"deleteAuthNotification"]];
    }
    else if ([self isIncomingUpdateNotification:type]){
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveUpdateNotification"
                                                            object:nil
                                                          userInfo:[NSDictionary dictionaryWithObject:payLoad forKey:@"updateAuthNotification"]];
    }
    else if([self isIncomingApprovalRequest:type]){
        
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveNewAuthorizationNotification"
                                              object:nil
                                              userInfo:[NSDictionary dictionaryWithObject:payLoad forKey:@"NewAuthNotification"]];
        
    }
}

- (void) initAuthorizationViewControllers{
    
    self.achViewController      = [[[NSBundle mainBundle] loadNibNamed:@"AchViewController" owner:self options:nil] objectAtIndex:0];
    self.checkViewController    = [[[NSBundle mainBundle] loadNibNamed:@"CheckViewController" owner:self options:nil] objectAtIndex:0];
    self.wireViewController     = [[[NSBundle mainBundle] loadNibNamed:@"WireViewController" owner:self options:nil] objectAtIndex:0];
    self.historyViewController  = [[[NSBundle mainBundle] loadNibNamed:@"HistoryViewController" owner:self options:nil] objectAtIndex:0];
    self.settingsViewController = [[[NSBundle mainBundle] loadNibNamed:@"SettingsViewController" owner:self options:nil] objectAtIndex:0];
   
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:self.achViewController];
}

- (void) setupNavigationControllerApp {
    
    self.window                     = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController  = [self sideMenu].navigationController;
    
    [self.window makeKeyAndVisible];
}

- (void) initializeLocationManager {
    
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    
//    
//    NSString *title = @"Home";
//    CLLocationDegrees latitude      = 41.226359;
//    CLLocationDegrees longitude     = -96.227666;
//    CLLocationDegrees rLatitude     = 41.226426;
//    CLLocationDegrees rLongitude    = -96.227772;
//    
//    
//    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
//    CLLocationCoordinate2D destinationCoordinate = CLLocationCoordinate2DMake(rLatitude, rLongitude);
//    
//    
//    CLLocationDistance regionRadius = [LocationUtilities distanceBetweenCoordinate:centerCoordinate andCoordinate:destinationCoordinate];
//    
//    
//    [_locationManager startMonitoringForRegion:[[CLRegion alloc] initCircularRegionWithCenter:centerCoordinate radius:regionRadius identifier:title]];
}

- (void) registerNotifications{
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectMenuItem:) name:kMenuItemSelected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidSuccessfullyLogin) name:kUserDidSuccessfullyLogin object:nil];
}

- (void) setUserInterfaceDeafultAppearance{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"UINavigationBarBackgroundBrown.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void) userDidSuccessfullyLogin{
    
    [self presentApplication];
}

- (void) didSelectMenuItem:(NSNotification *)notification{
    
    NSArray *controllers;
  
    NSIndexPath *index = [[notification userInfo] valueForKey:@"selectedIndex"];
    
    
    if(index.row == kAchMenuItem){
        
        controllers = [NSArray arrayWithObject:self.achViewController];
        self.rootNavigationController.viewControllers = controllers;
    }
    
    else if(index.row == kCheckMenuItem){
        
        controllers = [NSArray arrayWithObject:self.checkViewController];
        self.rootNavigationController.viewControllers = controllers;
    }
    
    else if(index.row == kWireMenuItem){
        
        controllers = [NSArray arrayWithObject:self.wireViewController];
        self.rootNavigationController.viewControllers = controllers;
    }
    
    else if(index.row == kHistoryMenuItem){
        
        controllers = [NSArray arrayWithObject:self.historyViewController];
        self.rootNavigationController.viewControllers = controllers;
    }
    
    
    else if(index.row == kSettingsMenuItem){
        
        controllers = [NSArray arrayWithObject:self.settingsViewController];
        self.rootNavigationController.viewControllers = controllers;
        
    }
    
    else if(index.row == kLogoutMenuItem){
        
        [_authorizationsMenuViewController.sideMenu  setMenuState:MFSideMenuStateHidden];
        [self confirmLogout];
    }
    
    [_authorizationsMenuViewController.sideMenu  setMenuState:MFSideMenuStateHidden];
}

- (void) applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void) applicationDidEnterBackground:(UIApplication *)application{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void) applicationWillEnterForeground:(UIApplication *)application{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
    
    
}

- (void) applicationDidBecomeActive:(UIApplication *)application{
    
      
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void) applicationWillTerminate:(UIApplication *)application{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) checkNetworkStatus:(NSNotification *)notice{
    
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            //self.internetActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            //self.internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            //self.internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            //self.hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            //self.hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            //self.hostActive = YES;
            
            break;
        }
    }
}

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidLeaveRegion" object:nil userInfo:nil];
}

- (void) presentLogin{
    
    self.loginViewController        = [[[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil] objectAtIndex:0];
    self.window                     = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController  = self.loginViewController;
    
    [self.window makeKeyAndVisible];
    
}

- (void) presentApplication{
    
    [self initAuthorizationViewControllers];
    [self setUserInterfaceDeafultAppearance];
    [self setupNavigationControllerApp];
}

- (void) confirmLogout{
    
    UIViewController *root = (UIViewController*)[self.rootNavigationController.viewControllers objectAtIndex:0];
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Confirm Logout"];
    
    [sheet addButtonWithTitle:@"Yes" atIndex:0 block:^{
        
        [ArchiveUtilities logoutUser];
        
        _achViewController      = nil;
        _checkViewController    = nil;
        _wireViewController     = nil;
        _historyViewController  = nil;
        _settingsViewController = nil;
        
        self.loginViewController    = [[[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil] objectAtIndex:0];
        UIViewController *root      = (UIViewController*)[self.rootNavigationController.viewControllers objectAtIndex:0];
        
        [root presentViewController:self.loginViewController animated:YES completion:nil];
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:root.view];
}


- (BOOL) isIncomingApprovalRequest:(NSString *) type{
    
    if([type isEqualToString:@"NewAch"] ||
       [type isEqualToString:@"NewCheck"] ||
       [type isEqualToString:@"NewWire"]){
        
        return YES;
    }
    
    return NO;
}

- (BOOL) isIncomingAuthorizationReceipt:(NSString *) type{
    
    if([type isEqualToString:kNewAchAuthorizationReceipt] ||
       [type isEqualToString:kNewCheckAuthorizationReceipt] ||
       [type isEqualToString:kNewWireAuthorizationReceipt] ||
       [type isEqualToString:kNewAchAuthorizationSilentReceipt]){
        
        return YES;
    }
    
    return NO;
}

- (BOOL) isIncomingDeleteNotification:(NSString *) type{
    
    if([type isEqualToString:kAchDelete] ||
       [type isEqualToString:kCheckDelete] ||
       [type isEqualToString:kWireDelete]){
        
        return YES;
        
    }
    
    return NO;
}

- (BOOL) isIncomingUpdateNotification:(NSString *) type{
    
    if([type isEqualToString:kAchUpdate] ||
       [type isEqualToString:kCheckUpdate] ||
       [type isEqualToString:kWireUpdate]){
        
        return YES;
        
    }
    
    return NO;
}

- (BOOL) isUserLoggedIn{
    
    NSString *userId = [ArchiveUtilities getloggedinUser];
    
    if(userId){
        
        return YES;
    }
    
    return NO;
}


@end
