//
//  LocationUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 12/19/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import "LocationUtilities.h"

@implementation LocationUtilities


+(CLLocationCoordinate2D) getCurrentLocation{
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];

    CLLocation *location = [locationManager location];
    
    return location.coordinate;
}


+ (CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)originCoordinate andCoordinate:(CLLocationCoordinate2D)destinationCoordinate {
    
    CLLocation *originLocation = [[CLLocation alloc] initWithLatitude:originCoordinate.latitude longitude:originCoordinate.longitude];
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:destinationCoordinate.latitude longitude:destinationCoordinate.longitude];
    CLLocationDistance distance = [originLocation distanceFromLocation:destinationLocation];
    return distance;
}

@end
