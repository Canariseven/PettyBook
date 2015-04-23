#import "AGTTags.h"

@interface AGTTags ()

// Private interface goes here.

@end

@implementation AGTTags
+(NSArray *)observableKeyNames{
    return @[AGTTagsAttributes.tags, AGTTagsRelationships.books];
}
+(instancetype)tagWithTag:(NSString *)tag book:(AGTBook *)book context:(NSManagedObjectContext *)context{
    // Buscamos el tag
    AGTTags *t = [AGTTags searchTag:tag context:context];
    // Vinculamos el libro
    if (book != nil) {
        [t addBooksObject:book];
    }
    // Devolvemos
    return t;
}




+(AGTTags *)searchTag:(NSString *)tag context:(NSManagedObjectContext *)context{
    // Primero realizamos la búsqueda en la entida
    
    NSFetchRequest *fq = [[NSFetchRequest alloc]initWithEntityName:[AGTTags entityName]];
    fq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTTagsAttributes.tags ascending:YES]];
    fq.predicate = [NSPredicate predicateWithFormat:@"tags == %@ ",tag];
    NSError *error;
    NSArray * arr = [context executeFetchRequest:fq error:&error];
    
    AGTTags * eTag;
    
    if (arr.count) {
        // Existe la utilizamos
        eTag = [arr lastObject];
    }else{
        // No existe la creamos
        eTag= [self insertInManagedObjectContext:context];
    }
    // Añadimos el tag
    eTag.tags = tag;
    return eTag;
}

+(void)searchTagFavourite:(NSManagedObjectContext *)context andInserBook:(AGTBook *)book actionDelete:(BOOL)delete{
    NSFetchRequest * req = [[NSFetchRequest alloc]initWithEntityName:[AGTTags entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTTagsAttributes.tags ascending:YES]];
    req.predicate = [NSPredicate predicateWithFormat:@"tags == %@",NAME_TAG_FAVOURITES];
    NSFetchedResultsController *resq = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                           managedObjectContext:context
                                                                             sectionNameKeyPath:nil
                                                                                      cacheName:nil];
    NSError *error;
    [resq performFetch:&error];
    
    
    if (resq.fetchedObjects.count == 0) {
        // No se ha encontrado tenemos que crearlo y añadir el libro
        [self tagWithTag:NAME_TAG_FAVOURITES book:book context:context];
        
    }else{
        // Existe añadimos el libro
        AGTTags * favouriteTag = resq.fetchedObjects.lastObject;
        
        if (delete == YES) {
            [favouriteTag removeBooksObject:book];
        }else{
            [favouriteTag addBooksObject:book];
        }


    }
}
-(NSString *)normalizedName{
    return [self.tags capitalizedString];
}


-(NSComparisonResult)compare:(AGTTags *)other{
    static NSString *fav = @"Favorite";
    if ([[self normalizedName] isEqualToString:[other normalizedName]]) {
        return NSOrderedSame;
    }else if ([[self normalizedName] isEqualToString:fav]){
        return NSOrderedAscending;
    }else if ([[other normalizedName] isEqualToString:fav]) {
        return NSOrderedDescending;
    }else{
        return [self.tags compare:[other normalizedName]];
    }
}

@end
