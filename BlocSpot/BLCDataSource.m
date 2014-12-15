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
    }
    return self;
}


- (void) addRecentPointOfInterest:(BLCPointOfInterest *)poi {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"recentPointsOfInterest"];
    [mutableArrayWithKVO addObject:poi];
    NSLog(@"%@", self.recentPointsOfInterest);
}

- (void) addFavoritePointOfInterest:(BLCPointOfInterest *)poi {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"favoritePointsOfInterest"];
    [mutableArrayWithKVO addObject:poi];
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

@end
