//
//  AGTBook.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#define ISFAVOURITE_CHANGED @"isFavourite changed"
#define SAVE_BOOK_HOW_FAVOURITE @"saveFavouriteOnUserDefault"

@import Foundation;
@import UIKit;

@interface AGTBook : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSArray * authors;
@property (nonatomic, strong) NSMutableArray * tags;
@property (nonatomic, copy) NSString * urlImage;
@property (nonatomic, copy) NSString * urlPDF;
@property (nonatomic) BOOL  isFavourite;
@property (nonatomic, strong) UIImage *image;


-(id) initWithTitle:(NSString *)title
            authors:(NSArray *)authors
            tags:(NSMutableArray *)tags
           urlImage:(NSString *)urlImage
             urlPDF:(NSString *)urlPDF;

-(id) initWithDictionary:(NSDictionary *)dict;

@end
