//
//  BLCResultsTableViewController.h
//  BlocSpot
//
//  Created by Collin Adler on 12/7/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kResultCellIdentifier = @"resultCellID";

@interface BLCResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *mapSearchResults;

@end
