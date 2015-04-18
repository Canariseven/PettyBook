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
    if (self = [super initWithNibName:nil bundle:nil]) {
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addLabelToInfoWhitString:@"Insertar imagen..." toView:self.photoView bellowImageView:self.imageAnnotation];
    [self addLabelToInfoWhitString:@"Insertar Mapa..." toView:self.mapSnapShotView bellowImageView:self.mapSnapShotAnnotation];
}
-(void)sincronizeView{
    self.imageBook.image = self.annotation.book.photo.image;
    self.titleBook.text = [NSString stringWithFormat:@"  Nota para el libro: %@",self.annotation.book.title];
    self.imageAnnotation.image = self.annotation.photo.image;
    self.textAnnotation.text = self.annotation.text;
    self.photoView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.photoView.layer.borderWidth = 3;
    self.mapSnapShotView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mapSnapShotView.layer.borderWidth = 3;
 
}

-(void)addLabelToInfoWhitString:(NSString *)string toView:(UIView *)viewI bellowImageView:(UIImageView *)imageView{
    UILabel *label = [[UILabel alloc]init];
    [label setFont:[UIFont fontWithName:@"Arial" size:20]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = string;
    [label sizeToFit];
    [viewI insertSubview:label belowSubview:imageView];
    label.frame = CGRectMake(viewI.frame.size.width/2 - label.frame.size.width/4, viewI.frame.size.height/2 + label.frame.size.height/2, label.frame.size.width, label.frame.size.height);

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
