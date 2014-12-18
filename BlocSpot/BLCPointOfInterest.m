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


#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        
        double latitude = [aDecoder decodeDoubleForKey:@"latitude"];
        double longitude = [aDecoder decodeDoubleForKey:@"longitude"];
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);

        self.favoriteState = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(favoriteState))];
        self.note = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(note))];
        self.category = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(category))];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeDouble:self.coordinate.latitude forKey:@"latitude"];
    [aCoder encodeDouble:self.coordinate.longitude forKey:@"longitude"];
    [aCoder encodeInteger:self.favoriteState forKey:NSStringFromSelector(@selector(favoriteState))];
    [aCoder encodeObject:self.note forKey:NSStringFromSelector(@selector(note))];
    [aCoder encodeObject:self.category forKey:NSStringFromSelector(@selector(category))];
}

@end
