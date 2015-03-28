//
//  AGTLibraryTableViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTBook;
@class AGTLibrary;
@interface AGTLibraryTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) AGTLibrary *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(id)initWihtModel:(AGTLibrary *)model;
@end
