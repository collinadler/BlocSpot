//
//  BLCPOIListTableViewController.m
//  BlocSpot
//
//  Created by Collin Adler on 12/5/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCPOIListTableViewController.h"
#import "BLCMapViewController.h"
#import "BLCDataSource.h"
#import "BLCRecentPOITableViewCell.h"

@interface BLCPOIListTableViewController ()


@end

@implementation BLCPOIListTableViewController

- (id) init {
    self = [super init];
    
    if (self) {
        //custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"BlocSpot";
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                  target:self
                                                                                  action:@selector(searchPressed:)];
    
    UIImage *filterImage = [UIImage imageNamed:@"filter"];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:filterImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(filterPressed:)];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:filterButton, searchButton, nil]];

    UIImage *mapImage = [UIImage imageNamed:@"map"];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithImage:mapImage
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(mapPressed:)];
    self.navigationItem.leftBarButtonItem = mapButton;
    
    [self.tableView registerClass:[BLCRecentPOITableViewCell class]
           forCellReuseIdentifier:@"recentPOICell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger numberOfSections = 0;
    
    if ([[BLCDataSource sharedInstance] favoritePointsOfInterest].count > 0) {
        numberOfSections++;
    }
    if ([[BLCDataSource sharedInstance] recentPointsOfInterest].count > 0) {
        numberOfSections++;
    }

    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return [[BLCDataSource sharedInstance] recentPointsOfInterest].count;
    } else if (section == 1) {
        return [[BLCDataSource sharedInstance] favoritePointsOfInterest].count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        BLCRecentPOITableViewCell *recentCell = [tableView dequeueReusableCellWithIdentifier:@"recentPOICell"
                                                                                forIndexPath:indexPath];
        recentCell.pointOfInterest = [BLCDataSource sharedInstance].recentPointsOfInterest[indexPath.row];
        return recentCell;
    } else {
        BLCRecentPOITableViewCell *recentCell = [tableView dequeueReusableCellWithIdentifier:@"recentPOICell"
                                                                                forIndexPath:indexPath];
        recentCell.pointOfInterest = [BLCDataSource sharedInstance].favoritePointsOfInterest[indexPath.row];
        return recentCell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Recent Points of Interest";
    } else {
        return @"Favorite Points of Interest";
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCPointOfInterest *poi = [BLCDataSource sharedInstance].recentPointsOfInterest[indexPath.row];
    return [BLCRecentPOITableViewCell heightForRecentPOI:poi width:CGRectGetWidth(self.view.frame)];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation Buttons

- (void) mapPressed:(UIBarButtonItem *)sender {
    BLCMapViewController *mapVC = [BLCMapViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mapVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
