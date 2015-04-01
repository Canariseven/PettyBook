//
//  AGTLibraryTableViewCell.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELL_FOR_LIBRARY @"bookCellID"

@interface AGTLibraryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleBook;
@property (weak, nonatomic) IBOutlet UILabel *authorBook;
@property (weak, nonatomic) IBOutlet UIImageView *imageBook;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
+(CGFloat)cellHeight;

@end
