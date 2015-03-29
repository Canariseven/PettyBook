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
@interface AGTDataSourceAndDelegateTableView : NSObject <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) AGTLibrary *model;

-(id)initWithModel:(AGTLibrary *)model;
@end
