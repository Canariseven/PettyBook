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
@protocol AGTDataSourceAndDelegateTableViewDelegate <NSObject>

@optional
-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book;

@end


@interface AGTDataSourceAndDelegateTableView : NSObject <UITableViewDataSource,UITableViewDelegate, AGTDataSourceAndDelegateTableViewDelegate>
@property (nonatomic, strong) AGTLibrary *model;
@property (nonatomic, weak) id<AGTDataSourceAndDelegateTableViewDelegate> delegate;
@property (nonatomic, strong) UIViewController *controller;
-(id)initWithModel:(AGTLibrary *)model controller:(UIViewController *)controller;
@end
