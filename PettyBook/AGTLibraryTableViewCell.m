//
//  AGTLibraryTableViewCell.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLibraryTableViewCell.h"
#import "AGTPhoto.h"
#import "AGTBook.h"
@interface AGTLibraryTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation AGTLibraryTableViewCell


- (void)awakeFromNib {
    self.backView.center = self.center;
    self.backView.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor clearColor];
    [self addVerticalLine];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    // Initialization code
}
-(void)dealloc{
    [self tearDownKVO];
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



#pragma mark - KVO
-(void) setupKVO{
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;

    NSArray * keys = [AGTPhoto observableKeyNames];
    for (NSString *key in keys) {
        [self.book.photo addObserver:self
                     forKeyPath:key
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:NULL];
    }
    
}

-(void) tearDownKVO{
    NSArray * keys = [AGTPhoto observableKeyNames];
    for (NSString *key in keys) {
        [self.book.photo removeObserver:self
                   forKeyPath:key];
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath
ofObject:(id)object
change:(NSDictionary *)change
context:(void *)context{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    if ([object isKindOfClass:[AGTPhoto class]]) {
        [self tearDownKVO];
        self.imageBook.image = self.book.photo.image;
    }
    
    
}
@end