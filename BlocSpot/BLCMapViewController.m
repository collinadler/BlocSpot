//
//  BLCMapViewController.m
//  BlocSpot
//
//  Created by Collin Adler on 12/4/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "BLCMapViewController.h"
#import "BLCPOIListTableViewController.h"
#import "BLCSearchViewController.h"
#import "BLCResultsTableViewController.h"
#import "BLCCustomAnnotation.h"

@interface BLCMapViewController () <MKMapViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate, UITableViewDelegate>

@property (nonatomic, strong) UISearchController *searchController;

//our secondary search results table view
@property (nonatomic, strong) BLCResultsTableViewController *resultsTableController;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation BLCMapViewController {
    MKLocalSearchResponse *results;
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
                                                                    target:searchButton
                                                                    action:@selector(filterPressed:)];
        
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:filterButton, searchButton, nil]];
    
    UIImage *listImage = [UIImage imageNamed:@"list"];
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithImage:listImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(listPressed:)];
    self.navigationItem.leftBarButtonItem = listButton;
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
    
    CLLocationCoordinate2D userCoordinate = CLLocationCoordinate2DMake(41.908291, -87.626445);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCoordinate, 9000, 9000);
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.region = region;
    self.mapView.showsPointsOfInterest = NO;
    self.mapView.delegate = self;
        
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Overrides

//because we don't need the search controller until we press the search button, override the getter method to lazy load it when we press the nav button
- (UISearchController *)searchController {
    if (!_searchController) {

        _resultsTableController = [[BLCResultsTableViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = YES;
        _searchController.searchBar.delegate = self;
        
        //we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
        self.resultsTableController.tableView.delegate = self;

    }
    return _searchController;
}

#pragma mark - UISearchBarDelegate

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchController setActive:NO];
    
    MKMapItem *item = results.mapItems[indexPath.row];
    
    BLCCustomAnnotation *customAnnotation = [[BLCCustomAnnotation alloc] initWithLocation:item.placemark.coordinate title:item.name];
    [self.mapView addAnnotation:customAnnotation];
    
    [self.mapView setCenterCoordinate:customAnnotation.coordinate animated:YES];
}

#pragma mark - Navigation Buttons

- (void) listPressed:(UIBarButtonItem *)sender {
    BLCPOIListTableViewController *poiVC = [BLCPOIListTableViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:poiVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void) searchPressed:(UIBarButtonItem *)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating Delegate

//update the results array based on the searach text
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchController.searchBar.text;
    request.region = self.mapView.region; //this is an optional bounding geographic region, which we've set to the current mapview's region
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //show the activity indcator while searching
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        results = response;
        
        BLCResultsTableViewController *tableController = (BLCResultsTableViewController *)self.searchController.searchResultsController;
        tableController.mapSearchResults = response.mapItems;
        [tableController.tableView reloadData];
    }];
}

#pragma mark - MapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BLCCustomAnnotation class]]) { // if this is my custom annotation class
        BLCCustomAnnotation *customAnnotation = (BLCCustomAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotation"];
        
        if (annotationView == nil) {
            //this calls the 'annotationView' method in our custom BLCCustomAnnotation class
            annotationView = customAnnotation.annotationView;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    } else {
        return nil;
    }
}

@end




