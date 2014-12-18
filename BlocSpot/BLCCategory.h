//
//  BLCCategory.h
//  BlocSpot
//
//  Created by Collin Adler on 12/11/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLCCategory : NSObject <NSCoding>

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *categoryTitle;
@property (nonatomic, strong) UIColor *color;

@end
