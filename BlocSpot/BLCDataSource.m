//
//  BLCDataSource.m
//  BlocSpot
//
//  Created by Collin Adler on 12/11/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCDataSource.h"
#import "BLCPointOfInterest.h"

@interface BLCDataSource () {
    NSMutableArray *_recentPointsOfInterest;
    NSMutableArray *_favoritePointsOfInterest;
}

@property (nonatomic, strong, readwrite) NSArray *recentPointsOfInterest;
@property (nonatomic, strong, readwrite) NSArray *favoritePointsOfInterest;

//set this when data to archive has changed
@property (nonatomic, assign) BOOL hasDataChanged;

@end

@implementation BLCDataSource

+ (instancetype) sharedInstance {

    //To make sure we only create a single instance of this class we use a function called dispatch_once. This function takes a block of code and ensures that it only runs once
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    
    self = [super init];
    if (self) {
        
        self.recentPointsOfInterest = [NSMutableArray array];
        self.favoritePointsOfInterest = [NSMutableArray array];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(recentPointsOfInterest))];
            NSArray *storedRecentPOIs = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (storedRecentPOIs.count > 0) {
                    NSMutableArray *mutableRecentPOIs = [storedRecentPOIs mutableCopy];
                    
                    [self willChangeValueForKey:@"recentPointsOfInterest"];
                    self.recentPointsOfInterest = mutableRecentPOIs;
                    [self didChangeValueForKey:@"mediaItems"];
                } else {
                    // there was nothing saved, so initiate the normal sequence of getting data
                    self.recentPointsOfInterest = [NSMutableArray array];
                }
            });
        });
    }
    return self;
}


- (void) addRecentPointOfInterest:(BLCPointOfInterest *)poi {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"recentPointsOfInterest"];
    [mutableArrayWithKVO addObject:poi];
    self.hasDataChanged = YES;
}

- (void) addFavoritePointOfInterest:(BLCPointOfInterest *)poi {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"favoritePointsOfInterest"];
    [mutableArrayWithKVO addObject:poi];
    self.hasDataChanged = YES;
}

#pragma mark - Key/Value Observing for recent POIs

//these methods will make the NSArray property key-value complianct (KVC)

- (NSUInteger) countOfRecentPointsOfInterest {
    return self.recentPointsOfInterest.count;
}

- (id) objectInRecentPointsOfInterestAtIndex:(NSUInteger)index {
    return [self.recentPointsOfInterest objectAtIndex:index];
}

- (NSArray *) recentPointsOfInterestAtIndexes:(NSIndexSet *)indexes {
    return [self.recentPointsOfInterest objectsAtIndexes:indexes];
}

//These are the mutable accessor methods - KVC methods which allow insertion and deletion of elements from the pointOfInterestArray

- (void) insertObject:(BLCPointOfInterest *)object inRecentPointsOfInterestAtIndex:(NSUInteger)index {
    [_recentPointsOfInterest insertObject:object atIndex:index];
}

- (void) removeObjectFromRecentPointsOfInterestAtIndex:(NSUInteger)index {
    [_recentPointsOfInterest removeObjectAtIndex:index];
}

- (void) replaceObjectInRecentPointsOfInterestAtIndex:(NSUInteger)index withObject:(id)object {
    [_recentPointsOfInterest replaceObjectAtIndex:index withObject:object];
}

#pragma mark - Key/Value Observing for favorite POIs

//these methods will make the NSArray property key-value complianct (KVC)

- (NSUInteger) countOfFavoritePointsOfInterest {
    return self.favoritePointsOfInterest.count;
}

- (id) objectInFavoritePointsOfInterestAtIndex:(NSUInteger)index {
    return [self.favoritePointsOfInterest objectAtIndex:index];
}

- (NSArray *) favoritePointsOfInterestAtIndexes:(NSIndexSet *)indexes {
    return [self.favoritePointsOfInterest objectsAtIndexes:indexes];
}

//These are the mutable accessor methods - KVC methods which allow insertion and deletion of elements from the pointOfInterestArray

- (void) insertObject:(BLCPointOfInterest *)object inFavoritePointsOfInterestAtIndex:(NSUInteger)index {
    [_favoritePointsOfInterest insertObject:object atIndex:index];
}

- (void) removeObjectFromFavoritePointsOfInterestAtIndex:(NSUInteger)index {
    [_favoritePointsOfInterest removeObjectAtIndex:index];
}

- (void) replaceObjectInFavoritePointsOfInterestAtIndex:(NSUInteger)index withObject:(id)object {
    [_favoritePointsOfInterest replaceObjectAtIndex:index withObject:object];
}

#pragma mark - NSKeyedArchiver

- (void) archiveRecentPOIData {
    if (self.hasDataChanged) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSUInteger numberOfItemsToSave = MIN(self.recentPointsOfInterest.count, 10);
            NSArray *recentPOIsToSave = [self.recentPointsOfInterest subarrayWithRange:NSMakeRange(0, numberOfItemsToSave)];
            
            NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(recentPointsOfInterest))];
            //then save it as an NSData to the disk
            NSData *recentPOIData = [NSKeyedArchiver archivedDataWithRootObject:recentPOIsToSave];
            NSError *dataError;
            // the two options ensures the complete file is save and encryts it, respecitvely
            BOOL wroteSuccessfully = [recentPOIData writeToFile:fullPath options:NSDataWritingAtomic | NSDataWritingFileProtectionCompleteUnlessOpen error:&dataError];
            
            if (!wroteSuccessfully) {
                NSLog(@"Couldn't write file: %@", dataError);
            } else {
                self.hasDataChanged = NO;
            }
        });
    }
}

//method creates the full path to a file given a filename
- (NSString *) pathForFilename:(NSString *) filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:filename];
    return dataPath;
}

#pragma mark - Favoriting POIs

- (void) toggleFavoriteOnPOI:(BLCPointOfInterest *)pointOfInterest {
    if (pointOfInterest.favoriteState == BLCPOIFavoriteStateNotLiked) {

        pointOfInterest.favoriteState = BLCPOIFavoriteStateLiked;
        [self addFavoritePointOfInterest:pointOfInterest];
        
        //remove it from the recent POI array to prevent duplicate entries
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"recentPointsOfInterest"];
        NSUInteger index = [mutableArrayWithKVO indexOfObject:pointOfInterest];
        [mutableArrayWithKVO removeObjectAtIndex:index];        
        
    } else if (pointOfInterest.favoriteState == BLCPOIFavoriteStateLiked) {
        
        pointOfInterest.favoriteState = BLCPOIFavoriteStateNotLiked;
        // TODO: remove this POI from the favorites array
        
    }
}

#pragma mark - Deleting POIs

- (void) deletePointOfInterest:(BLCPointOfInterest *)pointOfInterest {
    
    NSMutableArray *mutableRecentArrayWithKVO = [self mutableArrayValueForKey:@"recentPointsOfInterest"];
    NSMutableArray *mutableFavoriteArayWithKVO = [self mutableArrayValueForKey:@"favoritePointsOfInterest"];

    if ([mutableRecentArrayWithKVO containsObject:pointOfInterest]) {
        NSUInteger index = [mutableRecentArrayWithKVO indexOfObject:pointOfInterest];
        [mutableRecentArrayWithKVO removeObjectAtIndex:index];
    } else if ([mutableFavoriteArayWithKVO containsObject:pointOfInterest]) {
        NSUInteger index = [mutableFavoriteArayWithKVO indexOfObject:pointOfInterest];
        [mutableFavoriteArayWithKVO removeObjectAtIndex:index];
    }
}

@end














