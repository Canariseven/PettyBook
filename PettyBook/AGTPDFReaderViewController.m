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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:targetURL];
    
//    NSURL * url = [Utils urlOfCacheWidthURL:[NSURL URLWithString:self.model.urlPDF]];
    
//    NSData * pdfData = [NSData dataWithContentsOfURL:url];
    [self.pdfView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
