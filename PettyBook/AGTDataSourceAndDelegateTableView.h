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

#define PDF_CHANGED @"pdf_changed"
@import CoreData;

@class  AGTLibrary;
@class AGTBook;
@class AGTDataSourceAndDelegateTableView;
@class AGTLibraryTableViewController;
@class  AGTBookViewController;
@protocol AGTDataSourceAndDelegateTableViewDelegate <NSObject>

@optional
-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book;

@end


@interface AGTDataSourceAndDelegateTableView : AGTCoreDataTableViewController <UITableViewDelegate, AGTDataSourceAndDelegateTableViewDelegate>
@property (nonatomic, weak) id<AGTDataSourceAndDelegateTableViewDelegate> delegate;
@property (nonatomic, strong) AGTLibraryTableViewController *controller;
-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle controller:(AGTLibraryTableViewController *)controller;
@end


