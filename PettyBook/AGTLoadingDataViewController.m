//
//  servicesWeb.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 31/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLoadingDataViewController.h"
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
            NSArray *arr = JSONObjects;
            BOOL datas = [self compareDatasOfCoreDataAndJsonDataWithAmountObjects:arr.count];
            if (!datas){
                for (NSDictionary *dict in JSONObjects){
                    [AGTBook bookWithDict:dict context:self.context];
                }
                
                // Guardo para evitar los objectID Temporales
                NSError *error;
                [self.context save:&error];
                [self jumpNextVC];
            }else{
                [self jumpNextVC];
            }
        }
    }else{
        NSLog(@"Fallo JSON");
    }
    
}

-(void)jumpNextVC{
    [AGTTags tagWithTag:NAME_TAG_FAVOURITES book:nil context:self.context];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            // Tipo tableta
            [self configureForPad];
        }else{
            // Tipo teléfono
            [self configureForPhone];
        }
        
    });
    
}
-(AGTBook *)checkLastBook{
    AGTBook *book;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud valueForKey:SAVE_LAST_BOOK];
    if (str.length != 0) {
      book = [self searchBookOnCoreDataWithObjecID:str];
    }
    return book;
}
-(AGTBook *)searchBookOnCoreDataWithObjecID:(NSString *)objecID{
    NSURL *urlObjectID = [NSURL URLWithString:objecID];
    NSManagedObjectID *objID = [[self.context persistentStoreCoordinator] managedObjectIDForURIRepresentation:urlObjectID];
    NSError *error;
    AGTBook *book = (AGTBook *)[self.context existingObjectWithID:objID error:&error];
    if (error != nil) {
        return nil;
    }
    return book;
}
-(BOOL)compareDatasOfCoreDataAndJsonDataWithAmountObjects:(NSUInteger)count{
    NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:[AGTTags entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTTagsAttributes.tags ascending:YES selector:@selector(compare:)]];
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]initWithFetchRequest:req
                                                                        managedObjectContext:self.context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSError *error;
    [fc performFetch:&error];
    NSArray *array =  fc.fetchedObjects;
    if (array.count < count) {
        return false;
    }else{
        return true;
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
    
    NSFetchedResultsController *fc = [self fetchedAllTags];
    NSError *error;
    [fc performFetch:&error];
    
    AGTTags *tag =   fc.fetchedObjects.firstObject;
    // Abrimos un libro
    AGTBook *b = [self checkLastBook];
    
    if (b == nil) {
        b = [tag.books allObjects].firstObject;
        if (b==nil) {
            tag = fc.fetchedObjects[1];
            b = [tag.books allObjects].firstObject;
        }
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
