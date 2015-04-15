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

@interface AGTLibraryTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) UITableViewStyle style;
@property (nonatomic, strong) AGTDataSourceAndDelegateTableView * controllerOfTable;

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController style:(UITableViewStyle)aStyle;
@end
