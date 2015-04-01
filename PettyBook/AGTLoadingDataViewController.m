//
//  servicesWeb.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 31/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLoadingDataViewController.h"
#import "AGTLibrary.h"
#import "AGTBook.h"
#import "AGTLibraryTableViewController.h"
#import "AGTBookViewController.h"
#import "services.h"
@interface AGTLoadingDataViewController()
@property (nonatomic, strong) AGTLibrary *lib;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic, strong) UIWindow *window;
@end
@implementation AGTLoadingDataViewController
-(id) initWithWindow:(UIWindow *)window{
    if (self= [super initWithNibName:nil bundle:nil]) {
        _window = window;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    [self dowloadLibrary];
}

-(void)dowloadLibrary{
    services *serv = [[services alloc]init];
    NSURL * url =  [NSURL URLWithString:URL_LIBRARY_JSON];
    [serv dowloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *err;
        NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&err];
        if (JSONObjects != nil) {
            NSMutableArray * arr = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in JSONObjects){
                AGTBook *book = [[AGTBook alloc] initWithDictionary:dict];
                [arr addObject:book];
            }
            self.books = arr;
            AGTLibrary * library = [[AGTLibrary alloc] initWithBooks:self.books];
            self.lib = library;
            // Hilo principal, para salir de inmediato
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.activityIndicator.hidden = YES;
                [self presentViewControllersWithLibrary:self.lib];
            });
            
        }else{
            NSLog(@"Fallo JSON");
        }
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error solicitud: %@", response.description);
        NSLog(@"Error: %@", error.localizedDescription);
     }];
}


-(void)presentViewControllersWithLibrary:(AGTLibrary *)library{
    AGTLibraryTableViewController *tLibrary = [[AGTLibraryTableViewController alloc]initWihtModel:library];
    UINavigationController *navLibrary = [[UINavigationController alloc] initWithRootViewController:tLibrary];
    
    // Cambiar el libro inicial por el que se cerró.
    AGTBookViewController *book = [[AGTBookViewController alloc] initWithModel:library.books[0]];
    UINavigationController *navBook = [[UINavigationController alloc] initWithRootViewController:book];
    
    UISplitViewController *split = [[UISplitViewController alloc]init];
    split.viewControllers = @[navLibrary,navBook];
    split.delegate = book;
    tLibrary.controllerOfTable.delegate = book;
    self.window.rootViewController = split;
}
@end
