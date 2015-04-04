//
//  AGTPDFReaderViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//


@import UIKit;
@class AGTBook;
@interface AGTPDFReaderViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet UIWebView * pdfView;
-(id) initWithModel:(AGTBook *)model;
@end
