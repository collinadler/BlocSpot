//
//  BLCPOIMapDetailView.m
//  BlocSpot
//
//  Created by Collin Adler on 12/10/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCPOIMapDetailView.h"
#import "BLCPointOfInterest.h"

#define kFavoriteStateImage @"heart-full"
#define kUnfavoriteStateImage @"heart-empty"

@interface BLCPOIMapDetailView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineDividerView;
@property (nonatomic, strong) UIButton *navigateButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIImageView *poiMarkerImageView;
@property (nonatomic, strong) UILabel *noteLabel;

@end

@implementation BLCPOIMapDetailView

- (id)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        self.poiMarkerImageView = [[UIImageView alloc] init];
        
        self.lineDividerView = [[UIView alloc] init];
        self.lineDividerView.backgroundColor = [UIColor grayColor];
        
        self.noteLabel = [[UILabel alloc] init];
        self.noteLabel.numberOfLines = 0;
        [self.noteLabel setFont:[UIFont systemFontOfSize:10]];
        
        self.categoryLabel = [[UILabel alloc] init];
        self.categoryLabel.textAlignment = NSTextAlignmentCenter;
        
        self.navigateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.navigateButton setImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
        [self.navigateButton addTarget:self
                                action:@selector(navigateButtonPressed:)
                      forControlEvents:UIControlEventTouchUpInside];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self.shareButton addTarget:self
                             action:@selector(shareButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self
                              action:@selector(deleteButtonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        self.favoriteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.favoriteButton addTarget:self
                                action:@selector(favoriteButtonPressed:)
                      forControlEvents:UIControlEventTouchUpInside];
        
        for (UIView *view in @[self.titleLabel, self.poiMarkerImageView, self.lineDividerView, self.noteLabel, self.categoryLabel, self.navigateButton, self.shareButton, self.deleteButton, self.favoriteButton]) {
            [self addSubview:view];
//            view.layer.borderColor = [UIColor blackColor].CGColor;
//            view.layer.borderWidth = 1.0;
        }
        
    }

    return self;
}

- (void) layoutSubviews {
    
    CGFloat padding = 10;
    CGFloat poiMarkerEdge = 30;
    CGFloat lineDividerHeight = 0.5;
    CGFloat categoryHeight = 20;
    CGFloat buttonSize = 25;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMinX(self.bounds) + padding, CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds) - poiMarkerEdge - padding * 2, poiMarkerEdge + padding);
    self.poiMarkerImageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMidY(self.titleLabel.frame) - (poiMarkerEdge / 2), poiMarkerEdge, poiMarkerEdge);
    self.lineDividerView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.bounds), lineDividerHeight);
    self.noteLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.lineDividerView.frame), CGRectGetMaxX(self.poiMarkerImageView.frame) - padding, 90); //TODO: Make height not a constant
    self.categoryLabel.frame = CGRectMake(CGRectGetMinX(self.bounds) + padding, CGRectGetMaxY(self.noteLabel.frame) + padding, CGRectGetWidth(self.bounds) *0.4, categoryHeight);
    self.deleteButton.frame = CGRectMake(CGRectGetMaxX(self.poiMarkerImageView.frame) - buttonSize, CGRectGetMinY(self.categoryLabel.frame), buttonSize, buttonSize);
    self.shareButton.frame = CGRectMake(CGRectGetMinX(self.deleteButton.frame) - buttonSize, CGRectGetMinY(self.deleteButton.frame), buttonSize, buttonSize);
    self.navigateButton.frame = CGRectMake(CGRectGetMinX(self.shareButton.frame) - buttonSize, CGRectGetMinY(self.deleteButton.frame), buttonSize, buttonSize);
    self.favoriteButton.frame = CGRectMake(CGRectGetMinX(self.navigateButton.frame) - buttonSize, CGRectGetMinY(self.deleteButton.frame), buttonSize, buttonSize);
}

#pragma mark - Overrides

- (void)setPoi:(BLCPointOfInterest *)poi {
    _poi = poi;
    self.titleLabel.text = _poi.name;
    self.poiMarkerImageView.image = [UIImage imageNamed:@"yellow"];
    if (!_poi.note) {
        self.noteLabel.text = @"No notes for this location";
    } else {
        self.noteLabel.text = poi.note;
    }
    
    if (!_poi.category) {
        [self createUncategorizedLabel];
    } else {
//TODO: Create a category based on category data
    }
    
    [self updateFavoriteButton];
    
}


- (UILabel *) createUncategorizedLabel {
    CGFloat categoryStringSize = 12;
    
    //make a string with the appropriate text
    NSMutableString *baseString = [[NSMutableString alloc] initWithString:@"No Category"];
    NSMutableAttributedString *mutableCategoryString = [[NSMutableAttributedString alloc] initWithString:baseString
                                                                                              attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:categoryStringSize],
                                                                                                           NSForegroundColorAttributeName : [UIColor blueColor]}];

    
    self.categoryLabel.backgroundColor = [UIColor clearColor];
    self.categoryLabel.layer.borderColor = [UIColor blueColor].CGColor;
    self.categoryLabel.layer.borderWidth = 1.0;
    self.categoryLabel.attributedText = mutableCategoryString;
    return self.categoryLabel;
}

#pragma mark - Detail View Buttons

- (void) navigateButtonPressed:(UIButton *)sender {
    
}

- (void) shareButtonPressed:(UIButton *)sender {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (self.poi.name) {
        [itemsToShare addObject:self.poi.name];
    }
    
    if (self.poi.note) {
        [itemsToShare addObject:self.poi.note];
    }
    
    if (itemsToShare.count > 0) {
        [self.delegate shareButtonPressedOnDetailView:self withSharedItems:itemsToShare];
    }
}

- (void) deleteButtonPressed:(UIButton *)sender {
    [self.delegate deleteButtonPressedOnDetailView:self];
}

- (void) favoriteButtonPressed:(UIButton *)sender {
    [self.delegate favoriteButtonPressedOnDetailView:self]; //could add completion hander and then update button when it completes
    [self updateFavoriteButton];
}

- (void) updateFavoriteButton {
    NSString *imageName;
    
    switch (self.poi.favoriteState) {
        case BLCPOIFavoriteStateLiked:
            imageName = kFavoriteStateImage;
            break;
            
        case BLCPOIFavoriteStateNotLiked:
            imageName = kUnfavoriteStateImage;
    }
    [self.favoriteButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
