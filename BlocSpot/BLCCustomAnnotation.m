//
//  BLCCustomAnnotation.m
//  BlocSpot
//
//  Created by Collin Adler on 12/9/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCCustomAnnotation.h"
#import "BLCPointOfInterest.h"

@interface BLCCustomAnnotation ()

@property (nonatomic, strong) BLCPointOfInterest *poi;

@end

@implementation BLCCustomAnnotation
@synthesize coordinate;

- (id) initWithPointOfInterest:(BLCPointOfInterest *)pointOfInterest {
    
    self = [super init];
    if (self) {
        self.poi = pointOfInterest;
        coordinate = pointOfInterest.coordinate;
        _title = pointOfInterest.name;
    }
    return self;
}

- (MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = NO;
//    annotationView.image = [UIImage imageNamed:@"yellow"];
    
    if (self.poi.favoriteState == BLCPOIFavoriteStateNotLiked) {
        annotationView.image = [UIImage imageNamed:@"yellow"];
    } else if (self.poi.favoriteState == BLCPOIFavoriteStateLiked) {
        annotationView.image = [UIImage imageNamed:@"red"];
    }
    
    return annotationView;
}


@end
