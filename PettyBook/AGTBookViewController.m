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

@interface AGTBookViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageBook;
@property (weak, nonatomic) IBOutlet UIButton *tagsButton;
@property (weak, nonatomic) IBOutlet UIButton *readBookButton;
@property (weak, nonatomic) IBOutlet UIButton *favouriteBook;
@property (weak, nonatomic) IBOutlet UIView *backBookForRadius;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backBookView;
@property (weak, nonatomic) IBOutlet UIView *macroView;
@property (nonatomic, strong) AGTTagsDataSourceTableView *DT;
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
    
    self.openTableViewTag = NO;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.tableView.dataSource = self.DT;
    self.imageBook.image = [UIImage imageNamed:self.model.urlImage ];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) addNumberOfTagsCircleView{
    CGRect rect = CGRectMake(self.tagsButton.frame.size.width/2 + 7,
                             self.tagsButton.frame.origin.y + 3,
                             20, 20);
    
    UIView * circle = [[UIView alloc]initWithFrame:rect];
    circle.backgroundColor = [UIColor grayColor];
    circle.layer.cornerRadius = 10;
    circle.layer.borderColor = [UIColor whiteColor].CGColor;
    circle.layer.borderWidth = 2;
    
    UILabel * numberOfTags = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 20, 20)];
    numberOfTags.text = [NSString stringWithFormat:@"%d",self.model.tags.count];
    [circle addSubview:numberOfTags];
    [self.tagsButton addSubview:circle];
    
}

-(void)setupViews{
    [self addNumberOfTagsCircleView];
    
    self.backBookView.layer.cornerRadius = 10;
    self.macroView.layer.cornerRadius = 10;
    
    [self addShadowToView:self.backBookForRadius radius:5 opacity:1];
    [self addShadowToView:self.macroView radius:20 opacity:0.5];
    
    self.tableView.frame = CGRectMake(self.imageBook.frame.size.width/2 + self.imageBook.frame.origin.x - [AGTTagTableViewCell cellWidth]/2 -20 ,
                                      self.imageBook.frame.origin.y,
                                      [AGTTagTableViewCell cellWidth] + 40,
                                      self.imageBook.frame.size.height - 30);
    [self animateTableView:-(self.tableView.frame.size.height)];
}

-(void)addShadowToView:(UIView *)view
                radius:(CGFloat)radius
               opacity:(CGFloat)opacity{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowRadius = radius;
    view.layer.shadowOpacity = opacity;
}

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

- (IBAction)tagsButton:(id)sender {
    if (self.openTableViewTag == NO) {
        // ABRIR
        [self animateTableView:1];
        self.openTableViewTag = YES;
    }else{
        // Cerrar
        [self animateTableView:-(self.tableView.frame.size.height)];
        self.openTableViewTag = NO;
        
    }
    
}
-(void) animateTableView:(CGFloat)value {
    
//    self.tableView.transform = CGAffineTransformMakeTranslation(1, 1);
    [UIView setAnimationRepeatCount:1];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.tableView.transform = CGAffineTransformMakeTranslation(1, value);
                     }
                     completion:nil];
    
}

- (IBAction)readBookButton:(id)sender {
}

- (IBAction)favouriteButton:(id)sender {
}

#pragma mark - Utils

@end
