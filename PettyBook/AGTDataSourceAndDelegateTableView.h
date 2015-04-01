//
//  AGTDataSourceAndDelegateTableView.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class  AGTLibrary;
@class AGTBook;
@class AGTDataSourceAndDelegateTableView;
@class AGTLibraryTableViewController;
@protocol AGTDataSourceAndDelegateTableViewDelegate <NSObject>

@optional
-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book;

@end


@interface AGTDataSourceAndDelegateTableView : NSObject <UITableViewDataSource,UITableViewDelegate, AGTDataSourceAndDelegateTableViewDelegate>
@property (nonatomic, strong) AGTLibrary *model;
@property (nonatomic, weak) id<AGTDataSourceAndDelegateTableViewDelegate> delegate;
@property (nonatomic, strong) AGTLibraryTableViewController *controller;
-(id)initWithModel:(AGTLibrary *)model controller:(AGTLibraryTableViewController *)controller;
@end
