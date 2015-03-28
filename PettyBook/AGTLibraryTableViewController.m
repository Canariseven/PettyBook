//
//  AGTLibraryTableViewController.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLibraryTableViewController.h"
#import "AGTBook.h"
#import "AGTLibrary.h"
#import "AGTLibraryTableViewCell.h"
@implementation AGTLibraryTableViewController
-(id)initWihtModel:(AGTLibrary *)model{
    if(self = [super initWithNibName:nil bundle:nil]){
        _model = model;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor clearColor];
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
    }
    // Configurarla
    // Sincronizar model (personaje) -> vista(celda)
    cell.imageBook.image = [UIImage imageNamed:book.urlImage];
    cell.titleBook.text = book.title;
    cell.authorBook.text = book.authors[0];
    // Devolverla
    return cell;
}

@end
