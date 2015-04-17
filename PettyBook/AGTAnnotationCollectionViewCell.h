//
//  AGTAnnotationCollectionViewCell.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 17/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTAnnotationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoAnnotation;
@property (weak, nonatomic) IBOutlet UIImageView *mapSnapShot;
@property (weak, nonatomic) IBOutlet UITextView *textAnnotation;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;

@end
