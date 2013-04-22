//
//  MenuItemTableViewCell.m
//  Authorizations
//
//  Created by Casey Egan on 1/27/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "MenuItemTableViewCell.h"

@implementation MenuItemTableViewCell


@synthesize menuItemImage           = _menuItemImage;
@synthesize selectedIndicatorImage  = _selectedIndicatorImage;
@synthesize menuItemIcon            = _menuItemIcon;
@synthesize menuItemImageLabel      = _menuItemImageLabel;
@synthesize badgeImage              = _badgeImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
}


- (void) bindMenuItemDetail{
    
    
    
    
}


@end
