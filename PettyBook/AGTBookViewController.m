//
//  AGTBookViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTBookViewController.h"
#import "AGTBook.h"
#import "AGTTagsDataSourceTableView.h"
#import "AGTTagTableViewCell.h"
#import "AGTPDFReaderViewController.h"
#import "ReaderViewController.h"
#import "Utils.h"
#import "services.h"
#import "AGTPhoto.h"
#import "AGTAnnotationsCollectionViewController.h"
#import "AGTAnnotations.h"
@interface AGTBookViewController ()<ReaderViewControllerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageBook;
@property (weak, nonatomic) IBOutlet UIButton *tagsButton;
@property (weak, nonatomic) IBOutlet UIButton *readBookButton;
@property (weak, nonatomic) IBOutlet UIButton *favouriteBook;
@property (weak, nonatomic) IBOutlet UIView *backBookForRadius;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backBookView;
@property (weak, nonatomic) IBOutlet UIView *macroView;
@property (weak, nonatomic) IBOutlet UIImageView * viewIcon;
@property (nonatomic, strong) AGTTagsDataSourceTableView *DT;
@property (nonatomic, strong) UILabel *numberOfTags;
@property (nonatomic, strong) UIView *circle;
@property (weak, nonatomic) IBOutlet UIView *readerButtonContentView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) UILabel *labelTitle;
@property (nonatomic, weak) UILabel *labelAuthors;
@property (nonatomic, weak) UILabel *titleAndAuthor;
@property BOOL openTableViewTag;
@end

@implementation AGTBookViewController
-(id)initWithModel:(AGTBook*)model{
    NSString *nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        nibName = @"AGTBookViewController";
    }else{
        nibName = @"AGTBookIphoneViewController";
    }
    
    if (self = [super initWithNibName:nibName bundle:nil]) {
        _model = model;
        self.title = model.title;
        _DT = [[AGTTagsDataSourceTableView alloc] initWhithBook:self.model];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGPoint center = CGPointMake(self.view.center.x, self.view.center.y);
    self.backBookForRadius.center = center;
    self.activityIndicator.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.tableView.dataSource = self.DT;
    
    [self settingsOfViews];
    [self sincronizeDataOfView];
    [self animateViewBook];
    [self addGestureBookImage];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    
}

-(void)addGestureBookImage{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(readBookButton:)];
    [self.imageBook addGestureRecognizer:tap];
    self.imageBook.userInteractionEnabled = YES;
}
-(void)sincronizeDataOfView{
    self.readerButtonContentView.transform = CGAffineTransformMakeRotation(M_PI + M_PI_2/2);
    [self titleAndAuthorOnNavigationBar];
    [self.tableView reloadData];
    [self checkButtonColor];
    if (self.model.photo.image !=nil){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageBook.image = self.model.photo.image;
        });
    }else{
        [self setupKVO];
    }
    self.numberOfTags.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.model.tags.count];
    [self animateImage];
    [self animateCircleTag];
}

-(void)checkButtonColor{
    if (self.model.isFavourite == NO){
        self.favouriteBook.backgroundColor = [UIColor clearColor];
    }else{
        self.favouriteBook.backgroundColor = [UIColor colorWithHue:0.53 saturation:0.79 brightness:0.70 alpha:1];
    }
}


#pragma mark - IBACTIONS
- (IBAction)tagsButton:(id)sender {
    if (self.openTableViewTag == NO) {
        // ABRIR
        [self animateTableView:(self.tableView.frame.size.height)];
        self.openTableViewTag = YES;
    }else{
        // Cerrar
        [self animateTableView:1];
        self.openTableViewTag = NO;
    }
}

- (IBAction)readBookButton:(id)sender {
    AGTPDFReaderViewController * pdfView = [[AGTPDFReaderViewController alloc]initWithModel:self.model];
    [self.navigationController pushViewController:pdfView animated:YES];
    //    [self alertShow];
    
}

- (IBAction)favouriteButton:(id)sender {
    
    self.model.isFavourite = !self.model.isFavourite;
    
    [self checkButtonColor];
    if ([self.delegate respondsToSelector:@selector(bookViewControllerDelegate:didSelectFavouriteBook:)]) {
        [self.delegate bookViewControllerDelegate:self didSelectFavouriteBook:self.model];
    }
}

