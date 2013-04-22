//
//  DetailLabel.m
//  Authorizations
//
//  Created by Casey Egan on 5/27/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DetailLabel.h"
#import "Constants.h"

@interface DetailLabel()

- (void) setUserInterfaceProperties;

@end

@implementation DetailLabel


@synthesize NameLabel       = _nameLabel;
@synthesize ValueLabel      = _valueLabel;
@synthesize accessoryView   = _accessoryView;


- (void) setUserInterfaceProperties{
    
    _nameLabel.textColor       = BROWN_TEXT_COLOR;
    _valueLabel.textColor       = RED_TEXT_COLOR;
    
    
    self.view.backgroundColor   = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DetailLabelBackground.png"]];
    self.view.layer.borderColor = BROWN_BORDER_COLOR;
    self.view.layer.borderWidth = kBorderWidth;
}

- (void) setAccessoryView:(UIImageView *)accessoryView{
    
    _accessoryView = accessoryView;
    
    [_valueLabel removeFromSuperview];
    
    _accessoryView.frame = CGRectMake(290, 12, 7, 11);
    [self.view addSubview:_accessoryView];
}


- (void) viewDidLoad{
    
    [self setUserInterfaceProperties];
    [super viewDidLoad];
}

- (void) viewDidUnload{
    
    [self setNameLabel:nil];
    [self setValueLabel:nil];
    [super viewDidUnload];
}


@end
