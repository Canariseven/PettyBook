#import "AGTBook.h"
#import "AGTPhoto.h"
#import "AGTPdf.h"
#import "AGTAnnotations.h"
#import "Utils.h"
#import "services.h"
#import "AGTTags.h"
@interface AGTBook ()

// Private interface goes here.

@end

@implementation AGTBook
@synthesize isFavourite = _isFavourite;
#pragma mark - Properties 

-(void)setIsFavourite:(BOOL)isFavourite{
    if (isFavourite) {
        // Añadimos el tag
        [AGTTags searchTagFavourite:self.managedObjectContext andInserBook:self actionDelete:NO];
    }else{
        // Quitamos el tag
        [AGTTags searchTagFavourite:self.managedObjectContext andInserBook:self actionDelete:YES];
    }
    _isFavourite = isFavourite;
//    [self saveOrDeleteStatusOnUserDefault];
//    [self createNotificactionFavouriteChanged];
}

+(instancetype) bookWithDict:(NSDictionary *)dict
                      context:(NSManagedObjectContext *)context{
    AGTBook * book = [self insertInManagedObjectContext:context];
    book.title = [dict objectForKey:@"title"];
    book.authors = [dict objectForKey:@"authors"];
    [self extractFromJSONString:[dict objectForKey:@"tags"] book:book context:context];
    book.photo = [AGTPhoto photoWithImageURL:[dict objectForKey:@"image_url"] context:context];
//    book.pdf = [AGTPdf pdfWithPdfURL:[dict objectForKey:@"pdf_url"] context:context];
    book.annotations = nil;
    return book;
}


#pragma mark - Utils
+(void)extractFromJSONString:(NSString *)elements book:(AGTBook *)book context:(NSManagedObjectContext *)context{
    NSArray * arr = [elements componentsSeparatedByString:@", "];
    for (NSString *tag in arr) {
        [AGTTags tagWithTag:tag book:book context:context];
    }
    
}
@end
