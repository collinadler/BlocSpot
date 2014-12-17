//
//  BLCPOIMapDetailView.h
//  BlocSpot
//
//  Created by Collin Adler on 12/10/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLCPointOfInterest, BLCPOIMapDetailView;

typedef NS_ENUM(NSInteger, BLCPOIFavoriteState) {
    BLCPOIFavoriteStateNotLiked = 0,
    BLCPOIFavoriteStateLiked    = 1,
};

@protocol BLCPOIMapDetailViewDelegate <NSObject>

//detail view delegate methdos
- (void) favoriteButtonPressedOnDetailView:(BLCPOIMapDetailView *)detailView;
- (void) navigateButtonPressedOnDetailView:(BLCPOIMapDetailView *)detailView;
- (void) shareButtonPressedOnDetailView:(BLCPOIMapDetailView *)detailView withSharedItems:(NSArray *)sharedItems;
- (void) deleteButtonPressedOnDetailView:(BLCPOIMapDetailView *)detailView;

@end

@interface BLCPOIMapDetailView : UIView

@property (nonatomic, strong) BLCPointOfInterest *poi;
@property (nonatomic, weak) id <BLCPOIMapDetailViewDelegate> delegate;
@property (nonatomic, assign) BLCPOIFavoriteState favoriteButtonState;

@end
