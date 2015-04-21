//
//  AGTLibraryTableViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLibraryTableViewController.h"
#import "AGTBook.h"
#import "AGTLibrary.h"
#import "AGTLibraryTableViewCell.h"
#import "AGTDataSourceAndDelegateTableView.h"
#import "AGTTags.h"


@interface AGTLibraryTableViewController()
// Creo la propiedad para el controlador de la tableView

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) AGTBook *book;
@end

@implementation AGTLibraryTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController style:(UITableViewStyle)aStyle{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _fetchedResultsController = fetchedResultsController;
        _style = aStyle;
        self.controllerOfTable = [[AGTDataSourceAndDelegateTableView alloc]initWithFetchedResultsController:self.fetchedResultsController style:UITableViewStylePlain controller:self];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.toolbar.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self.controllerOfTable;
    self.tableView.dataSource = self.controllerOfTable;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoPettyBook"]];
    self.searchBar.delegate = self;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupKVO];
}
-(void)dealloc{
    [self tearDownKVO];
    
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self searchOnStack:searchBar.text];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}

-(void)searchOnStack:(NSString *)stringSearch{
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:[AGTTags entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTTagsAttributes.tags ascending:YES]];
    
    NSPredicate *predicateTitle=[NSPredicate predicateWithFormat:@"books.title contains [cd] %@",stringSearch];
    NSPredicate *predicateTags=[NSPredicate predicateWithFormat:@"tags contains [cd] %@",stringSearch];

    req.predicate =[NSCompoundPredicate orPredicateWithSubpredicates:@[predicateTitle, predicateTags]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:req managedObjectContext:self.fetchedResultsController.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    self.controllerOfTable.fetchedResultsController = self.fetchedResultsController;
    [self.tableView reloadData];
}

-(void)setupKVO{
    NSArray *keys = [AGTTags observableKeyNames];
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:0];
    
    for (NSString *key in keys) {
        [tag addObserver:self
              forKeyPath:key
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:NULL];
    }
    
}
-(void) tearDownKVO{
    NSArray * keys = [AGTTags observableKeyNames];
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:0];
    for (NSString *key in keys) {
        [tag removeObserver:self
                   forKeyPath:key];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    if ([object isKindOfClass:[AGTTags class]]) {
        NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
