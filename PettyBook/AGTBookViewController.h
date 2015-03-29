//
//  AGTBookViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

@import UIKit;
@class  AGTBook;
@interface AGTBookViewController : UIViewController<UISplitViewControllerDelegate>
@property (nonatomic, strong) AGTBook *model;
-(id)initWithModel:(AGTBook *)model;

- (IBAction)tagsButton:(id)sender;
- (IBAction)readBookButton:(id)sender;
- (IBAction)favouriteButton:(id)sender;

@end
