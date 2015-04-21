//
//  AGTAnnotationsCollectionViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 17/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTAnnotationsCollectionViewController.h"
#import "AGTAnnotationCollectionViewCell.h"
#import "AGTAnnotationViewController.h"
#import "AGTAnnotations.h"
#import "AGTPhoto.h"
#import "AGTMapSnapShot.h"
#import "AGTLocation.h"

@interface AGTAnnotationsCollectionViewController ()
@property (nonatomic, strong)UIImageView *backGround;
@property (nonatomic, strong)AGTBook *book;
@end

@implementation AGTAnnotationsCollectionViewController

static NSString * const reuseIdentifier = @"annotationCell";
-(id)initWithFetchedResultsController:(NSFetchedResultsController *)resultsController layout:(UICollectionViewLayout *)layout andBook:(AGTBook *)book{
    if (self = [super initWithFetchedResultsController:resultsController layout:layout]) {
        _book = book;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    UINib *nib = [UINib nibWithNibName:@"AGTAnnotationCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.backGround = [[UIImageView alloc]initWithFrame:frame];
    self.backGround.image = [UIImage imageNamed:@"greyWood"];
    self.backGround.contentMode = UIViewContentModeScaleToFill;
    

    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *addAnnotation = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                                                                  action:@selector(addNewAnnotation:)];
    self.navigationItem.rightBarButtonItem = addAnnotation;
    [self.view insertSubview:self.backGround belowSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.backGround.frame = frame;
}

#pragma mark <UICollectionViewDataSource>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AGTAnnotationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    AGTAnnotations * annotation = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.photoAnnotation.image = annotation.photo.image;
    cell.textAnnotation.text = annotation.text;
    cell.mapSnapShot.image = annotation.location.mapSnapShot.image;
    if (annotation.photo.image == nil) {
        cell.photoAnnotation.image = [UIImage imageNamed:@"clearPhoto"];
    }
    if (annotation.location.mapSnapShot.image == nil) {
        cell.mapSnapShot.image = [UIImage imageNamed:@"clearMap"];
    }
    // Configure the cell
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.timeStyle = NSDateFormatterMediumStyle;
    cell.creationDateLabel.text =[fmt stringFromDate:annotation.creationDate];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AGTAnnotations * annotation = [self.fetchedResultsController objectAtIndexPath:indexPath];
    AGTAnnotationViewController * aVC = [[AGTAnnotationViewController alloc]initWithAnnotation:annotation];
    aVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController: aVC animated: YES completion: nil];
}

-(void) addNewAnnotation:(id)sender{

    
    
    AGTAnnotations *annotation = [AGTAnnotations annotationWithBook:self.book
                                                            context:self.fetchedResultsController.managedObjectContext];
    
    AGTAnnotationViewController * aVC = [[AGTAnnotationViewController alloc]initWithAnnotation:annotation];
    aVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController: aVC animated: YES completion: nil];
//    [self.navigationController pushViewController:aVC animated:YES];
}

@end
