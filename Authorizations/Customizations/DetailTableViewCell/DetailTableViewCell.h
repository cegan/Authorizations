//
//  DetailTableViewCell.h
//  Authorizations
//
//  Created by Casey Egan on 6/19/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell


- (void) bindDetail:(NSString *) fieldName withValue:(NSString *) fieldValue;

@property (strong, nonatomic) IBOutlet UILabel *fieldName;
@property (strong, nonatomic) IBOutlet UILabel *fieldValue;


@end
