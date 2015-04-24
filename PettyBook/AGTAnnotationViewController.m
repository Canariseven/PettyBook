//
//  AGTAnnotationViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 17/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTAnnotationViewController.h"
#import "AGTTakeImageViewController.h"
#import "AGTAnnotations.h"
#import "AGTPhoto.h"
#import "AGTBook.h"
#import "AGTLocation.h"
#import "AGTMapSnapShot.h"
#import "AGTMapLocationViewController.h"

#import "AGTMapSnapShot.h"

@interface AGTAnnotationViewController ()

@end

@implementation AGTAnnotationViewController
-(id)initWithAnnotation:(AGTAnnotations *)annotation{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _annotation = annotation;
         if (self) _isPresented = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startObservingSnapshot];
    [self sincronizeView];
 
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeImage:)];
    [self.imageAnnotation addGestureRecognizer:tapImage];
    self.imageAnnotation.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapMap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeSnapShot:)];
    [self.mapSnapShotAnnotation addGestureRecognizer:tapMap];
    self.mapSnapShotAnnotation.userInteractionEnabled = YES;
    if (self.mapSnapShotAnnotation.image == nil) {
        self.mapSnapShotAnnotation.image = [UIImage imageNamed:@"clearMap"];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopObservingSnapshot];
    [self saveDatas];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sincronizeView{
    self.imageBook.image = self.annotation.book.photo.image;
    self.titleBook.text = [NSString stringWithFormat:@"  Nota para el libro: %@",self.annotation.book.title];
    self.imageAnnotation.image = self.annotation.photo.image;
    if (self.imageAnnotation.image == nil) {
        self.imageAnnotation.image = [UIImage imageNamed:@"clearPhoto"];
    }
    if (self.mapSnapShotAnnotation.image == nil) {
        self.mapSnapShotAnnotation.image = [UIImage imageNamed:@"clearMap"];
    }
    
    self.textAnnotation.text = self.annotation.text;
    self.photoView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.photoView.layer.borderWidth = 3;
    self.mapSnapShotView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mapSnapShotView.layer.borderWidth = 3;
 
}

-(void)takeImage:(UITapGestureRecognizer *)tapGesture{
    if (self.annotation.photo == nil) {
        self.annotation.photo = [AGTPhoto photoWithImageURL:nil context:self.annotation.managedObjectContext];
    }
    AGTTakeImageViewController *tVC = [[AGTTakeImageViewController alloc]initWithPhoto:self.annotation.photo];
    [self presentViewController:tVC animated:YES completion:nil];
}

-(void)takeSnapShot:(UITapGestureRecognizer *)tapGesture{
    if (self.annotation.location.latitudeValue == 0.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GPS NO ACTIVO" message:@"Si desea añadir una localización debe de activar el gps" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alert show];
    }else{
        AGTMapLocationViewController * mVC = [[AGTMapLocationViewController alloc]initWithLocation:self.annotation.location];
        [self presentViewController:mVC animated:YES completion:nil];
    }
}

-(void)saveDatas{
    self.annotation.photo.image = self.imageAnnotation.image;
    self.annotation.location.mapSnapShot.image = self.mapSnapShotAnnotation.image;
    self.annotation.text = self.textAnnotation.text;
}


#pragma mark -  KVO
-(void) startObservingSnapshot{
    [self.annotation addObserver:self
                      forKeyPath:[NSString stringWithFormat:@"%@.%@.%@",AGTAnnotationsRelationships.location,AGTLocationRelationships.mapSnapShot,AGTMapSnapShotAttributes.snapShotData]
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
}

-(void) stopObservingSnapshot{
    [self.annotation removeObserver:self
                         forKeyPath:[NSString stringWithFormat:@"%@.%@.%@",AGTAnnotationsRelationships.location,AGTLocationRelationships.mapSnapShot,AGTMapSnapShotAttributes.snapShotData]];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    UIImage *img = self.annotation.location.mapSnapShot.image;
    self.mapSnapShotAnnotation.userInteractionEnabled = YES;
    if (!img) {
        img = [UIImage imageNamed:@"noSnapshot.png"];
        self.mapSnapShotAnnotation.userInteractionEnabled = NO;
    }
    self.mapSnapShotAnnotation.image = img;
    
}

@end
