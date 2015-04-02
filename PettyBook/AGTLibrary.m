//
//  AGTLibrary.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTLibrary.h"
#import "AGTBook.h"

@implementation AGTLibrary

@synthesize tags = _tags;
// Por cada libro que entra, buscamos sus tags y introducimos cada tag en un Array, el libro se introduce en otro Array que corresponde al Tag.
-(id) initWithBooks:(NSArray *)books{
    if (self = [super init]){
        _books = books;
        _tags = @[].mutableCopy;
        [self setTags];
        // ESTO DEBERIA SER POR KVO
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(isFavouriteChanged:) name:ISFAVOURITE_CHANGED object:self.book];
        
    }
    return self;
}

-(void)setTags{
    for (AGTBook * book in self.books) {
        for (NSString * tag in book.tags) {
            NSUInteger pos =[self indexForTag:tag];
            if (pos == -1) {
                [self.tags addObject:tag];
            }
        }
    }
    NSSortDescriptor *descri = [[NSSortDescriptor alloc]initWithKey:@"description" ascending:YES];
    NSArray * sorted = [self.tags sortedArrayUsingDescriptors:@[descri]];
    self.tags = sorted.mutableCopy;
    
    [self addSectionFavourite];
    
}

-(void)addSectionFavourite{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[ ud objectForKey:SAVE_BOOK_HOW_FAVOURITE]];
    if (arr.count == 0) {
        NSString *str = SECTION_FAVOURITES;
        [self.tags insertObject:str atIndex:0];
    }
}

-(void)dealloc{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}
-(void)isFavouriteChanged:(NSNotification *)notification{
    // Pillamos el libro a cambiar
    self.book = [notification object];
    
    // Actualizamos a tabla
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSNotification *n = [NSNotification notificationWithName:RELOAD_SECTION_FAVOURITES object:self];
    [nc postNotification:n];
}

-(NSUInteger)indexForTag:(NSString *)tag{
    for (int i = 0; i<self.tags.count; i++) {
        if ([tag isEqualToString:self.tags[i]]) {
            return i;
        }
    }
    return -1;
}


-(NSUInteger)booksCountForTag:(NSString *)tag{
    return [self booksOfTag:tag].count;
}

-(NSArray *)booksOfTag:(NSString *)tag{
    NSMutableArray *array = @[].mutableCopy;
    for (AGTBook *book in self.books) {
        for (NSString *t in book.tags) {
            if ([t isEqualToString:tag]) {
                [array addObject:book];
            }
        }
    }
    return array;
}

-(AGTBook *) bookForTag:(NSString *)tag atIndex:(NSUInteger) index{
    AGTBook *book;
    NSArray * arr = [self booksOfTag:tag];
    if (arr.count == 0) {
        return nil;
    }
    book = arr[index];
    return book;
}




@end
