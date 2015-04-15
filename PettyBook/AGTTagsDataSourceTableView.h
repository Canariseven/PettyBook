//
//  AGTTagsDataSourceTableView.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

@import Foundation;
@import UIKit;
@class AGTBook;
@interface AGTTagsDataSourceTableView : NSObject<UITableViewDataSource>
@property (nonatomic, strong) AGTBook *book;
-(id)initWhithBook:(AGTBook *)book;
@end
