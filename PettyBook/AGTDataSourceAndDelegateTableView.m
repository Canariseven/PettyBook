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
@implementation AGTDataSourceAndDelegateTableView
-(id)initWithModel:(AGTLibrary *)model controller:(UIViewController *)controller{
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
    NSURL *urlImage = [NSURL URLWithString:book.urlImage];
    cell.imageBook.image = [self searchImageOnCacheWidthURLImage:urlImage
                                                       indexPath:indexPath
                                                            Cell:cell
                                                    andTableView:tableView];
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



-(void)downLoadPhotoWithURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath Cell:(AGTLibraryTableViewCell *)cell andTableView:(UITableView *)tableView{
    services * download = [services sharedServices];
    cell.activityIndicator.hidden = NO;
    [cell.activityIndicator startAnimating];
    
    [download dowloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self saveOnCacheWithURLImage:url andData:data];
        [self reloadRowWithIndexPath:indexPath cell:cell tableView:tableView andData:data urlImage:url];
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar la imagen");
        [self reloadRowWithIndexPath:indexPath cell:cell tableView:tableView andData:nil urlImage:url];

    }];
}

-(void)reloadRowWithIndexPath:(NSIndexPath *)indexPath cell:(AGTLibraryTableViewCell *)cell tableView:(UITableView *)tableView andData:(NSData *)data urlImage:(NSURL *)urlImage{
    cell.activityIndicator.hidden = YES;
    [cell.activityIndicator stopAnimating];
        if (data == nil){
            // Devolver "No-image"
            UIImage *image = [UIImage imageNamed:@"iconBook"];
            cell.imageBook.image = image;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            // Guardamos la imagen
            [self saveOnCacheWithURLImage:urlImage andData:data];
            // Devolver la image
            UIImage *image = [UIImage imageWithData:data];
            cell.imageBook.image = image;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        }
}

-(UIImage *)searchImageOnCacheWidthURLImage:(NSURL *)urlImage indexPath:(NSIndexPath *)indexPath Cell:(AGTLibraryTableViewCell *)cell andTableView:(UITableView *)tableView{
    NSURL *url = [self urlOfCacheImageWidthURLImage:urlImage];
    NSData * data = [NSData dataWithContentsOfURL:url];
    if (data == nil){
        // Descargar la imagen
        [self downLoadPhotoWithURL:urlImage indexPath:indexPath Cell:cell andTableView:tableView];
        UIImage *image = [UIImage imageNamed:@"iconBook"];
        return image;
    }else{
        // Usar la imagen
        UIImage *image = [UIImage imageWithData:data];
        cell.activityIndicator.hidden = YES;
        [cell.activityIndicator stopAnimating];
        return image;
    }
}

-(NSURL *)urlOfCacheImageWidthURLImage:(NSURL *)urlImage{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    NSString * nameImage = [urlImage lastPathComponent];
    url = [url URLByAppendingPathComponent:nameImage];
    return url;
}

-(void)saveOnCacheWithURLImage:(NSURL *)urlImage andData:(NSData *)data{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    NSString * nameImage = [urlImage lastPathComponent];
    url = [url URLByAppendingPathComponent:nameImage];
    BOOL rc = [data writeToURL:url atomically:NO];
    if (rc == NO) {
        NSLog(@"Fallo al cargar las imagenes");
    }else{
        NSLog(@"La imagen se ha guardado correctamente en : %@",url);
    }
}

@end
