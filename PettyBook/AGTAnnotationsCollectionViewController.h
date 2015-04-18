//
//  AGTAnnotationsCollectionViewController.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 17/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTCoreDataCollectionViewController.h"
@class AGTBook;
@interface AGTAnnotationsCollectionViewController : AGTCoreDataCollectionViewController
-(id)initWithFetchedResultsController:(NSFetchedResultsController *)resultsController layout:(UICollectionViewLayout *)layout andBook:(AGTBook *)book;
@end