- (IBAction)commentsButton:(id)sender {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(320, 281);
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    NSFetchedResultsController *frq = [AGTAnnotations searcAnnotationsWithBook:self.model];
    AGTAnnotationsCollectionViewController * aCV = [[AGTAnnotationsCollectionViewController alloc]initWithFetchedResultsController:frq layout:layout andBook:self.model];
    aCV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:aCV animated:YES];
}

#pragma mark - DELEGATE
#pragma mark - UISplitViewControllerDelegate
-(void) splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    // Averiguar si la tabla se ve o no
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        // La tabla está oculta y cuelga del botón
        // Ponemos ese botón en mi barra de navegación
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }else{
        // Se muestra la tabla: oculto el botón de la barra de navegación
        self.navigationItem.leftBarButtonItem = nil;
    }
}

#pragma mark - AGTDataSourceAndDelegateTableViewDelegate
-(void)dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book{
    // Al cambiar de libro borro el obserador de la notificacion anterior
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:self.model.title object:self.model];
    self.model = book;
    self.DT.book = self.model;
    self.title = self.model.title;
    [self sincronizeDataOfView];
}



#pragma mark - NOTIFICACIONES
#pragma mark - Notification Title of BOOK  KVO
#pragma mark - KVO
-(void) setupKVO{
    NSArray * keys = [AGTPhoto observableKeyNames];
    for (NSString *key in keys) {
        
        [self.model.photo addObserver:self
                           forKeyPath:key
                              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                              context:NULL];
        
    }
    
}

-(void) tearDownKVO{
    NSArray * keys = [AGTPhoto observableKeyNames];
    for (NSString *key in keys) {
        if (self.model.photo.observationInfo != nil) {
            [self.model.photo removeObserver:self
                                  forKeyPath:key];
        };
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    if ([object isKindOfClass:[AGTPhoto class]]) {
        [self tearDownKVO];
        [self sincronizeDataOfView];
    }
    
}


-(void)reloadCellWithNotification:(NSNotification *)notifcation {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc removeObserver:self name:notifcation.name object:notifcation.object];
        [self sincronizeDataOfView];
        
    });
}


-(void)alertShow{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Lector PDF" message:@"Como desea ver el PDF?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"UIWebView",@"vfr-Reader", nil];
    
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        // Presento el webView
        AGTPDFReaderViewController * pdfView = [[AGTPDFReaderViewController alloc]initWithModel:self.model];
        [self.navigationController pushViewController:pdfView animated:YES];
        
    }else if (buttonIndex == 2){
        //        [self checkPDFonCacheWithName:[self.model.urlPDF lastPathComponent]];
        
    }
}



#pragma mark - Delegate ReaderViewController
-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//-(void)loadPDF{
//    NSString *filePath = [NSString stringWithFormat:@"%@",[Utils urlWithNameFile:[self.model.urlPDF lastPathComponent] andDirectory:NSCachesDirectory]];
//
//    filePath = [filePath stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
//    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
//
//    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
//
//    if (document != nil) // Must have a valid ReaderDocument object in order to proceed
//    {
//
//        ReaderViewController * readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
//
//        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
//
//        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//
//        [self presentViewController:readerViewController animated:YES completion:NULL];
//
//    }
//
//
//}

#pragma mark - Custom View
-(void) addNumberOfTagsCircleView{
    CGRect rect = CGRectMake(self.tagsButton.frame.size.width/2 + 7,
                             self.tagsButton.frame.origin.y + 3,
                             20, 20);
    self.circle = [[UIView alloc]initWithFrame:rect];
    self.circle.backgroundColor = [UIColor redColor];
    self.circle.layer.cornerRadius = 10;
    self.circle.layer.borderColor = [UIColor whiteColor].CGColor;
    self.circle.layer.borderWidth = 2;
    
    self.numberOfTags = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.numberOfTags setFont:[UIFont fontWithName:@"Arial" size:12]];
    self.numberOfTags.textAlignment = NSTextAlignmentCenter;
    self.numberOfTags.textColor = [UIColor whiteColor];
    [self.circle addSubview:self.numberOfTags];
    [self.tagsButton addSubview:self.circle];
    
}

