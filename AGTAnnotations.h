#import "_AGTAnnotations.h"

@interface AGTAnnotations : _AGTAnnotations {}
+(instancetype) annotationWithBook:(AGTBook *)book
                           context:(NSManagedObjectContext *)context;
@end
