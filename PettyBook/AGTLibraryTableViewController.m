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
#import "AGTDataSourceAndDelegateTableView.h"
@interface AGTLibraryTableViewController()
// Creo la propiedad para el controlador de la tableView
@property (nonatomic, strong) AGTDataSourceAndDelegateTableView * controllerOfTable;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

@end

@implementation AGTLibraryTableViewController
-(id)initWihtModel:(AGTLibrary *)model{
    if(self = [super initWithNibName:nil bundle:nil]){
        _model = model;
        _controllerOfTable = [[AGTDataSourceAndDelegateTableView alloc] initWithModel:model];
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self.controllerOfTable;
    self.tableView.dataSource = self.controllerOfTable;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor clearColor];
}


@end
