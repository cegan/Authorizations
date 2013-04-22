//
//  DetailLabel.h
//  Authorizations
//
//  Created by Casey Egan on 5/27/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLabel : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ValueLabel;


@property (strong, nonatomic) UIImageView *accessoryView;

@end
