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
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backView.center = self.center;
        self.backView.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor clearColor];
        [self addVerticalLine];
    }
    return self;
}
- (void)awakeFromNib {
    self.backView.center = self.center;
    self.backView.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor clearColor];
    [self addVerticalLine];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight{
    return 160;
}
-(void) addVerticalLine{
    UIView * verticalLine = [[UIView alloc]initWithFrame:CGRectMake(100-1, 0, 2, 140)];
    verticalLine.backgroundColor = [UIColor blackColor];
    verticalLine.alpha = 0.8;
    [self.backView addSubview:verticalLine];
}
@end
