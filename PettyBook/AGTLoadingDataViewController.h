//
//  servicesWeb.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 31/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//


@import Foundation;
@import UIKit;
#define URL_LIBRARY_JSON @"https://t.co/K9ziV0z3SJ"
@interface AGTLoadingDataViewController : UIViewController
@property (nonatomic, strong) NSArray *books;
-(id) initWithWindow:(UIWindow *)window;
@end
