//
//  BLCCustomAnnotation.m
//  BlocSpot
//
//  Created by Collin Adler on 12/9/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCCustomAnnotation.h"

@implementation BLCCustomAnnotation
@synthesize coordinate;

- (id) initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)newTitle{
    self = [super init];
    if (self) {
        coordinate = coord;
        _title = newTitle;
    }
    return self;
}

- (MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"red"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}


@end
