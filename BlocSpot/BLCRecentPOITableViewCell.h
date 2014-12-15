//
//  BLCRecentPOITableViewCell.h
//  BlocSpot
//
//  Created by Collin Adler on 12/12/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLCPointOfInterest;

@interface BLCRecentPOITableViewCell : UITableViewCell

@property (nonatomic, strong) BLCPointOfInterest *pointOfInterest;

+ (CGFloat) heightForRecentPOI:(BLCPointOfInterest *)poi width:(CGFloat)width;

@end
