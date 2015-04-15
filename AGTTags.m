#import "AGTTags.h"

@interface AGTTags ()

// Private interface goes here.

@end

@implementation AGTTags

+(instancetype)tagWithTag:(NSString *)tag book:(AGTBook *)book context:(NSManagedObjectContext *)context{
    // Buscamos el tag
    AGTTags *t = [AGTTags searchTag:tag context:context];
    // Vinculamos el libro
    [t addBooksObject:book];
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


@end
