#import "_AGTAnnotations.h"

@interface AGTAnnotations : _AGTAnnotations {}
@property (nonatomic, readonly) BOOL hasLocation;
+(instancetype) annotationWithBook:(AGTBook *)book
                           context:(NSManagedObjectContext *)context;
+(NSFetchedResultsController *)searcAnnotationsWithBook:(AGTBook *)book;
@end
