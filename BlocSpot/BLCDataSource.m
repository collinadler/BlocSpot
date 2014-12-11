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
    NSMutableArray *_pointOfInterestArray;
}

@property (nonatomic, strong, readwrite) NSArray *pointOfInterestArray;

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

- (void) addPointOfInterest:(BLCPointOfInterest *)pointOfInterest {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"pointOfInterestArray"];
    [mutableArrayWithKVO addObject:pointOfInterest];
}


#pragma mark - Key/Value Observing

//these methods will make the NSArray property key-value complianct (KVC)
- (NSUInteger) countOfPointOfInterestArray {
    return self.pointOfInterestArray.count;
}

- (id) objectInPointOfInterestArrayAtIndex:(NSUInteger)index {
    return [self.pointOfInterestArray objectAtIndex:index];
}

- (NSArray *) pointOfInterestArrayAtIndexes:(NSIndexSet *)indexes {
    return [self.pointOfInterestArray objectsAtIndexes:indexes];
}

//These are the mutable accessor methods - KVC methods which allow insertion and deletion of elements from the pointOfInterestArray

- (void) insertObject:(BLCPointOfInterest *)object inPointOfInterestArrayAtIndex:(NSUInteger)index {
    [_pointOfInterestArray insertObject:object atIndex:index];
}

- (void) removeObjectFromPointOfInterestArrayAtIndex:(NSUInteger)index {
    [_pointOfInterestArray removeObjectAtIndex:index];
}

- (void) replaceObjectInPointOfInterestArrayAtIndex:(NSUInteger)index withObject:(id)object {
    [_pointOfInterestArray replaceObjectAtIndex:index withObject:object];
}

@end
