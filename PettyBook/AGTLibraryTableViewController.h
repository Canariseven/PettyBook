//
//  AGTLibraryTableViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

@import CoreData;
@import UIKit;
@class AGTBook;
@class AGTLibrary;
@class AGTDataSourceAndDelegateTableView;
#import "AGTBookViewController.h"

@interface AGTLibraryTableViewController : UIViewController <AGTBookViewControllerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) UITableViewStyle style;
@property (nonatomic, strong) AGTDataSourceAndDelegateTableView * controllerOfTable;

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController style:(UITableViewStyle)aStyle;
@end
