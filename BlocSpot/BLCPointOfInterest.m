//
//  BLCPointOfInterest.m
//  BlocSpot
//
//  Created by Collin Adler on 12/11/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCPointOfInterest.h"
#import "BLCCategory.h"

@implementation BLCPointOfInterest

- (instancetype) initWithMapItem:(MKMapItem *)item {
    
    self = [super init];
    if (self) {
        
        self.name = item.name;
        self.coordinate = item.placemark.coordinate;
        
    }
    return self;
}


@end
