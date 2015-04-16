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
#import "AGTBookViewController.h"
#import "services.h"
#import "AGTLibraryTableViewController.h"
#import "AGTPhoto.h"
#import "AGTTags.h"
@interface AGTDataSourceAndDelegateTableView()
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation AGTDataSourceAndDelegateTableView
-(id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle controller:(AGTLibraryTableViewController *)controller{
    if (self = [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]) {
        _controller = controller;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *labelTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,15, tableView.frame.size.width, 15)];
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    labelTitle.text =[tag.tags  uppercaseString];
    labelTitle.font = [UIFont fontWithName:@"AvenirNext" size:18.0];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.baselineAdjustment = UIBaselineAdjustmentNone;
    labelTitle.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.18 alpha:1];
    [view addSubview:labelTitle];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    NSArray *arr = [tag.books allObjects];
    AGTBook *book = [arr objectAtIndex:indexPath.row];
    AGTLibraryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_LIBRARY];
    if (cell == nil) {
        // La tenemos que crear nosotros desde cero
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AGTLibraryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Configurarla
    // Sincronizar model (personaje) -> vista(celda)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (book.photo.image == nil){
        [cell.activityIndicator startAnimating];
        cell.activityIndicator.hidden = NO;
       //Recibimos notificación
        [self setupKVO:indexPath];
        
    }else{
        cell.imageBook.image = book.photo.image;
        [cell.activityIndicator stopAnimating];
        cell.activityIndicator.hidden = YES;
    }
    
    cell.titleBook.text = book.title;
//    cell.authorBook.text = book.authors[0];
    // Devolverla
    return cell;
}

-(void)checkFavourites{
    NSFetchRequest * req = [[NSFetchRequest alloc]initWithEntityName:[AGTTags entityName]];
    req.predicate = [NSPredicate predicateWithFormat:@"tags == %@",@"FAVORITOS"];
    NSFetchedResultsController *resq = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                           managedObjectContext:self.fetchedResultsController.managedObjectContext
                                                                             sectionNameKeyPath:nil
                                                                                        cacheName:nil];
    NSError *error;
    [resq performFetch:&error];
    
}


#pragma mark - KVO
-(void) setupKVO:(NSIndexPath *)indexPath{
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    NSArray *arr = [tag.books allObjects];
    AGTBook *book = [arr objectAtIndex:indexPath.row];
    
    NSArray * keys = [AGTPhoto observableKeyNames];
    for (NSString *key in keys) {
        [book.photo addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
    
}

-(void) tearDownKVO:(AGTPhoto *)photo{
    NSArray * keys = [AGTPhoto observableKeyNames];
    for (NSString *key in keys) {
        [photo removeObserver:self
                  forKeyPath:key];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    AGTPhoto *photo = object;
    [self tearDownKVO:photo];
    [self.tableView reloadData];
}
//-(NSIndexPath *)returnIndexPathOfBook:(AGTBook *)book{
//    NSIndexSet *indexes = [self.fetchedResultsController.fetchedObjects indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
//        AGTTags *s = (AGTTags*)obj;
//        NSRange range = [s.objectID.description rangeOfString: book.objectID.description];
//        return range.location != NSNotFound;
//    }];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexes.firstIndex inSection:0];
//    return indexPath;
//}

//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTTags * tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    NSArray *arr = [tag.books allObjects];
    AGTBook *book = [arr objectAtIndex:indexPath.row];
    

    if ([self.delegate respondsToSelector:@selector(dataSourceAndDelegateTableView:didSelectBook:)]) {
        [self.delegate dataSourceAndDelegateTableView:self didSelectBook:book];
    }
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    NSNotification *n = [[NSNotification alloc]initWithName:PDF_CHANGED object:book userInfo:nil];
//    [nc postNotification:n];
    
}
-(void) dataSourceAndDelegateTableView:(AGTDataSourceAndDelegateTableView *)dt didSelectBook:(AGTBook *)book{
    AGTBookViewController * bookVC = [[AGTBookViewController alloc] initWithModel:book];
    [self.controller.navigationController pushViewController:bookVC animated:YES];
}
//
//-(void)receivedNotification:(NSNotification *)notifcation {
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    [nc removeObserver:self name:notifcation.name object:notifcation.object];
//    [self reloadRowCellWithNameNotif:notifcation.name];
//    
//}
//
//-(void)reloadRowCellWithNameNotif:(NSString *)name{
//    NSArray *array = self.controller.tableView.visibleCells;
//    NSArray *arrIndex = self.controller.tableView.indexPathsForVisibleRows;
//    NSUInteger index = 0;
//    for (AGTLibraryTableViewCell *cell in array) {
//        if ([cell.titleBook.text isEqualToString:name]) {
//            // Introducir delay porque carga muy rápido y rompe (dos animaciones misma celda)
//            double delayInSeconds = 1.0;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *NSEC_PER_SEC));
//            dispatch_after(popTime, dispatch_get_main_queue(), ^{
//                [self.controller.tableView reloadRowsAtIndexPaths:@[arrIndex[index]] withRowAnimation:UITableViewRowAnimationNone];
//            });
//            
//        }
//        index ++;
//    }
//}


@end
