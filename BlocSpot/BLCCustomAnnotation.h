//
//  BLCCustomAnnotation.h
//  BlocSpot
//
//  Created by Collin Adler on 12/9/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class BLCPointOfInterest;

@interface BLCCustomAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, readonly) BLCPointOfInterest *poi;

- (id) initWithPointOfInterest:(BLCPointOfInterest *)pointOfInterest;

- (MKAnnotationView *)annotationView;

@end
