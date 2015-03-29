//
//  AGTTagTableViewCell.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTTagTableViewCell.h"
@interface AGTTagTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *backViewOfTag;

@end
@implementation AGTTagTableViewCell

- (void)awakeFromNib {
    // Initialization code
        self.backgroundColor = [UIColor clearColor];
    
    self.backViewOfTag.layer.cornerRadius = 26/2;
    self.backViewOfTag.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight{
    return 70;
}
+(CGFloat)cellWidth{
    return 181;
}
@end
