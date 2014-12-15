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
- (void) addRecentPointOfInterest:(BLCPointOfInterest *)poi;

// Archive methods
- (void) archiveRecentPOIData;


//publicly (to other classes), these will be a readonly properties (meaning there is not setter method)
@property (nonatomic, strong, readonly) NSArray *recentPointsOfInterest;
@property (nonatomic, strong, readonly) NSArray *favoritePointsOfInterest;



@end
