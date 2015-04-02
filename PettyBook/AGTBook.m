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
               tags:(NSMutableArray *)tags
           urlImage:(NSString *)urlImage
             urlPDF:(NSString *)urlPDF{
    if (self=[super init]) {
        _title = title;
        _authors = authors;
        _tags = tags;
        _urlImage = urlImage;
        _urlPDF = urlPDF;
        _isFavourite = NO;
        [self searchBookInUserDefaultAndAddTag];
    }

    return self;
}

-(id) initWithDictionary:(NSDictionary *)dict{
   return [self initWithTitle:[dict objectForKey:@"title"]
                      authors:[self extractFromJSONString:[dict objectForKey:@"authors"]]
                         tags:[self extractFromJSONString:[dict objectForKey:@"tags"]].mutableCopy
                     urlImage:[dict objectForKey:@"image_url"]
                       urlPDF:@"pdf_url"];
}


#pragma mark - Properties
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
// Al cambiar el estado de favoritos añado o quito el Tag favoritos.
-(void)setIsFavourite:(BOOL)isFavourite{
    if (isFavourite) {
            // Añadimos el tag
            [self.tags addObject:@"Favoritos"];
        }else{
            // Quitamos el tag
            [self.tags removeLastObject];
        }
    _isFavourite = isFavourite;
    [self saveOrDeleteStatusOnUserDefault];
    [self createNotificactionFavouriteChanged];
}

#pragma mark - Cache Image

-(NSURL *)urlOfCacheImageWidthURLImage:(NSURL *)urlImage{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    NSString * nameImage = [urlImage lastPathComponent];
    url = [url URLByAppendingPathComponent:nameImage];
    return url;
    
}

-(void)saveOnCacheWithURLImage:(NSURL *)urlImage andData:(NSData *)data{
    
    NSURL *url = [self urlOfCacheImageWidthURLImage:urlImage];
    BOOL rc = [data writeToURL:url atomically:NO];
    if (rc == NO) {
        NSLog(@"Fallo al cargar las imagenes");
    }else{
        UIImage *image = [UIImage imageWithData:data];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        NSNotification * n = [NSNotification notificationWithName:self.title object:self];
        [nc postNotification:n];
        self.image = image;
        NSLog(@"La imagen se ha guardado correctamente en : %@",url);
    }
}

#pragma mark - Download images
-(void)downLoadPhotoWithURL:(NSURL *)url{
    services * download = [services sharedServices];
    
    [download dowloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self saveOnCacheWithURLImage:url andData:data];
        
    } failure:^(NSURLResponse *response, NSError *error) {
        
        NSLog(@"Error al cargar la imagen");
    }];
}

-(NSMutableArray *)loadFavouritesOfUserDefault{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[ ud objectForKey:SAVE_BOOK_HOW_FAVOURITE]];
    return arr;
}

-(void)saveOrDeleteStatusOnUserDefault{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[ ud objectForKey:SAVE_BOOK_HOW_FAVOURITE]];
    int i = [self searchTitleOnUserDefaul:arr];
    if ( i != -1) {
        [arr removeObjectAtIndex:i];
    }else{
       [arr addObject:self.title];
    }
    [ud setObject:arr forKey:SAVE_BOOK_HOW_FAVOURITE];
    
    // Sincronizo en segundo plano
    // [ud synchronize];
}

-(void)searchBookInUserDefaultAndAddTag{
    NSMutableArray *arr = [self loadFavouritesOfUserDefault];
    if ([self searchTitleOnUserDefaul:arr] != -1) {
        [self.tags addObject:@"Favoritos"];
        _isFavourite = YES;
    }
}
-(int)searchTitleOnUserDefaul:(NSMutableArray *)array{
    for (int i=0 ; i< array.count ; i++){
        if ([array[i] isEqualToString:self.title]) {
            return i;
        }
    }
    return -1;
}

#pragma mark - Utils
-(NSArray *)extractFromJSONString:(NSString *)elements{
    NSArray * arr = [elements componentsSeparatedByString:@", "];
    return arr;
}
-(void)createNotificactionFavouriteChanged{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSNotification * n = [NSNotification notificationWithName:ISFAVOURITE_CHANGED object:self];
    [nc postNotification:n];
}

@end
