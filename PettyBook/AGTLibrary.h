//
//  AGTLibrary.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTBook;
@interface AGTLibrary : NSObject
// Buscarémos todos los tags, y los introduciremos en este array de forma inteligente.
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) NSMutableArray *tagsBook;

@property (nonatomic) NSUInteger booksCount;
@property (nonatomic) NSUInteger tagsCount;

-(id) initWithBooks:(NSArray *)books;

-(NSUInteger)booksCountForTag:(NSString *)tag;
-(NSArray *)booksOfTag:(NSString *)tag;
-(AGTBook *) bookForTag:(NSString *)tag atIndex:(NSUInteger) index;
-(void)descriptionOfLibrary;
@end
