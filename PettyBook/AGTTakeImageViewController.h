//
//  AGTTakeImageViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 19/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTPhoto;
@interface AGTTakeImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backPhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *frontPhotoView;
@property (nonatomic, strong) AGTPhoto *photo;

-(id)initWithPhoto:(AGTPhoto *)photo;

- (IBAction)cameraButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)trashButton:(id)sender;

@end
