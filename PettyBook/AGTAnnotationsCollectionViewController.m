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
#import "AGTDataSourceAndDelegateTableView.h"
#import "AGTBook.h"

@interface AGTAnnotationsCollectionViewController ()
@property (nonatomic, strong)UIImageView *backGround;
@property (nonatomic, strong)AGTBook *book;
@property (nonatomic)NSUInteger  annotationRow;
@end


@implementation AGTAnnotationsCollectionViewController

static NSString * const reuseIdentifier = @"annotationCell";
-(id)initWithFetchedResultsController:(NSFetchedResultsController *)resultsController layout:(UICollectionViewLayout *)layout andBook:(AGTBook *)book{
    if (self = [super initWithFetchedResultsController:resultsController layout:layout]) {
        _book = book;
        self.title = [NSString stringWithFormat:@"Anotaciones de %@",book.title];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.backGround.frame = frame;
    [self registerNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSNotificationCenter *n = [NSNotificationCenter defaultCenter];
    [n removeObserver:self];


}

-(void)registerNotification{
    NSNotificationCenter *n = [NSNotificationCenter defaultCenter];
    [n addObserver:self selector:@selector(bookDidChange:) name:SELECT_BOOK_CHANGED object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self addLongGestureToCell:cell];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AGTAnnotations * annotation = [self.fetchedResultsController objectAtIndexPath:indexPath];

    AGTAnnotationViewController * aVC = [[AGTAnnotationViewController alloc]initWithAnnotation:annotation];
    aVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:aVC animated:YES completion:nil];
}

-(void)addLongGestureToCell:(AGTAnnotationCollectionViewCell *)cell{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didLongPressCellToDelete:)];
    [cell addGestureRecognizer:longPress];
}

- (IBAction)didLongPressCellToDelete:(UILongPressGestureRecognizer*)gesture {
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];
    [self animationLongPressCellToDeleteWithIndexPath:indexPath];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        
        self.annotationRow = indexPath.row;
        UIAlertView *deleteAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Eliminar nota?"
                                    message:@"Deseas elminar esta nota¿?"
                                    delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Sí", nil];
        [deleteAlert show];
        
    }
}
-(void)animationLongPressCellToDeleteWithIndexPath:(NSIndexPath *)indexPath{
    AGTAnnotationCollectionViewCell * cell = (AGTAnnotationCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.3 animations:^{
        cell.transform = CGAffineTransformMakeScale(1.1, 1.1);
        cell.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
        cell.alpha = 0.7;
    }];
}
-(void)animationReturnNormalStateOfCellWithIndexPath:(NSIndexPath *)indexPath{
    AGTAnnotationCollectionViewCell * cell = (AGTAnnotationCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.3 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.backgroundColor = [UIColor clearColor];
        cell.alpha = 1;
    }];;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.annotationRow inSection:0];
    [self animationReturnNormalStateOfCellWithIndexPath:indexPath];
    if (buttonIndex == 1) {
        
        AGTAnnotations * annotation = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:annotation];
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

#pragma mark - Add Annotations

-(void) addNewAnnotation:(id)sender{
    AGTAnnotations *annotation = [AGTAnnotations annotationWithBook:self.book
                                                            context:self.fetchedResultsController.managedObjectContext];
    AGTAnnotationViewController * aVC = [[AGTAnnotationViewController alloc]initWithAnnotation:annotation];
    aVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:aVC animated:YES completion:nil];
}
#pragma mark - Notifications SELECT_BOOK_CHANGED
-(void)bookDidChange:(NSNotification *)notification{
    self.book = notification.object;
    self.fetchedResultsController = [AGTAnnotations searcAnnotationsWithBook:self.book];
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    self.title = [NSString stringWithFormat:@"Anotaciones de %@",self.book.title];
    [self.collectionView reloadData];
}
@end
