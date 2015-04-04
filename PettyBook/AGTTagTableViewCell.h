//
//  AGTTagTableViewCell.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//


@import UIKit;
#define CELL_FOR_TAGS @"tagsCellID"
@interface AGTTagTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
+(CGFloat)cellWidth;
+(CGFloat)cellHeight;
@end
