//
//  BLCDataSource.h
//  BlocSpot
//
//  Created by Collin Adler on 12/11/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BLCPointOfInterest;

@interface BLCDataSource : NSObject

+ (instancetype) sharedInstance;

// Favorites
- (void)addFavoritePointOfInterest:(BLCPointOfInterest *)poi;

// Recents
- (void) addPointOfInterest:(BLCPointOfInterest *)pointOfInterest;

//publicly (to other classes), this will be a readonly property (meaning there is not setter method)
@property (nonatomic, strong, readonly) NSArray *pointOfInterestArray;

@end
