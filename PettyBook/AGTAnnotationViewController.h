//
//  AGTAnnotationViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 17/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTAnnotations;

@interface AGTAnnotationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageAnnotation;
@property (weak, nonatomic) IBOutlet UIImageView *mapSnapShotAnnotation;
@property (weak, nonatomic) IBOutlet UITextView *textAnnotation;

@property (nonatomic, strong) AGTAnnotations * annotation;
-(id)initWithAnnotation:(AGTAnnotations *)annotation;
- (IBAction)cancelButton:(id)sender;
- (IBAction)editButton:(id)sender;
- (IBAction)saveButton:(id)sender;

@end
