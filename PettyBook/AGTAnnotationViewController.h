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
@property (weak, nonatomic) IBOutlet UIImageView *imageBook;
@property (weak, nonatomic) IBOutlet UILabel *titleBook;
@property (nonatomic) BOOL isPresented;

@property (weak, nonatomic) IBOutlet UIView *photoView;

@property (weak, nonatomic) IBOutlet UIView *mapSnapShotView;

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)saveButton:(id)sender;

@property (nonatomic, strong) AGTAnnotations * annotation;
-(id)initWithAnnotation:(AGTAnnotations *)annotation;

@end
