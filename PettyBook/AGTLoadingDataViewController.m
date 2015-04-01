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
    [self loadJSONAndCreateLibrary];
    
    
    
    
    
}

- (void)loadJSONAndCreateLibrary{
    NSURL * url =  [NSURL URLWithString:URL_LIBRARY_JSON];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept"    : @"application/json"};
    // Inicialización de la sesión
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    // Tarea de gestión de datos
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (HTTPResponse.statusCode == 200) {
            if (!error) {
                if (data != nil) {
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
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.activityIndicator stopAnimating];
                            self.activityIndicator.hidden = YES;
                            [self presentViewControllersWithLibrary:self.lib];
                        });
                        
                    }else{
                        NSLog(@"Fallo JSON");
                    }
                }
            }else{
                NSLog(@"Fallo al recibir el json");
            }
        }else{
            NSLog(@"Fallo servidor");
        }
    }];
    [dataTask resume];
    
    // Modo sincrono.
    //    NSError *error;
    //    NSData *data= [NSURLConnection sendSynchronousRequest:request
    //                                        returningResponse:&response error:&error];
    //
    //
    //    if (data != nil) {
    //        NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
    //                                                               options:kNilOptions
    //                                                                 error:&error];
    //        if (JSONObjects != nil) {
    //            NSMutableArray * arr = [[NSMutableArray alloc]init];
    //            for (NSDictionary *dict in JSONObjects){
    //                AGTBook *book = [[AGTBook alloc] initWithDictionary:dict];
    //                [arr addObject:book];
    //            }
    //            self.books = arr;
    //            AGTLibrary * library = [[AGTLibrary alloc] initWithBooks:self.books];
    //            self.lib = library;
    //            return nil;
    //        }
    //        return error;
    //    }
    //    return error;
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
