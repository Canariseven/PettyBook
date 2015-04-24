//
//  AGTTakeImageViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 19/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTTakeImageViewController.h"
#import "AGTPhoto.h"
#import "UIImage+Resize.h"

@interface AGTTakeImageViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation AGTTakeImageViewController


-(id)initWithPhoto:(AGTPhoto *)photo{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _photo = photo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.frontPhotoView.image = self.photo.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    __block UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width / screenScale, screenBounds.size.height / screenScale);
    
    
    // Hay que salir de aquí, androidero el último
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        img = [img resizedImage:screenSize interpolationQuality:kCGInterpolationMedium];
        [self.activityView startAnimating];
        self.activityView.hidden = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.frontPhotoView.image = img;
            self.photo.image = img;
            [self.activityView stopAnimating];
            self.activityView.hidden = true;
        });
    });
    [self dismissViewControllerAnimated:YES
                             completion:^{
                             }];
}

- (IBAction)cameraButton:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)trashButton:(id)sender {
    // Estado inicial
    CGRect oldBounds = self.frontPhotoView.bounds;
    
    // Eliminarla de la vista
    [UIView animateWithDuration:0.6
                          delay:0
                        options:0
                     animations:^{
                         
                         self.frontPhotoView.bounds = CGRectZero;
                         self.frontPhotoView.alpha = 0;
                         self.frontPhotoView.transform = CGAffineTransformMakeRotation(M_2_PI);
                         
                     } completion:^(BOOL finished) {
                         self.frontPhotoView.image = nil;
                         self.frontPhotoView.alpha = 1;
                         self.frontPhotoView.bounds = oldBounds;
                         self.frontPhotoView.transform = CGAffineTransformIdentity;
                     }];
    // eliminarla del modelo
    self.photo.image = nil;
}
@end
