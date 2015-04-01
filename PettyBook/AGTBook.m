//
//  AGTBook.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTBook.h"
#import "services.h"

@implementation AGTBook
@synthesize image = _image;
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
-(UIImage *)image{
    NSURL * urlImage = [NSURL URLWithString:self.urlImage];
    NSURL *url = [self urlOfCacheImageWidthURLImage:urlImage];
    NSData * data = [NSData dataWithContentsOfURL:url];
    if (data == nil){
        // Descargar la imagen
        [self downLoadPhotoWithURL:urlImage];
        return nil;
    }else{
        // Usar la imagen

        
        return [UIImage imageWithData:data];
    }
}

-(void)setImage:(NSString *)stringURLImage{

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
        UIImage *image = [UIImage imageWithData:data];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        NSNotification * n = [NSNotification notificationWithName:self.urlImage object:self];
        [nc postNotification:n];
        self.image = image;
        NSLog(@"La imagen se ha guardado correctamente en : %@",url);
    }
}

-(void)downLoadPhotoWithURL:(NSURL *)url{
    services * download = [services sharedServices];

    [download dowloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self saveOnCacheWithURLImage:url andData:data];

    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar la imagen");

        
    }];
}

@end
