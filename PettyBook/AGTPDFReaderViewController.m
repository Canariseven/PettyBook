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
@property (nonatomic, copy) NSString * name;
@end

@implementation AGTPDFReaderViewController

-(id) initWithName:(NSString *)name{
    if (self = [super initWithNibName:nil bundle:nil]){
        _name = name;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPDFOnWebViewWithName:self.name];
    
}
-(void)loadPDFOnWebViewWithName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"pdf"];
    filePath = [filePath stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    NSURL *targetURL = [NSURL fileURLWithPath:filePath];
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:targetURL];
    [self.pdfView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
