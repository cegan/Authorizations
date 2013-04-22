//
//  LoginViewController.m
//  Authorizations
//
//  Created by Casey Egan on 2/11/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

- (void) setLoginBtn;
- (void) setDelegates;
- (void) setActivityIndicator;
- (void) registerNotifications;
- (void) showErrorWithMessage:(NSString *) message;

@end

@implementation LoginViewController

@synthesize loginButton = _loginButton;
@synthesize loginTable  = _loginTable;
@synthesize userNameTF  = _userNameTF;
@synthesize passwordTF  = _passwordTF;

- (IBAction) onLoginTouch:(id)sender {
    
    NSString *userName = _userNameTF.text;
       
    [_userNameTF resignFirstResponder];
    
    if([NetworkUtilities hasConnection]){
        
        [activityIndicator startAnimating];
            
        [[[AuthorizationService alloc] init] loginUser:userName];
    }
    else{
        
        [self showErrorWithMessage:@"No Data Connection Found"];
    }
}



- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self registerNotifications];
    [self setActivityIndicator];
    [self setLoginBtn];
    [self setDelegates];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:246.00/255.0 green:241.0/255.00 blue:228.0/255.00 alpha:1.0];
	
    [_loginTable setBackgroundView:nil];
    [_loginTable setBackgroundView:[[UIView alloc] init]];
    [_loginTable setBackgroundColor:UIColor.clearColor];
    
    _loginTable.layer.borderColor     = [UIColor clearColor].CGColor;
    _loginTable.layer.cornerRadius    = 5.0;
    _loginTable.layer.borderWidth     = 0.5;
   
    _loginTable.separatorColor        = [UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:0.5];
}

- (void) setLoginBtn{
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.layer.borderColor = BROWN_BORDER_COLOR;
    self.loginButton.layer.borderWidth = 0.5;
    [self.loginButton.layer setCornerRadius:5.0];
    [self.loginButton setBackgroundImage: [UIImage imageNamed:@"Login.png"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(onLoginTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.frame  = CGRectMake(15, 245, 290, 35);
    [self.loginButton addSubview:activityIndicator];
    [self.view addSubview:self.loginButton];
}

- (void) setActivityIndicator{
    
    activityIndicator        = [[UIActivityIndicatorView alloc] init];
    activityIndicator.frame  = CGRectMake(250, 8, 20, 20);
    activityIndicator.color  = [UIColor colorWithRed:147.00/255.0 green:27.0/255.00 blue:12.0/255.00 alpha:1.0];
}

- (void) registerNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCompleted:) name:@"loginCompleted" object:nil];
}

- (void) setDelegates{
    
    self.loginTable.delegate     = self;
    self.loginTable.dataSource   = self;
    
    _userNameTF.delegate         = self;
    _passwordTF.delegate         = self;
}

- (void) showErrorWithMessage:(NSString *) message{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:message delegate:self cancelButtonTitle:@"Ok" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [[actionSheet layer] setBackgroundColor:[UIColor redColor].CGColor];
    [actionSheet showInView:self.view];
}

- (void) loginCompleted:(NSNotification *)notification{
    
    [activityIndicator stopAnimating];
    
    UserInformation *userInfo = [[notification userInfo] valueForKey:kUserInformationKey];
    
    if(userInfo.networkId){
        
        [ArchiveUtilities archiveUserInformation:userInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserDidSuccessfullyLogin object:nil userInfo:nil];
    }
    else{
        
        [self showErrorWithMessage:@"Log In Failed"];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
   
}

- (void) textFieldDidBeginEditing:(UITextField *)sender{
    
   _userNameTF.text = @"";
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField.tag == 0){
        
        [self.passwordTF becomeFirstResponder];
    }
    else{
        
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    NSString *identifier = @"LoginCellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] init];
    }
    
    if(indexPath.row == 0){
        
        self.userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 280, 22)];
        self.userNameTF.font = [[UIFont fontWithName:@"HelveticaNeue" size:14] init];
        self.userNameTF.textColor = [UIColor grayColor];
        self.userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.userNameTF.tag = 0;
        self.userNameTF.text = @"Username";
        [cell.contentView addSubview:self.userNameTF];
    }
    else{
        
        self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 280, 22)];
        self.passwordTF.font = [[UIFont fontWithName:@"HelveticaNeue" size:14] init];
        self.passwordTF.textColor = [UIColor grayColor];
        self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.passwordTF.tag = 1;
        self.passwordTF.text = @"Password";
        [cell.contentView addSubview:self.passwordTF];
        
    }
    
    return cell;
}


@end
