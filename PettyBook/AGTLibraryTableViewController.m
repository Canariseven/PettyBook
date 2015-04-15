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
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.toolbar.backgroundColor = [UIColor whiteColor];
    self.controllerOfTable = [[AGTDataSourceAndDelegateTableView alloc]initWithFetchedResultsController:self.fetchedResultsController style:self.style controller:self];
    self.tableView.delegate = self.controllerOfTable;
    self.tableView.dataSource = self.controllerOfTable;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoPettyBook"]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.tableView.backgroundColor = [UIColor clearColor];


    
}


//-(void)reloadSectionsWithNotif:(NSNotification *)notification{
//    self.controllerOfTable.model = notification.object;
//    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:0];
//    
//    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
//}


@end
