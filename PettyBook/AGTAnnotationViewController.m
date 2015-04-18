//
//  AGTAnnotationViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 17/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTAnnotationViewController.h"
#import "AGTAnnotations.h"
#import "AGTPhoto.h"
#import "AGTBook.h"
@interface AGTAnnotationViewController ()

@end

@implementation AGTAnnotationViewController
-(id)initWithAnnotation:(AGTAnnotations *)annotation{
        NSString *nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        nibName = @"AGTAnnotationViewControllerIPhoneSize";
    }else{
        nibName = @"AGTAnnotationViewControllerIPhoneSize";
    }
    if (self = [super initWithNibName:nibName bundle:nil]) {
        _annotation = annotation;
         if (self) _isPresented = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sincronizeView];
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.annotation.photo.image = self.imageAnnotation.image;
    self.annotation.text = self.textAnnotation.text;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sincronizeView{
    self.imageBook.image = self.annotation.book.photo.image;
    self.titleBook.text = [NSString stringWithFormat:@"Nota para el libro: %@",self.annotation.book.title];
    self.imageAnnotation.image = self.annotation.photo.image;
    self.textAnnotation.text = self.annotation.text;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editButton:(id)sender {
}

- (IBAction)saveButton:(id)sender {
}
@end
