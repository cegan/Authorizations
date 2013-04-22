//
//  MenuItemTableViewCell.h
//  Authorizations
//
//  Created by Casey Egan on 1/27/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView *badgeImage;
@property (nonatomic, weak) UIImageView *menuItemImage;
@property (nonatomic, weak) UIImageView *selectedIndicatorImage;
@property (weak, nonatomic) IBOutlet UIImageView *menuItemImageLabel;
@property (retain, nonatomic) IBOutlet UIImageView *menuItemIcon;


- (void) bindMenuItemDetail;


@end
