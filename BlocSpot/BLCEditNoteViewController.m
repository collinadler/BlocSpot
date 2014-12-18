//
//  BLCEditNoteViewController.m
//  BlocSpot
//
//  Created by Collin Adler on 12/17/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCEditNoteViewController.h"
#import "BLCPointOfInterest.h"

@interface BLCEditNoteViewController ()

@property (nonatomic, strong) UITextField *noteTextField;
@property (nonatomic, strong) BLCPointOfInterest *poi;

@end

@implementation BLCEditNoteViewController

- (instancetype) initWithPOI:(BLCPointOfInterest *)pointOfInterest {
    self = [super init];
    if (self) {
        _poi = pointOfInterest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteTextField = [[UITextField alloc] init];
    self.noteTextField.placeholder = @"Edit POI Note Here";
    
    [self.view addSubview:self.noteTextField];
    
    UINavigationBar *myNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [self.view addSubview:myNav];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneButtonPressed:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(cancelButtonPressed:)];
    UINavigationItem *navigItem = [[UINavigationItem alloc] init];
    navigItem.rightBarButtonItem = doneButton;
    navigItem.leftBarButtonItem = cancelButton;
    myNav.items = [NSArray arrayWithObjects:navigItem, nil];

}

- (void) viewWillLayoutSubviews {
    self.noteTextField.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Helpers

- (void) cancelButtonPressed:(UIBarButtonItem *)cancelButton {
    NSLog(@"Cancel button hit");
    [self dismissViewControllerAnimated:YES completion:nil];
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
