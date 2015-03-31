//
//  AGTBook.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTBook.h"

@implementation AGTBook
-(id) initWithTitle:(NSString *)title
            authors:(NSArray *)authors
               tags:(NSArray *)tags
           urlImage:(NSString *)urlImage
             urlPDF:(NSString *)urlPDF{
    if (self=[super init]) {
        _title = title;
        _authors = authors;
        _tags = tags;
        _urlImage = urlImage;
        _urlPDF = urlPDF;
    }
    return self;
}
-(id) initWithDictionary:(NSDictionary *)dict{
   return [self initWithTitle:[dict objectForKey:@"title"]
                      authors:[self extractFromJSONString:[dict objectForKey:@"authors"]]
                         tags:[self extractFromJSONString:[dict objectForKey:@"tags"]]
                     urlImage:[dict objectForKey:@"image_url"]
                       urlPDF:@"pdf_url"];
}
-(NSArray *)extractFromJSONString:(NSString *)elements{
    NSArray * arr = [elements componentsSeparatedByString:@", "];
    return arr;
}
@end
