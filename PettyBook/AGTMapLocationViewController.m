//
//  AGTMapLocationViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 19/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTMapLocationViewController.h"
#import "AGTLocation.h"
@interface AGTMapLocationViewController ()
@property (nonatomic, strong)AGTLocation *location;
@end

@implementation AGTMapLocationViewController
-(id)initWithLocation:(AGTLocation *)location{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _location = location;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView addAnnotation:self.location];
    MKCoordinateRegion big = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 2000000, 2000000);
    [self.mapView setRegion:big];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    MKCoordinateRegion small = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 500, 500);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setRegion:small animated:YES];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
