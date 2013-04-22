//
//  CustomColoredAccessory.h
//  Authorizations
//
//  Created by Casey Egan on 2/24/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomColoredAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (CustomColoredAccessory *)accessoryWithColor:(UIColor *)color;

@end
