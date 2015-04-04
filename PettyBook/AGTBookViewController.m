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
#import "AGTLibrary.h"
#import "AGTPDFReaderViewController.h"
#import "ReaderViewController.h"
#import "Utils.h"


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

@property BOOL openTableViewTag;
@end

@implementation AGTBookViewController
-(id)initWithModel:(AGTBook*)model{
    if (self = [super init]) {
        _model = model;
        _DT = [[AGTTagsDataSourceTableView alloc] initWhitArrayOfTags:self.model.tags];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tableView.dataSource = self.DT;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadCellWithNotification:) name:self.model.title object:nil];
    [nc addObserver:self selector:@selector(reloadButton:) name:RELOAD_SECTION_FAVOURITES object:nil];
    [self settingsOfViews];
    [self sincronizeDataOfView];
    [self animateViewBook];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

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
    
    
    //    self.tableView.transform = CGAffineTransformMakeTranslation(1, -(self.tableView.frame.size.height));
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void)sincronizeDataOfView{
    [self.tableView reloadData];
    [self checkButtonColor];
    if (self.model.image !=nil){
        self.imageBook.image = self.model.image;
    }else{
        
    }
    self.numberOfTags.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.model.tags.count];
    [self animateImage];
    [self animateCircleTag];
}

-(void)checkButtonColor{
    if (self.model.isFavourite == NO){
        self.favouriteBook.backgroundColor = [UIColor clearColor];
    }else{
        self.favouriteBook.backgroundColor = [UIColor blueColor];
    }
}
-(void)addShadowToView:(UIView *)view
                radius:(CGFloat)radius
               opacity:(CGFloat)opacity{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowRadius = radius;
    view.layer.shadowOpacity = opacity;
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

    [self alertShow];
    
}

- (IBAction)favouriteButton:(id)sender {
    
    if (self.model.isFavourite == YES){
        self.model.isFavourite = NO;
    }else{
        self.model.isFavourite = YES;
    }
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
    self.DT.tags = self.model.tags;
    [self sincronizeDataOfView];
}

#pragma mark - NOTIFICACIONES
#pragma mark - Notification Title of BOOK
-(void)reloadCellWithNotification:(NSNotification *)notifcation {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc removeObserver:self name:notifcation.name object:notifcation.object];
        [self sincronizeDataOfView];
        
    });
}

#pragma mark - Notification RELOAD_SECTION_FAVOURITES
-(void)reloadButton:(NSNotification *)notification{
    [self checkButtonColor];
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
-(void)alertShow{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Lector PDF" message:@"Como deséa ver el PDF?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"UIWebView",@"vfr-Reader", nil];
    
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        // Presento el webView
        AGTPDFReaderViewController * pdfView = [[AGTPDFReaderViewController alloc]initWithName:@"Reader"];
        [self.navigationController pushViewController:pdfView animated:YES];
        
    }else if (buttonIndex == 2){{
        NSString *filePath = [NSString stringWithFormat:@"%@",[Utils urlOfCacheWithNameFile:@"Reader.pdf"]];
        
        filePath = [filePath stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
        NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
        
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed
        {
            
            ReaderViewController * readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:readerViewController animated:YES completion:NULL];
            
        }
    }
        
    }
}

#pragma mark - Delegate ReaderViewController
-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