-(void)settingsOfViews{
    self.openTableViewTag = NO;
    [self addNumberOfTagsCircleView];
    self.backBookView.layer.cornerRadius = 10;
    self.macroView.layer.cornerRadius = 10;
    [self addShadowToView:self.backBookForRadius radius:5 opacity:1];
    [self addShadowToView:self.macroView radius:20 opacity:0.5];
    self.tableView.frame = CGRectMake(self.imageBook.frame.size.width/2 + self.imageBook.frame.origin.x - [AGTTagTableViewCell cellWidth]/2 -20 ,
                                      -self.tableView.frame.size.height,
                                      [AGTTagTableViewCell cellWidth] + 40,
                                      self.imageBook.frame.size.height - 30);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)titleAndAuthorOnNavigationBar{
    [self.labelAuthors removeFromSuperview];
    [self.labelTitle removeFromSuperview];
    [self.titleAndAuthor removeFromSuperview];
    self.labelTitle.frame = CGRectMake(0,0, 200, 15);
    self.labelTitle.text = self.model.title;
    self.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.minimumScaleFactor = 0.1;
    self.labelTitle.baselineAdjustment = UIBaselineAdjustmentNone;
    self.labelTitle.textColor = [UIColor colorWithHue:0.53 saturation:0.79 brightness:0.99 alpha:1];
    
    self.labelAuthors.frame = CGRectMake(0, 18, 200, 15);
    self.labelAuthors.text = self.model.authors;
    self.labelAuthors.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    self.labelAuthors.textAlignment = NSTextAlignmentCenter;
    self.labelAuthors.minimumScaleFactor = 0.5;
    self.labelAuthors.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.18 alpha:1];
    
    self.titleAndAuthor.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    [self.titleAndAuthor addSubview: self.labelTitle];
    [self.titleAndAuthor addSubview: self.labelAuthors];
    
    self.labelTitle.frame = CGRectMake( self.labelTitle.frame.origin.x, 0, 200, 15);
    [self.labelTitle sizeToFit];
    self.labelAuthors.frame = CGRectMake( self.labelAuthors.frame.origin.x, 18, 200, 15);
    [self.labelAuthors sizeToFit];
    self.navigationItem.titleView =  self.titleAndAuthor;
    [self animateTitleText: self.titleAndAuthor];
}


-(void)addShadowToView:(UIView *)view
                radius:(CGFloat)radius
               opacity:(CGFloat)opacity{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowRadius = radius;
    view.layer.shadowOpacity = opacity;
}

#pragma mark - Animations
-(void) animateTableView:(CGFloat)value {
    
    //    self.tableView.transform = CGAffineTransformMakeTranslation(1, 1);
    [UIView setAnimationRepeatCount:1];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.tableView.transform = CGAffineTransformMakeTranslation(1, value);
                     }
                     completion:nil];
    
}
-(void) animateImage {
    
    self.imageBook.alpha = 0;
    self.imageBook.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView setAnimationRepeatCount:1];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.imageBook.alpha = 1;
                         self.imageBook.transform = CGAffineTransformMakeScale(1, 1);
                     }
                     completion:nil];
}
-(void) animateCircleTag {
    
    self.circle.alpha = 0;
    self.circle.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView setAnimationRepeatCount:1];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.circle.alpha = 1;
                         self.circle.transform = CGAffineTransformMakeScale(1, 1);
                     }
                     completion:nil];
}
-(void) animateViewBook {
    
    self.viewIcon.transform = CGAffineTransformMakeTranslation(1, 1);
    [UIView setAnimationRepeatCount:1];
    [UIView animateWithDuration:1
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         
                         self.viewIcon.transform = CGAffineTransformMakeTranslation(1, 10);
                         
                     }
                     completion:nil];
}

-(void) animateTitleText:(UIView *)view {
    
    view.transform = CGAffineTransformMakeTranslation(100, 0);
    view.alpha = 0;
    [UIView setAnimationRepeatCount:1];
    [UIView animateWithDuration:0.7
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformMakeTranslation(0, 0);
                         view.alpha = 1;
                         
                     }
                     completion:nil];
}
@end
