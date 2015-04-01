//
//  AGTDataSourceAndDelegateTableView.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTDataSourceAndDelegateTableView.h"
#import "AGTLibraryTableViewCell.h"
#import "AGTLibrary.h"
#import "AGTLibraryTableViewCell.h"
#import "AGTBook.h"
#import "AGTBookViewController.h"
#import "services.h"
#import "AGTLibraryTableViewController.h"
@interface AGTDataSourceAndDelegateTableView()
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation AGTDataSourceAndDelegateTableView
-(id)initWithModel:(AGTLibrary *)model controller:(AGTLibraryTableViewController *)controller{
    if (self=[super init]) {
        _model = model;
        _controller = controller;
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AGTLibraryTableViewCell cellHeight];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.model.tags[section];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model booksCountForTag:self.model.tags[section]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.tags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTBook * book = [self.model bookForTag:self.model.tags[indexPath.section] atIndex:indexPath.row];
    AGTLibraryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_LIBRARY];
    if (cell == nil) {
        // La tenemos que crear nosotros desde cero
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AGTLibraryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }else{
        cell.imageBook.image = nil;
    }
    // Configurarla
    // Sincronizar model (personaje) -> vista(celda)
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (book.image == nil){
        [cell.activityIndicator startAnimating];
        cell.activityIndicator.hidden = NO;
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(reloadCellWithNotification:) name:book.title object:nil];
        
    }else{
        cell.imageBook.image = book.image;
        [cell.activityIndicator stopAnimating];
        cell.activityIndicator.hidden = YES;
    }
    
    cell.titleBook.text = book.title;
    cell.authorBook.text = book.authors[0];
    // Devolverla
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTBook * book = [self.model bookForTag:self.model.tags[indexPath.section] atIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(dataSourceAndDelegateTableView:didSelectBook:)]) {
        [self.delegate dataSourceAndDelegateTableView:self didSelectBook:book];
    }
    
}
-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book{
    AGTBookViewController * bookVC = [[AGTBookViewController alloc] initWithModel:book];
    [self.controller.navigationController pushViewController:bookVC animated:YES];
}

-(void)reloadCellWithNotification:(NSNotification *)notifcation {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:notifcation.name object:notifcation.object];
    [self reloadRowCellWithNameNotif:notifcation.name];
    
}

-(void)reloadRowCellWithNameNotif:(NSString *)name{
    NSArray *array = self.controller.tableView.visibleCells;
    NSArray *arrIndex = self.controller.tableView.indexPathsForVisibleRows;
    NSUInteger index = 0;
    for (AGTLibraryTableViewCell *cell in array) {
        if ([cell.titleBook.text isEqualToString:name]) {
            // Introducir delay porque carga muy rápido y rompe (dos animaciones misma celda)
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [self.controller.tableView reloadRowsAtIndexPaths:@[arrIndex[index]] withRowAnimation:UITableViewRowAnimationNone];
            });
            
        }
        index ++;
    }
}


@end
