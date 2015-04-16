//
//  AGTDataSourceAndDelegateTableView.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AGTCoreDataTableViewController.h"
#import "AGTBookViewController.h"
@import CoreData;

@class  AGTLibrary;
@class AGTBook;
@class AGTDataSourceAndDelegateTableView;
@class AGTLibraryTableViewController;

@protocol AGTDataSourceAndDelegateTableViewDelegate <NSObject>

@optional
-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book;

@end


@interface AGTDataSourceAndDelegateTableView : UITableViewController <UITableViewDelegate, UITableViewDataSource ,AGTDataSourceAndDelegateTableViewDelegate>
@property (nonatomic, weak) id<AGTDataSourceAndDelegateTableViewDelegate> delegate;
@property (nonatomic, strong) AGTLibraryTableViewController *controller;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle controller:(AGTLibraryTableViewController *)controller;
@end
