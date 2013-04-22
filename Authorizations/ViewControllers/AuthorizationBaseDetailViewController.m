//
//  AuthorizationBaseDetailViewController.m
//  Authorizations
//
//  Created by Casey Egan on 6/10/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AuthorizationBaseDetailViewController.h"
#import "StringUtilities.h"
#import "Constants.h"

@interface AuthorizationBaseDetailViewController ()


@end

@implementation AuthorizationBaseDetailViewController


@synthesize detail                  = _detail;
@synthesize noteView                = _noteView;
@synthesize ApproveAchButton        = _ApproveAchButton;



- (void) viewDidLoad{
    
    [self installViewProperties];
    [super viewDidLoad];
}

- (void) viewDidUnload{
    
    [self setApproveAchButton:nil];
    [super viewDidUnload];
    
}
- (void) installViewProperties{
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailViewBackground.png"]];
    backgroundImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backgroundImage];
}

- (void) setImageForTitle:(UIImageView *) titleImage{
    
    self.navigationItem.titleView = titleImage;
}

@end
