//
//  BLCPointOfInterest.h
//  BlocSpot
//
//  Created by Collin Adler on 12/11/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class BLCCategory;

@interface BLCPointOfInterest : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) BOOL *visitedState;
@property (nonatomic, strong) NSString *note;
//TODO: Double-check strong property on BLCCategory to make sure that there isn't a retain reference cycle between BLCCategory and BLCPointOfInterest
@property (nonatomic, strong) BLCCategory *category;

- (instancetype) initWithMapItem:(MKMapItem *)item;

@end
