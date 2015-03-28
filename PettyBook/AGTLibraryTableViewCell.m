//
//  AGTLibraryTableViewCell.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLibraryTableViewCell.h"

@interface AGTLibraryTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation AGTLibraryTableViewCell

- (void)awakeFromNib {
    self.backView.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight{
    return 318;
}

@end
