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
#import "AGTTags.h"
#import "AGTLibraryTableViewController.h"
#import "AGTBookViewController.h"
#import "services.h"
#import "Utils.h"
@interface AGTLoadingDataViewController()

@property (nonatomic, strong) AGTLibrary *lib;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic, strong) UIWindow *window;

@end
@implementation AGTLoadingDataViewController
-(id) initWithWindow:(UIWindow *)window andContext:(NSManagedObjectContext *)context{
    if (self= [super initWithNibName:nil bundle:nil]) {
        _window = window;
        _context = context;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSData * data = [self checkDataOnCache];
    if (data != nil) {
        [self libraryWithData:data];
    }else{
        [self dowloadLibrary];
    }
    
}

-(NSData *)checkDataOnCache{
    NSData * data = [Utils dataWithNameFile:@"books_readable.json" andDirectory:NSDocumentDirectory];
    return data;
}

-(void)dowloadLibrary{
    //    services * download = [services sharedServices];
    NSURL * url =  [NSURL URLWithString:URL_LIBRARY_JSON];
    [services downloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        BOOL result = [Utils saveWithData:data name:@"books_readable.json" andDirectory:NSDocumentDirectory];
        if (result == NO) {
            NSLog(@"No can save File on cache");
        }
        [self libraryWithData:data];
    } failure:^(NSURLResponse *response, NSError *error) {
        
        NSLog(@"Error solicitud: %@", response.description);
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

-(void)libraryWithData:(NSData *)data{
    NSError *err;
    id JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions
                                                       error:&err];
    
    if (JSONObjects != nil) {
        if ([JSONObjects isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in JSONObjects){
                [AGTBook bookWithDict:dict context:self.context];
            }
            [AGTTags tagWithTag:NAME_TAG_FAVOURITES book:nil context:self.context];
            // Hilo principal, para salir de inmediato
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.activityIndicator.hidden = YES;
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                    // Tipo tableta
                        [self configureForPad];
                }else{
                    //                 Tipo teléfon;
                    [self configureForPhone];
                }
                
            });
        }
        
    }else{
        NSLog(@"Fallo JSON");
    }
    
}
-(NSFetchedResultsController *)fetchedAllTags{
    NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:[AGTTags entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTTagsAttributes.tags ascending:YES selector:@selector(compare:)]];
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]initWithFetchRequest:req
                                                                        managedObjectContext:self.context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    return fc;
}

-(void)configureForPad{
    AGTLibraryTableViewController *tLibrary = [[AGTLibraryTableViewController alloc]initWithFetchedResultsController:[self fetchedAllTags] style:UITableViewStyleGrouped];
    UINavigationController *navLibrary = [[UINavigationController alloc] initWithRootViewController:tLibrary];
    
    // Cambiar el libro inicial por el que se cerró.
    //    NSString *str = SECTION_FAVOURITES;
    //    AGTBook * b= [library bookForTag:str atIndex:0];
    //    if (b == nil) {
    //        b = [library bookForTag:library.tags[1] atIndex:0];
    //    }
    
    NSFetchedResultsController *fc = [self fetchedAllTags];
    NSError *error;
    [fc performFetch:&error];
    AGTTags *tag =   fc.fetchedObjects.firstObject;
    AGTBook *b = [tag.books allObjects].firstObject;
    if (b==nil) {
        tag = fc.fetchedObjects[1];
        b = [tag.books allObjects].firstObject;
    }
    
    AGTBookViewController *book = [[AGTBookViewController alloc] initWithModel:b];
    UINavigationController *navBook = [[UINavigationController alloc] initWithRootViewController:book];
    
    UISplitViewController *split = [[UISplitViewController alloc]init];
    split.viewControllers = @[navLibrary,navBook];
    split.delegate = book;
    tLibrary.controllerOfTable.delegate = book;
    book.delegate = tLibrary;
    
    self.window.rootViewController = split;
    
}

-(void)configureForPhone{
    AGTLibraryTableViewController *tLibrary = [[AGTLibraryTableViewController alloc]initWithFetchedResultsController:[self fetchedAllTags] style:UITableViewStyleGrouped];
    UINavigationController *navLibrary = [[UINavigationController alloc] initWithRootViewController:tLibrary];
    tLibrary.controllerOfTable.delegate = tLibrary.controllerOfTable;
    
    self.window.rootViewController = navLibrary;
}

@end
