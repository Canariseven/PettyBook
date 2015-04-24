//
//  AGTDataSourceAndDelegateTableView.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTDataSourceAndDelegateTableView.h"
#import "AGTLibraryTableViewCell.h"
#import "AGTLibraryTableViewCell.h"
#import "AGTBook.h"
#import "services.h"
#import "AGTLibraryTableViewController.h"
#import "AGTPhoto.h"
#import "AGTTags.h"
@interface AGTDataSourceAndDelegateTableView()
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation AGTDataSourceAndDelegateTableView
-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle controller:(AGTLibraryTableViewController *)controller{
    if (self = [super init]) {
        _controller = controller;
        self.fetchedResultsController = aFetchedResultsController;
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AGTLibraryTableViewCell cellHeight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AGTTags *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    return tag.books.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.fetchedResultsController.fetchedObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    NSArray *arr = [tag.books allObjects];
    AGTBook *book = [arr objectAtIndex:indexPath.row];
    AGTLibraryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_LIBRARY];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"AGTLibraryTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CELL_FOR_LIBRARY];
        cell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_LIBRARY];
    }
    // Configurarla
    // Sincronizar model (personaje) -> vista(celda)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (book.photo.image == nil){
        cell.book = book;
        [cell setupKVO];
        cell.imageBook.image = [UIImage imageNamed:@"iconBook"];
    }else{
        cell.imageBook.image = book.photo.image;
    }
    cell.titleBook.text = book.title;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    NSArray *arr = [tag.books allObjects];
    AGTBook *book = [arr objectAtIndex:indexPath.row];
    

    if ([self.delegate respondsToSelector:@selector(dataSourceAndDelegateTableView:didSelectBook:)]) {
        [self.delegate dataSourceAndDelegateTableView:self didSelectBook:book];
    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSNotification *n = [[NSNotification alloc]initWithName:SELECT_BOOK_CHANGED object:book userInfo:nil];
    [nc postNotification:n];
    
}


-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book{
    AGTBookViewController * bookVC = [[AGTBookViewController alloc] initWithModel:book];
    bookVC.delegate = self.controller;
    [self.controller.navigationController pushViewController:bookVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *labelTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,15, tableView.frame.size.width, 15)];
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    NSString *text = tag.tags;
    if ([tag.tags isEqualToString:NAME_TAG_FAVOURITES]){
        text =[tag.tags stringByReplacingOccurrencesOfString:@"00" withString:@""];
    }
    labelTitle.text =[text  uppercaseString];
    labelTitle.font = [UIFont fontWithName:@"AvenirNext" size:18.0];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.baselineAdjustment = UIBaselineAdjustmentNone;
    labelTitle.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.18 alpha:1];
    [view addSubview:labelTitle];
    return view;
}



@end
