//
//  AGTMapLocationViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 19/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@class AGTLocation;
@interface AGTMapLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
-(id)initWithLocation:(AGTLocation *)location;
- (IBAction)saveMap:(id)sender;

@end
