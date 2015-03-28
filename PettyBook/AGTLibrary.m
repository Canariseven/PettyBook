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
        _tagsBook = @[].mutableCopy;
        [self setTags];
    }
    return self;
}

-(void)setTags{
    for (AGTBook * book in self.books) {
        for (NSString * tag in book.tags) {
            NSUInteger pos =[self indexForTag:tag];
            if (pos == -1) {
                [self.tags addObject:tag];
                pos = self.tags.count;
            }
            [self insertBook:book forIndex:pos];
        }
    }
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
    NSUInteger posTag = [self indexForTag:tag];
    if (posTag != -1) {
        NSArray *arr = [self.tagsBook objectAtIndex:posTag];
        return arr;
    }else{
        return nil;
    }
}

-(void)insertBook:(AGTBook *)book forIndex:(NSUInteger)index{
    NSMutableArray *arr;
    
    if ((self.tagsBook.count <= index)){
        arr = @[book].mutableCopy;
        [self.tagsBook addObject:arr];
    }else{
        arr = [self.tagsBook objectAtIndex:index];
        [arr addObject:book];
    }
}

-(AGTBook *) bookForTag:(NSString *)tag atIndex:(NSUInteger) index{
    AGTBook *book;
    NSArray * arr = [self booksOfTag:tag];
    book = arr[index];
    return book;
}

-(void)descriptionOfLibrary{
    for (int i = 0; i<self.tags.count; i++) {
        NSLog(@"Tag %@ =>",self.tags[i]);
        for (AGTBook *book in self.tagsBook[i]) {
            NSLog(@"Libros: %@ titulo: %@",book , book.title);
        }
        NSLog(@"\n");
    }
}




@end
