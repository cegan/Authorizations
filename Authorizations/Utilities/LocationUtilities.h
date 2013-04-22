//
//  LocationUtilities.h
//  Authorizations
//
//  Created by Casey Egan on 12/19/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationUtilities : NSObject

+ (CLLocationCoordinate2D) getCurrentLocation;
+ (CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)originCoordinate andCoordinate:(CLLocationCoordinate2D)destinationCoordinate;

@end
