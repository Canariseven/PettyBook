//
//  AGTPDFReaderViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTPDFReaderViewController.h"
#import "AGTBook.h"
#import "services.h"
#import "Utils.h"
@interface AGTPDFReaderViewController ()
@property (nonatomic, strong) AGTBook * model;
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
    [self sincronizeView];
    
}

-(void)sincronizeView{
    NSString *name = [self.model.urlPDF lastPathComponent];
    [self checkPDFonCacheWithName:name];
}

-(void)downloadPDFWithURL:(NSURL *)url andName:(NSString *)name{
[services dowloadDataWithURL:url
         statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
             [self loadAndSaveData:data withName:name];
         } failure:^(NSURLResponse *response, NSError *error) {
             
         }];
}
-(void)checkPDFonCacheWithName:(NSString *)name{
    NSData *data = [Utils dataOfCacheDirectoryWithNameFile:name];
    if (data == nil) {
        // llamamos al servicio
        NSURL * url = [NSURL URLWithString:self.model.urlPDF];
        [self downloadPDFWithURL:url andName:name];
    }else{
        // lo cargamos
        [self loadPDFOnWebView:data];
    }
}
-(void)loadAndSaveData:(NSData *)data withName:(NSString *)name{
    BOOL rc = [Utils saveOnCacheWithData:data andName:name];
    if (rc == YES) {
        [self loadPDFOnWebView:data];
    }else{
        //volvemos a descargar el archivo o presentamos error
    }
}
-(void)loadPDFOnWebView:(NSData *)pdfData{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
//    NSURL *targetURL = [NSURL fileURLWithPath:path];
//    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:targetURL];
    [self.pdfView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
