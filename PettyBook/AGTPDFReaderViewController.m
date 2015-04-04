//
//  AGTPDFReaderViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTPDFReaderViewController.h"

@interface AGTPDFReaderViewController ()
@property (nonatomic, strong) NSData * pdfData;
@end

@implementation AGTPDFReaderViewController
-(id) initWithPDF:(NSData *)pdfData{
    if (self = [super initWithNibName:nil bundle:nil]){
        _pdfData = pdfData;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"201" ofType:@"pdf"];
//    NSURL *targetURL = [NSURL fileURLWithPath:path];
//    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:targetURL];
    
    [self.pdfView loadData:self.pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Create pdf path & url



// Load pdf in WebView




@end
