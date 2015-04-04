//
//  AGTLibraryTableViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//


@import UIKit;
@class AGTBook;
@class AGTLibrary;
@class AGTDataSourceAndDelegateTableView;
@interface AGTLibraryTableViewController : UIViewController
@property (nonatomic,strong) AGTLibrary *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) AGTDataSourceAndDelegateTableView * controllerOfTable;
-(id)initWihtModel:(AGTLibrary *)model;
@end
