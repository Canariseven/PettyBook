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
    static NSString *cellId = @"bookCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        // La tenemos que crear nosotros desde cero
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellId];
    }
    // Configurarla
    // Sincronizar model (personaje) -> vista(celda)
    cell.imageView.image = [UIImage imageNamed:book.urlImage];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.urlPDF;
    // Devolverla
    return cell;

}

@end
