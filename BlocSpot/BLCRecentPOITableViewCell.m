//
//  BLCRecentPOITableViewCell.m
//  BlocSpot
//
//  Created by Collin Adler on 12/12/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCRecentPOITableViewCell.h"
#import "BLCPointOfInterest.h"

@interface BLCRecentPOITableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@end


@implementation BLCRecentPOITableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //this adds the disclosure indicator to the right
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        self.noteLabel = [[UILabel alloc] init];
        self.noteLabel.numberOfLines = 0;
        self.noteLabel.backgroundColor = [UIColor clearColor];
        
        self.categoryLabel = [[UILabel alloc] init];
        self.categoryLabel.backgroundColor = [UIColor blueColor];
        
        self.distanceLabel = [[UILabel alloc] init];
        self.distanceLabel.backgroundColor = [UIColor clearColor];
        
        for (UIView *view in @[self.titleLabel, self.noteLabel, self.categoryLabel, self.distanceLabel]) {
            [self.contentView addSubview:view];
//            view.layer.borderColor = [UIColor blackColor].CGColor;
//            view.layer.borderWidth = 1.0;
        }
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 10;
    CGFloat categoryLabelSize = 30;
    
    //before layout, calc the intrinsic size of the labels (the size they "want" to be)
    CGSize maxNoteLabelSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize noteLabelSize = [self.noteLabel sizeThatFits:maxNoteLabelSize];
    
    self.categoryLabel.frame = CGRectMake(padding, padding, categoryLabelSize, categoryLabelSize);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.categoryLabel.frame) + padding, padding, CGRectGetWidth(self.contentView.frame) - CGRectGetWidth(self.categoryLabel.frame) - padding - padding, categoryLabelSize);
    self.distanceLabel.frame = CGRectMake(padding, CGRectGetMaxY(self.categoryLabel.frame) + padding, categoryLabelSize, 15); //TODO: Make not a constant
    self.noteLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMinY(self.distanceLabel.frame), CGRectGetWidth(self.titleLabel.frame), noteLabelSize.height);
}

- (void) setPointOfInterest:(BLCPointOfInterest *)pointOfInterest {
    _pointOfInterest = pointOfInterest;
    self.titleLabel.text = _pointOfInterest.name;
    
    if (!self.noteLabel.text) {
        self.noteLabel.text = @"No label set.";
    } else {
        self.noteLabel.text = _pointOfInterest.note;
    }
    
    //TODO: Delete below and set distance marker
    self.distanceLabel.text = @"XX mi.";
}

+ (CGFloat) heightForRecentPOI:(BLCPointOfInterest *)poi width:(CGFloat)width {
    //make a cell
    BLCRecentPOITableViewCell *layoutCell = [[BLCRecentPOITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];

    layoutCell.pointOfInterest = poi;
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    //get the actual height of the cell (i.e. the y-coordinate of the bottom of the bottom-most view
    return  CGRectGetMaxY(layoutCell.noteLabel.frame) + 5;
}


@end


















