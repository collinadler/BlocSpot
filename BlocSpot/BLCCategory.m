//
//  BLCCategory.m
//  BlocSpot
//
//  Created by Collin Adler on 12/11/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCCategory.h"

@implementation BLCCategory


#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.objectId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(objectId))];
        self.categoryTitle = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(categoryTitle))];
        self.color = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(color))];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.objectId forKey:NSStringFromSelector(@selector(objectId))];
    [aCoder encodeObject:self.categoryTitle forKey:NSStringFromSelector(@selector(categoryTitle))];
    [aCoder encodeObject:self.color forKey:NSStringFromSelector(@selector(color))];
}

@end
