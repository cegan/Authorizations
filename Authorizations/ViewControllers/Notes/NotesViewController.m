//
//  NotesViewController.m
//  Authorizations
//
//  Created by Casey Egan on 6/10/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NotesViewController.h"
#import "AuthorizationUIUtilities.h"
#import "Constants.h"

@interface NotesViewController ()

- (void) installUserInterface;
- (void) setRootBackgroundViewImage;
- (void) setBackButton;
- (void) setDoneButton;
- (void) setDelegates;
- (void) setUserNoteTextView;

@end

@implementation NotesViewController

@synthesize approvalDetail  = _approvalDetail;
@synthesize userNoteView    = _userNoteView;


- (IBAction) onDetailsButtonTouch:(id)sender {
    
    _approvalDetail.userNotes = _userNoteView.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction) onDoneButtonTouch:(id)sender {
    
    _approvalDetail.userNotes = _userNoteView.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) installUserInterface{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notesTitle.png"]];
    
    [self setBackButton];
    [self setDoneButton];
    [self setUserNoteTextView];
    [self setRootBackgroundViewImage];
}

- (void) setRootBackgroundViewImage{
    
    self.view.backgroundColor       = [UIColor whiteColor];
    UIImageView *backgroundImage    = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailViewBackground.png"]];
    backgroundImage.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:backgroundImage];
}

- (void) setDelegates{
    
    _userNoteView.delegate = self;
}

- (void) setDoneButton{
    
    UIButton *doneButton = [AuthorizationUIUtilities getAuthorizationsDoneButton];
    [doneButton addTarget:self action:@selector(onDoneButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
}

- (void) setBackButton{
    
    UIButton *backButton = [AuthorizationUIUtilities getAuthorizationDetailsBackButton];
    [backButton addTarget:self action:@selector(onDetailsButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]]; 
}

- (void) setUserNoteTextView{

    _userNoteView                       = [[UITextView alloc] init];
    _userNoteView.frame                 = CGRectMake(5, 10, 310, 150);
    _userNoteView.layer.borderWidth     = kBorderWidth;
    _userNoteView.layer.borderColor     = BROWN_BORDER_COLOR;
    _userNoteView.layer.cornerRadius    = 5.0;
    _userNoteView.returnKeyType         = UIReturnKeyDone;
    _userNoteView.text                  = @"test";
    
    [self.view addSubview:_userNoteView];
    
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    
    
    
}

- (void) viewDidLoad{
    
    [self installUserInterface];
    [super viewDidLoad];
}

- (void) viewDidUnload{
    
    
       
    
    
    [super viewDidUnload];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.userNoteView resignFirstResponder];
}

@end
