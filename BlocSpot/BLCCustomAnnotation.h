//
//  BLCCustomAnnotation.h
//  BlocSpot
//
//  Created by Collin Adler on 12/9/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BLCCustomAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

- (id) initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)newTitle;

- (MKAnnotationView *)annotationView;

@end
