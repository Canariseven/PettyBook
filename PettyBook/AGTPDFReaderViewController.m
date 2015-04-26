//
//  AGTPDFReaderViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//
#import "AGTDataSourceAndDelegateTableView.h"
#import "AGTPDFReaderViewController.h"
#import "AGTBook.h"
#import "AGTPdf.h"
#import "services.h"
#import "Utils.h"
@interface AGTPDFReaderViewController ()
@property (nonatomic, strong) AGTBook * model;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation AGTPDFReaderViewController

-(id) initWithModel:(AGTBook *)model{
    if (self = [super initWithNibName:nil bundle:nil]){
        _model = model;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startObserving];
    [self sincronizeView];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(changePDFWithNotification:) name:SELECT_BOOK_CHANGED object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    [self stopObserving];
}

-(void)sincronizeView{
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    if (self.model.pdf.pdfData == nil) {
        [self.model.pdf downLoadPDF];
    }else{
        [self loadPDFOnWebView:self.model.pdf.pdfData];
    }
}




-(void)loadPDFOnWebView:(NSData *)pdfData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        [self.pdfView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePDFWithNotification:(NSNotification *)notification{
    [self stopObserving];
    self.model.pdf.pdfData = nil;
    [self.pdfView loadData:nil MIMEType:nil textEncodingName:nil baseURL:nil];
    self.model = notification.object;
    [self startObserving];
    [self sincronizeView];
}
#pragma mark -  KVO
-(void) startObserving{
    for (NSString *key in [AGTPdf observableKeyNames]) {
        [self.model.pdf addObserver:self
                         forKeyPath:key
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
    }
}

-(void) stopObserving{
    for (NSString *key in [AGTPdf observableKeyNames]) {
        [self.model.pdf removeObserver:self forKeyPath:key];
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    [self sincronizeView];
}




@end
