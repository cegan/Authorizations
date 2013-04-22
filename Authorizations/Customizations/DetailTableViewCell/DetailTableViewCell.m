//
//  DetailTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 6/19/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "CustomColoredAccessory.h"
#import "Constants.h"

@implementation DetailTableViewCell

@synthesize fieldName       = _fieldName;
@synthesize fieldValue      = _fieldValue;



- (void) bindDetail:(NSString *) fieldName withValue:(NSString *) fieldValue{
    
    _fieldName.textColor       = BROWN_TEXT_COLOR;
    _fieldValue.textColor      = RED_TEXT_COLOR;
    _fieldName.text            = fieldName;
    _fieldValue.text           = fieldValue;
}

@end
